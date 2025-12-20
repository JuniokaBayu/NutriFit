import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import '../utility/app_color.dart';
import '../utility/text_style.dart';

class BmiRecord {
  final int id; // ID unik untuk menghapus
  final DateTime fullDate;
  final String dateStr;
  final String bmi;
  final String category;
  final String height;
  final String weight;

  BmiRecord(this.id, this.fullDate, this.dateStr, this.bmi, this.category, this.height, this.weight);
}

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<BmiRecord> _allRecords = [];
  List<BmiRecord> _filteredRecords = [];
  bool _isLoading = true;

  // Pagination & Filter Variables
  int _currentPage = 0;
  final int _pageSize = 10;
  DateTime? _selectedFilterDate;

  @override
  void initState() {
    super.initState();
    _loadBmiHistory();
  }

  Future<void> _loadBmiHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> history = prefs.getStringList('bmi_history') ?? [];
    
    List<BmiRecord> loaded = [];
    for (int i = 0; i < history.length; i++) {
      final parts = history[i].split('|');
      if (parts.length < 3) continue;

      final rawDate = DateTime.parse(parts[0]);
      loaded.add(BmiRecord(
        i, // Menggunakan index asli sebagai ID
        rawDate,
        DateFormat('dd MMM yyyy').format(rawDate),
        parts[1],
        parts[2],
        parts.length > 3 ? parts[3] : "-",
        parts.length > 4 ? parts[4] : "-",
      ));
    }

    // Urutkan dari yang terbaru
    loaded.sort((a, b) => b.fullDate.compareTo(a.fullDate));

    setState(() {
      _allRecords = loaded;
      _applyFilter();
      _isLoading = false;
    });
  }

  void _applyFilter() {
    if (_selectedFilterDate == null) {
      _filteredRecords = List.from(_allRecords);
    } else {
      _filteredRecords = _allRecords.where((r) =>
          r.fullDate.month == _selectedFilterDate!.month &&
          r.fullDate.year == _selectedFilterDate!.year).toList();
    }
    _currentPage = 0; // Reset ke halaman pertama setiap filter berubah
  }

  Future<void> _deleteRecord(int originalIndex) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> history = prefs.getStringList('bmi_history') ?? [];
    
    // Hapus data berdasarkan index asli
    history.removeAt(originalIndex);
    await prefs.setStringList('bmi_history', history);
    
    _loadBmiHistory(); // Refresh data
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Data berhasil dihapus")),
    );
  }

  Future<void> _clearAllHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('bmi_history');
    _loadBmiHistory();
  }

  // --- Logic Pagination ---
  List<BmiRecord> get _currentPagedRecords {
    int start = _currentPage * _pageSize;
    int end = start + _pageSize;
    if (start > _filteredRecords.length) return [];
    return _filteredRecords.sublist(
        start, end > _filteredRecords.length ? _filteredRecords.length : end);
  }

  @override
  Widget build(BuildContext context) {
    int totalPages = (_filteredRecords.length / _pageSize).ceil();

    return Scaffold(
      backgroundColor: AppColor.background(context, light: AppColor.creamLight, dark: AppColor.darkBlack),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Riwayat", style: AppTextStyle.appBar(context)),
        actions: [
          // Filter Button
          IconButton(
            icon: const Icon(Icons.filter_alt_outlined),
            onPressed: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2020),
                lastDate: DateTime.now(),
                helpText: "Pilih Bulan & Tahun",
              );
              if (picked != null) {
                setState(() {
                  _selectedFilterDate = picked;
                  _applyFilter();
                });
              }
            },
          ),
          if (_selectedFilterDate != null)
            IconButton(
              icon: const Icon(Icons.filter_alt_off),
              onPressed: () => setState(() {
                _selectedFilterDate = null;
                _applyFilter();
              }),
            ),
          // Delete All Button
          IconButton(
            icon: const Icon(Icons.delete_sweep, color: Colors.red),
            onPressed: () => _showDeleteConfirmDialog(null),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: _filteredRecords.isEmpty
                      ? Center(child: Text("Data tidak ditemukan", style: AppTextStyle.paragraph(context)))
                      : ListView.builder(
                          itemCount: _currentPagedRecords.length,
                          itemBuilder: (context, index) {
                            final record = _currentPagedRecords[index];
                            return _buildHistoryCard(record);
                          },
                        ),
                ),
                // Pagination Controls
                if (totalPages > 1) _buildPaginationBar(totalPages),
              ],
            ),
    );
  }

  Widget _buildHistoryCard(BmiRecord record) {
    return Dismissible(
      key: Key(record.id.toString()),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (direction) => _deleteRecord(record.id),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: AppColor.buttonColor(context, dark: AppColor.extraLightBlack),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(record.dateStr, style: AppTextStyle.paragraph(context, fontSize: 13, colorLight: AppColor.black54)),
                GestureDetector(
                  onTap: () => _showDeleteConfirmDialog(record.id),
                  child: const Icon(Icons.close, size: 18, color: Colors.grey),
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatColumn("BMI", record.bmi, isBold: true),
                _buildStatColumn("Tinggi", "${record.height} cm"),
                _buildStatColumn("Berat", "${record.weight} kg"),
              ],
            ),
            const SizedBox(height: 5),
            Text(record.category, style: TextStyle(
              fontSize: 12,
              color: record.category == "Normal" ? Colors.green : Colors.orange,
              fontWeight: FontWeight.bold
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildStatColumn(String label, String value, {bool isBold = false}) {
    return Column(
      children: [
        Text(label, style: AppTextStyle.paragraph(context, fontSize: 11, colorLight: AppColor.black54)),
        Text(value, style: AppTextStyle.paragraph(context, 
            fontSize: 15, 
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
      ],
    );
  }

  Widget _buildPaginationBar(int totalPages) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: _currentPage > 0 ? () => setState(() => _currentPage--) : null,
          ),
          Text("Halaman ${_currentPage + 1} dari $totalPages", style: AppTextStyle.paragraph(context, fontSize: 14)),
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: _currentPage < totalPages - 1 ? () => setState(() => _currentPage++) : null,
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmDialog(int? id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(id == null ? "Hapus Semua?" : "Hapus Data?"),
        content: Text(id == null 
            ? "Apakah Anda yakin ingin menghapus seluruh riwayat BMI?" 
            : "Data ini akan dihapus secara permanen."),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Batal")),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              id == null ? _clearAllHistory() : _deleteRecord(id);
            }, 
            child: const Text("Hapus", style: TextStyle(color: Colors.red))
          ),
        ],
      ),
    );
  }
}