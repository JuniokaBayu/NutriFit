import 'package:flutter/material.dart';
import '../utility/app_color.dart';
import '../utility/text_style.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background(context, light: AppColor.creamLight, dark: AppColor.darkBlack),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Aplikasi NutriFit',
                style: AppTextStyle.appName(context, fontSize: 30),
              ),
              const SizedBox(height: 20),
              Text(
                'NutriFit adalah kalkulator BMI (Body Mass Index) yang praktis dan mudah dipakai. Aplikasi ini saya buat untuk membantu Anda mengecek kondisi kesehatan berdasarkan tinggi serta berat badan, sehingga Anda bisa lebih memahami tubuh Anda dan memulai kebiasaan hidup yang lebih sehat.',
                textAlign: TextAlign.center,
                style: AppTextStyle.paragraph(context, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}