import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shayari_app/constant/app_images.dart';
import 'package:shayari_app/widgets/text.dart';

import '../constant/app_color.dart';

class PoetCard extends StatelessWidget {
  final String name;
  final String language;
  final List<String> mood; 
  final String image;
  const PoetCard({super.key, required this.name, required this.language, required this.mood, required this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Container(
        height: 95.h,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9.r),
               gradient: LinearGradient(
          colors: [AppColor.greyColor, AppColor.whiteColor], 
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
        ),
        child:
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 15.w),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: Image.network(image, width: 58.w, height: 65.h, fit: BoxFit.cover,)),
              ),
              SizedBox(
                width: 230.w,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(text: name, color: AppColor.blackColor, fontSize: 18.sp),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 5.w),
                          child: Image.asset(AppAsset().language, width: 10.w,),
                        ),
                        AppText(text: "Lang: $language", color: AppColor.blackColor, fontSize: 12.sp),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 5.w),
                          child: Image.asset(AppAsset().mood, width: 10.w,),
                        ),
                        AppText(text: "Mood: ${mood.join(', ')}", color: AppColor.blackColor, fontSize: 11.sp,),    
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: 25.w,
                height: 25.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColor.darkGrey,
                  border: Border.all(color: Color(0xFFB7B7B7))
                ),
                child: Icon(Icons.arrow_forward_ios, size: 15.w,),
              )
            ],
          ),
        )
      ),
    );
  }
}