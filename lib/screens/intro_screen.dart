import 'package:fit_scale/utility/app_color.dart';
import 'package:flutter/material.dart';
import '../utility/text_style.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.background(context, light: AppColor.creamDark),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/logo.png', height: 200),
          const SizedBox(height: 20),
          Text('NutriFit', style: AppTextStyle.appName(context)),
          const SizedBox(height: 30),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Kesehatan Anda itu berharga. NutriFit hadir untuk membantu Anda mengenal kondisi tubuh dengan cara yang sederhana. Cukup beberapa ketukan, Anda bisa mengecek BMI, memantau kebugaran, dan mulai mengarahkan diri menuju gaya hidup yang lebih sehat.',
              textAlign: TextAlign.center,
              style: AppTextStyle.paragraph(context),
            ),
          ),
          const SizedBox(height: 30),
          Text(
            "Mari kita mulai 💪",
            style: AppTextStyle.paragraph(
              context,
              colorLight: AppColor.lightBlack,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
