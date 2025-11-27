import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import '../utility/app_color.dart';
import '../utility/text_style.dart';

class BmiRecord {
  final String date;
  final String bmi;
  final String category;

  BmiRecord(this.date, this.bmi, this.category);
}

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<BmiRecord> _records = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadBmiHistory();
  }

  Future<void> _loadBmiHistory() async {
    final prefs = await SharedPreferences.getInstance();
    // Ambil daftar riwayat yang disimpan
    final List<String> history = prefs.getStringList('bmi_history') ?? [];
    
    // Konversi string riwayat menjadi objek BmiRecord
    final List<BmiRecord> loadedRecords = history.map((recordString) {
      final parts = recordString.split('|'); // Format: TGL|BMI|KATEGORI
      final rawDate = DateTime.parse(parts[0]);
      // Format tanggal ke format yang lebih mudah dibaca
      final formattedDate = DateFormat('dd MMM yyyy').format(rawDate);
      return BmiRecord(formattedDate, parts[1], parts[2]);
    }).toList();

    // Balik urutan agar riwayat terbaru muncul di atas
    loadedRecords.sort((a, b) => DateFormat('dd MMM yyyy').parse(b.date).compareTo(DateFormat('dd MMM yyyy').parse(a.date)));
    
    setState(() {
      _records = loadedRecords;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background(context, light: AppColor.creamLight, dark: AppColor.darkBlack),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: AppColor.background(context, light: AppColor.creamLight, dark: AppColor.darkBlack),
            title: Text("Riwayat BMI", style: AppTextStyle.appBar(context)),
            floating: true,
            pinned: true,
          ),
          _isLoading
              ? const SliverFillRemaining(child: Center(child: CircularProgressIndicator()))
              : _records.isEmpty
                  ? SliverFillRemaining(
                      child: Center(
                        child: Text(
                          "Belum ada riwayat BMI tersimpan.",
                          style: AppTextStyle.paragraph(context),
                        ),
                      ),
                    )
                  : SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          final record = _records[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                            color: AppColor.buttonColor(context, dark: AppColor.extraLightBlack),
                            child: ListTile(
                              leading: const Icon(Icons.history),
                              title: Text('BMI: ${record.bmi}', style: AppTextStyle.paragraph(context, fontWeight: FontWeight.bold)),
                              subtitle: Text('Kategori: ${record.category}', style: AppTextStyle.paragraph(context)),
                              trailing: Text(record.date, style: AppTextStyle.paragraph(context, fontSize: 14)),
                            ),
                          );
                        },
                        childCount: _records.length,
                      ),
                    ),
        ],
      ),
    );
  }
}