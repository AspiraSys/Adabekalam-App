// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:shayari_app/constant/app_color.dart';
// import 'package:shayari_app/widgets/text.dart';

// class ExploreCards extends StatelessWidget {
//   final String imagePath;
//   final String title;
//   const ExploreCards({super.key, required this.imagePath, required this.title});

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       alignment: Alignment.bottomLeft,
//       children: [
      
//         Container(
//                 decoration: BoxDecoration(
//            borderRadius: BorderRadius.circular(50.r), 
//                 ),
//           width: 98.w,
//           height: 119.h,
//           child: Image.asset(imagePath,
//           color: Color(0xFF2F3945),
//           colorBlendMode: BlendMode.overlay,
//           filterQuality: FilterQuality.high,
//           fit: BoxFit.cover,
//           ),
//         ),
//           Positioned(
//             bottom: 0.h,
//             left: 0.w,
//             child: Padding(
//               padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
//               child: FittedBox(
//                 fit: BoxFit.fitWidth,
//                 child: AppText(text: title.toUpperCase(), fontSize: 11.sp, color: AppColor.whiteColor,
//                 isHeader: true,
//                 ),
//               ),
//             ),
//           ),
//       ],
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shayari_app/constant/app_color.dart';
import 'package:shayari_app/widgets/text.dart';




class ExploreCards extends StatelessWidget {
  final String imagePath;
  final String title;

  const ExploreCards({super.key, required this.imagePath, required this.title});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50.r),
          ),
          width: 98.w,
          height: 119.h,
          child: Image.asset(
            imagePath,
            color: const Color(0xFF2F3945),
            colorBlendMode: BlendMode.overlay,
            filterQuality: FilterQuality.high,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          bottom: 0.h,
          left: 0.w,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h), // Added padding for spacing
            child: SizedBox(
              width: 80.w, 
              child: AppText(
                text: title.toUpperCase(),
                fontSize: 11.sp, 
                color: AppColor.whiteColor,
                isHeader: true,
                textAlign: TextAlign.start, 
              ),
            ),
          ),
        ),
      ],
    );
  }
}
