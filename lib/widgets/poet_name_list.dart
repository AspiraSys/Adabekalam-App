import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constant/app_color.dart';
import 'text.dart';

class PoetNameList extends StatelessWidget {
  final bool isSelected;
  final String name;
  const PoetNameList({super.key, required this.isSelected, required this.name});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 8.w, top: 10.h, bottom: 10.h),
      child: Container(
        decoration: BoxDecoration(
          gradient:
          
           LinearGradient(
            colors: [
              isSelected ? 
              Color(0xFFD0FF91) :
              AppColor.darkGrey, isSelected ? Color(0xFFD0FF91) :  AppColor.whiteColor],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(5.r),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 10.w,
          ),
          child: Center(
              child: AppText(
            text: name,
            color: AppColor.blackColor,
            fontSize: 10.sp,
          )),
        ),
      ),
    );
  }
}
