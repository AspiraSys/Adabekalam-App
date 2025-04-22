
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shayari_app/constant/app_images.dart';

import '../../constant/app_color.dart';
import '../../widgets/text.dart';
import 'controller/bottomnav_controller.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomNavController = Provider.of<BottomNavController>(context);

    return Scaffold(
      backgroundColor: AppColor.blackColor,
      body: bottomNavController.currentScreen,
      bottomNavigationBar: Container(
        height: 81.h,
        decoration: BoxDecoration(color: AppColor.blackColor),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(context, AppAsset().collection, 'Collection', 0, 24),
            _buildCenterNavItem(context, bottomNavController),
            _buildNavItem(context, AppAsset().favorite, 'Favorite', 2, 17),
          ],
        ),
      ),
    );
  }

  Widget _buildCenterNavItem(BuildContext context, BottomNavController bottomNavController) {
    bool isSelected = bottomNavController.selectedIndex == 1;

    return GestureDetector(
      onTap: () => bottomNavController.updateIndex(1),
      child: Container(
        height: 75.h,
        width: 75.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? AppColor.whiteColor : Color(0xFF2F3945), 
          gradient: isSelected
              ? LinearGradient(
                  colors: [AppColor.darkGrey, AppColor.whiteColor],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )
              : null,
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.white,
                    blurRadius: 14,
                    spreadRadius: 1,
                    offset: Offset(1, 1),
                  )
                ]
              : [],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Image.asset(
            AppAsset().home,
            color: isSelected ? AppColor.blackColor : AppColor.whiteColor, 
          ),
        ),
      ),
    );
  }

//   Widget _buildNavItem(BuildContext context, String icon, String label, int index, double width) {
//     final bottomNavController = Provider.of<BottomNavController>(context);
//     final isSelected = bottomNavController.selectedIndex == index;

//     return GestureDetector(
//       onTap: () => bottomNavController.updateIndex(index),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Image.asset(
//             icon,
//             color: isSelected ? AppColor.whiteColor : Colors.grey,
//             width: width,
//           ),
//           AppText(
//             color: AppColor.whiteColor,
//             text: label,
//             fontSize: 12.sp,
//             fontWeight: FontWeight.normal,
//           )
//         ],
//       ),
//     );
//   }
// }



  Widget _buildNavItem(BuildContext context, String icon, String label, int index, double width) {
    final bottomNavController = Provider.of<BottomNavController>(context);
    final isSelected = bottomNavController.selectedIndex == index;

    return GestureDetector(
      onTap: () => bottomNavController.updateIndex(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(0.w),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.5),
                        blurRadius: 10,
                        spreadRadius: 0.1,
                        offset: Offset(0, 0),
                      )
                    ]
                  : [],
            ),
            child: Image.asset(
              icon,
              color: isSelected ? AppColor.whiteColor : Colors.grey,
              width: width,
            ),
          ),
          SizedBox(height: 4.h),
          AppText(
            color: isSelected ? AppColor.whiteColor : Colors.grey,
            text: label,
            fontSize: 12.sp,
            fontWeight: FontWeight.normal,
          )
        ],
      ),
    );
  }
}