import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constant/app_color.dart';
import 'text.dart';

class CustomButton extends StatefulWidget {
  final String title;
  final bool isBorder;
  final Color btnColor;
  final VoidCallback? onPressed;
  final double height;
  final double fontSize;
  final double radius;
  final double width;
   const CustomButton({super.key, required this.title, this.isBorder = false, this.btnColor = Colors.white, required this.onPressed,
   this.height = 40,
   this.width = double.infinity,
   this.fontSize = 15, 
   this.radius = 10,
   });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      child: Container(
        decoration: BoxDecoration(
        color: widget.btnColor,
        border: widget.isBorder ? Border.all(color: AppColor.whiteColor, width: 1.w) : null,
      
          borderRadius: BorderRadius.all(Radius.circular(widget.radius)),
        ),
        height: widget.height.h,
        width: widget.width.w,
        child:  Center(child: AppText(
          
          text: widget.title,
         textAlign: TextAlign.center, 
         color: AppColor.blackColor,
          fontWeight: FontWeight.w600,
          fontSize: widget.fontSize.sp,
          
          ))
      ),
    );
  }
}