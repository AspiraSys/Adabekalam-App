import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shayari_app/constant/app_color.dart';
import 'package:shayari_app/constant/app_images.dart';

class CustomTextfield extends StatefulWidget {
  final TextEditingController controller;
  final String? hintText;
  final Color btnColor;
  final TextInputType keyboardType;
  final Color backgroundColor;
  final Color hintColor;
  final bool isPassword;
  final double height;
  final double width;
  final bool isPhone;
  // final Function()? onPressed;
  void Function(String)? onChanged;
  final double borderRadius;
  final bool isPrefixIcon;
  final bool isRadioButton;
  final List<String>? radioOptions;
  final String? Function(String?)? validator;

   CustomTextfield({
    super.key,
    required this.controller,
    this.hintText,
    this.keyboardType = TextInputType.text,
    this.backgroundColor = Colors.white,
    this.hintColor = Colors.grey,
    this.isPassword = false,
    this.height = 30.0,
    this.width = 335.0,
    this.borderRadius = 10.0,
    this.isPhone = false,
    this.validator,
    this.onChanged,
    this.btnColor = Colors.grey,
    this.isPrefixIcon = false,
    this.isRadioButton = false,
    this.radioOptions,
  });

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  String? selectedOption;

  @override
  Widget build(BuildContext context) {
    return normalTextField();
  }

  Widget normalTextField() {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Container(
          decoration: BoxDecoration(
              color: AppColor.greyColor,
              borderRadius: BorderRadius.circular(10.r)),
          height: 40.h,
          width: 367.w,
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
                child: Container(
                  height: widget.height.h,
                  width: widget.width.w,
                  decoration: boxDecoration(),
                  child: textField(false),
                ),
              ),

              Image.asset(AppAsset().search, height: 22.h, width: 22.w,)
            ],
          ),
        ));
  }

  TextFormField textField(bool readOnly) {
    return TextFormField(
      readOnly: readOnly,
      onChanged: widget.onChanged,
      style: TextStyle(
        fontFamily: 'openSans',
        fontSize: 14.sp,
        color: Colors.black,
      ),
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      obscureText: widget.isPassword,
      validator: widget.validator,
      decoration: InputDecoration(
        alignLabelWithHint: true,
        hintText: widget.hintText,
        hintStyle: TextStyle(
          fontFamily: 'nunito',
          height: 1.9.h,
          color: widget.hintColor,
          fontSize: 12.sp,
        ),
        border: InputBorder.none,
        contentPadding:
            EdgeInsets.symmetric(vertical: widget.height / 3, horizontal: 20.w),
      ),
    );
  }

  BoxDecoration boxDecoration() {
    return BoxDecoration(
      color: AppColor.whiteColor,
      borderRadius: BorderRadius.circular(widget.borderRadius.r),
    );
  }
}
