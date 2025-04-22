import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shayari_app/constant/app_color.dart';
import 'package:shayari_app/constant/app_images.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/text.dart';
import '../bottom navigation/bottom_nav.dart';
import '../explore/explore.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
 _checkUserStatus();
  }

  Future<void> _checkUserStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? deviceId = prefs.getString('device_id');
    List<String>? selectedMoods = prefs.getStringList('selected_moods');

    Future.delayed(const Duration(seconds: 3), () {
      if (selectedMoods != null) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomNavBar()));
      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Explore()));
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
   return Scaffold(
  body: Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [AppColor.primaryColor, AppColor.blackColor], 
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      ),
    ),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 98.w,
            height: 150.h,
            child: Image.asset(AppAsset().logo),
          ),
          AppText(
            text: 'Adab-E-Kalam',
            fontSize: 25.sp,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          AppText(
            text: 'Crafted with the Soul and Pen',
            fontSize: 12.sp,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ],
      ),
    ),
  ),
);

 
  }
}
