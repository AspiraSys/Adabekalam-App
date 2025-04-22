import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shayari_app/constant/styles.dart';
import 'package:shayari_app/widgets/text.dart';

import '../constant/app_color.dart';
import '../controllers/language_selection.dart';

class LanguageSelection extends StatelessWidget {
  const LanguageSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, langController, child) {
        return Container(
          height: 38.h,
          width: 366.w,
          decoration: Styles.boxShadow,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildRow(
                  title: "ENGLISH",
                  isSelected: langController.selectedLanguage == "ENGLISH",
                  onTap: () => langController.selectLang("ENGLISH"),
                ),
                _buildRow(
                  title: "HINDI",
                  isSelected: langController.selectedLanguage == "HINDI",
                  onTap: () => langController.selectLang("HINDI"),
                ),
                _buildRow(
                  title: "URDU",
                  isSelected: langController.selectedLanguage == "URDU",
                  onTap: () => langController.selectLang("URDU"),
                ),
                _buildRow(
                  title: "TAMIL",
                  isSelected: langController.selectedLanguage == "TAMIL",
                  onTap: () => langController.selectLang("TAMIL"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildRow({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 20.h,
        child: Center(
          child: AppText(
            text: title,
            fontSize: 12.sp,
            color:  AppColor.blackColor, 
            fontWeight: FontWeight.w600,
            isHeader: isSelected,
            underlineColor: isSelected ? AppColor.blackColor : Colors.transparent,
          ),
        ),
      ),
    );
  }
}
