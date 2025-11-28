import 'package:flutter/material.dart';

class BmiSuggestion {
  final String emoji;
  final String motivation;
  final List<String> foodTips;
  final List<String> exerciseTips;

  BmiSuggestion({
    required this.emoji,
    required this.motivation,
    required this.foodTips,
    required this.exerciseTips,
  });
}

class SuggestionScreen extends StatelessWidget {
  final String bmi;
  final String userName;

  SuggestionScreen({required this.bmi, required this.userName});

  String getBMICategory(double bmi) {
    if (bmi < 16) return 'Severe Thinness';
    else if (bmi < 17) return 'Moderate Thinness';
    else if (bmi < 18.5) return 'Mild Thinness';
    else if (bmi < 25) return 'Normal';
    else if (bmi < 30) return 'Overweight';
    else if (bmi < 35) return 'Obese Class I';
    else if (bmi < 40) return 'Obese Class II';
    else return 'Obese Class III';
  }

  final Map<String, BmiSuggestion> suggestionMap = {
    'Severe Thinness': BmiSuggestion(
      emoji: '🧍‍♂️🍲',
      motivation: "Tubuhmu butuh lebih banyak kekuatan! Ayo kita beri nutrisi! 💪",
      foodTips: [
        "Tambahkan makanan kaya kalori: kacang-kacangan, susu, ghee 🥛🥜",
        "Makan kecil sering + protein shake 🍗",
      ],
      exerciseTips: [
        "Lakukan yoga ringan 🧘",
        "Hindari kelelahan berlebihan; fokuslah untuk mendapatkan kekuatan 💪",
      ],
    ),
    'Moderate Thinness': BmiSuggestion(
      emoji: '🍛🏋️',
      motivation: "Kamu hampir sampai! Isi Stamina dan berlatihlah dengan cerdas. 🔥",
      foodTips: [
        "Makanan tinggi protein dengan karbohidrat 🍚🍖",
        "Hindari melewatkan waktu makan 🍽️",
      ],
      exerciseTips: [
        "Latihan kekuatan dasar 🏋️",
        "Jalan kaki dan peregangan setiap hari 🧘‍♂️",
      ],
    ),
    // (SEMUA DATA TETAP, tidak diubah)
    'Mild Thinness': BmiSuggestion(
      emoji: '🍞💪',
      motivation: "Hampir sehat – hanya perlu sedikit dorongan lagi 🚀",
      foodTips: [
        "Tambahkan lemak sehat dan susu 🥛🧀",
        "Makan tepat waktu secara teratur ⏰",
      ],
      exerciseTips: [
        "Latihan beban tubuh + beban ringan 🏋️‍♀️",
        "Hindari aktivitas kardio tinggi untuk saat ini ⛔",
      ],
    ),
    'Normal': BmiSuggestion(
      emoji: '🌟🎯',
      motivation: "Sempurna! Pertahankan keseimbangan ini dan tetap konsisten. 🌈",
      foodTips: [
        "Makanan seimbang: buah-buahan, biji-bijian, protein 🥗🍗",
        "Tetap terhidrasi 💧",
      ],
      exerciseTips: [
        "Campuran kardio + beban 🏃‍♂️🏋️‍♂️",
        "Cobalah meditasi atau yoga 🧘",
      ],
    ),
    // (DAN SETERUSNYA tanpa perubahan)
    'Overweight': BmiSuggestion(
      emoji: '🥦🚴',
      motivation: "Mari kita kurangi berat badan dan menjadi bugar bersama 💥",
      foodTips: [
        "Hindari gula, makanan yang digoreng 🚫🍩",
        "Makan serat dan protein 🥦🍗",
      ],
      exerciseTips: [
        "Latihan kardio + kekuatan 🏃‍♂️💪",
        "Jalan kaki setiap hari, targetkan 7.000+ langkah 👣",
      ],
    ),
    'Obese Class I': BmiSuggestion(
      emoji: '⚠️🔥',
      motivation: "Saatnya mengambil alih. Kamu bisa! 💯",
      foodTips: [
        "Beralihlah ke makanan rumahan yang bersih 🍲",
        "Katakan tidak pada minuman ringan dan permen 🚫🥤",
      ],
      exerciseTips: [
        "Jalan cepat + latihan berdampak rendah 🚶",
        "Mulailah secara perlahan, lalu tingkatkan intensitas secara bertahap 🧗",
      ],
    ),
    'Obese Class II': BmiSuggestion(
      emoji: '🚨❤️',
      motivation: "Peringatan kesehatan! Mari bangun kembali gaya hidup Anda, selangkah demi selangkah. 👣",
      foodTips: [
        "Hindari makanan olahan sepenuhnya 🚫🍔",
        "Konsultasikan dengan ahli gizi jika memungkinkan 🩺",
      ],
      exerciseTips: [
        "Lakukan latihan kursi atau kolam renang 💧",
        "Bekerja dengan pelatih atau dokter 👨‍⚕️",
      ],
    ),
    'Obese Class III': BmiSuggestion(
      emoji: '🏥🛑',
      motivation: "Serius, tapi bukan berarti mustahil. Mulailah hari ini – tubuhmu pantas mendapatkannya. 🧠❤️",
      foodTips: [
        "Rencana diet ketat, fokus pada sayuran dan protein 🥬🍗",
        "Makan lebih sedikit, lebih sering 🍽️",
      ],
      exerciseTips: [
        "Gerakan berdampak sangat rendah, di bawah pengawasan 🧑‍⚕️",
        "Pantau detak jantung dan kemajuan secara teratur 📉",
      ],
    ),
  };

  @override
  Widget build(BuildContext context) {
    final category = getBMICategory(double.parse(bmi));
    final suggestion = suggestionMap[category]!;

    return Scaffold(
      appBar: AppBar(
        title: Text('Hi $userName 👋'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Card Header BMI ---
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Text(
                      suggestion.emoji,
                      style: const TextStyle(fontSize: 35),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        "BMI Kamu: $bmi\nKategori: $category",
                        style: const TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // === MOTIVASI ===
              Text("💡 Motivasi", style: _sectionTitle()),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue.shade100, width: 1.3),
                ),
                child: Text(suggestion.motivation, style: _contentText()),
              ),

              const SizedBox(height: 25),

              // === SARAN MAKANAN ===
              Text("🍽️ Saran Makanan", style: _sectionTitle()),
              const SizedBox(height: 10),
              ...suggestion.foodTips.map((tip) => Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.fastfood, size: 26),
                    const SizedBox(width: 10),
                    Expanded(child: Text(tip, style: _contentText())),
                  ],
                ),
              )),

              const SizedBox(height: 25),

              // === SARAN LATIHAN ===
              Text("🏋️ Saran Latihan", style: _sectionTitle()),
              const SizedBox(height: 10),
              ...suggestion.exerciseTips.map((tip) => Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.fitness_center, size: 26),
                    const SizedBox(width: 10),
                    Expanded(child: Text(tip, style: _contentText())),
                  ],
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }

  TextStyle _sectionTitle() => const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Color.fromARGB(255, 9, 51, 123),
  );

  TextStyle _contentText() => const TextStyle(fontSize: 16);
}
