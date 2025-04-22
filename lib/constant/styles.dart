import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_color.dart';

class Styles {
  static BoxDecoration boxShadow = BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColor.darkGrey, AppColor.whiteColor],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(10.5.r),
          );
}