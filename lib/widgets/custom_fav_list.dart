
// import 'package:flutter/cupertino.dart' show CupertinoIcons;
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:shayari_app/constant/app_color.dart';
// import 'package:shayari_app/widgets/text.dart';

// class CustomFavList extends StatelessWidget {
//   final String image;
//   final String title;
//   bool isLiked;

//   CustomFavList({super.key, required this.image, required this.title, this.isLiked = false});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(10.r),
//         child: Container(
//           decoration: BoxDecoration(
//             color: AppColor.whiteColor,
//             borderRadius: BorderRadius.circular(10.r),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Stack(
//                 children: [
//                   Image.network(
//                     image,
//                     height: 185.h,
//                     width: double.infinity,
//                     fit: BoxFit.cover,
//                     errorBuilder: (context, error, stackTrace) => Icon(
//                       Icons.broken_image,
//                       size: 50.w,
//                       color: Colors.grey,
//                     ),
//                   ),
//                   Positioned(
//                     top: 10.h,
//                     right: 10.w,
//                     child: Icon(
//                       isLiked ? CupertinoIcons.heart_fill : CupertinoIcons.bookmark_fill,
//                       size: 30.w,
//                       color: isLiked ? Colors.red : AppColor.whiteColor,
//                     ),
//                   ),
//                 ],
//               ),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
//                 child: Center(
//                   child: AppText(
//                     text: title,
//                     fontWeight: FontWeight.bold,
//                     color: AppColor.blackColor,
//                     fontSize: 13.sp,
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/cupertino.dart' show CupertinoIcons;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shayari_app/constant/app_color.dart';
import 'package:shayari_app/widgets/text.dart';
class CustomFavList extends StatelessWidget {
  final String image;
  final String title;
  bool isLiked;

  CustomFavList({super.key, required this.image, required this.title, this.isLiked = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.r),
        child: Container(
          decoration: BoxDecoration(
            color: AppColor.whiteColor,
            borderRadius: BorderRadius.circular(10.r),
          ),
        
       child: IntrinsicHeight( 
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center, 
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Stack(
        children: [
          Image.network(
            image,
            height: 185.h,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Icon(
              Icons.broken_image,
              size: 50.w,
              color: Colors.grey,
            ),
          ),
          Positioned(
            top: 10.h,
            right: 10.w,
            child: Icon(
              isLiked ? CupertinoIcons.heart_fill : CupertinoIcons.bookmark_fill,
              size: 30.w,
              color: isLiked ? Colors.red : AppColor.whiteColor,
            ),
          ),
        ],
      ),
      Expanded(  
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
          child: Center(  
            child: AppText(
              text: title,
              fontWeight: FontWeight.bold,
              color: AppColor.blackColor,
              fontSize: 13.sp,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    ],
  ),
),

        ),
      ),
    );
  }
}
