import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constant/app_color.dart';
import '../../constant/app_images.dart';

class ReusableAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool hasBackButton;

  const ReusableAppbar({
    super.key,
    required this.title,
    required this.hasBackButton,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 1,
      child: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: AppColor.primaryColor,
        // centerTitle: true,
        automaticallyImplyLeading: hasBackButton, 
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(AppAsset().logo, width: 38.w, height: 59.h),
            SizedBox(width: 8.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'nunito',
                    fontSize: 18.sp,
                    color: AppColor.whiteColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Crafted with the Soul and Pen",
                  style: TextStyle(
                    fontFamily: 'nunito',
                    fontSize: 8.sp,
                    color: AppColor.whiteColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: ThemeSwitch(),
                      // )

        ],
        leading: hasBackButton
            ? InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                  child: CircleAvatar(
                    backgroundColor: AppColor.blackColor,
                    radius: 50.r,
                    child: Icon(Icons.arrow_back),
                  ),
                ),
              )
            : null,
      ),
    );
  }
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
