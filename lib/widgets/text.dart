

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppText extends StatefulWidget {
  final String text;
  final TextAlign? textAlign;
  final TextOverflow overflow;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;
  final int? maxLines;
  final bool isTextShadow;
  final String fontFamily;
  final bool isHeader;
  final double underlineGap;
  final double underlineThickness;
  final Color underlineColor;
  final Duration animationDuration;

  const AppText({
    super.key,
    required this.text,
    this.textAlign,
    this.overflow = TextOverflow.ellipsis,
    this.color = Colors.white,
    this.fontSize = 14.0,
    this.fontWeight = FontWeight.bold,
    this.maxLines = 300,
    this.isTextShadow = false,
    this.fontFamily = "nunito",
    this.isHeader = false,
    this.underlineGap = 1.0,
    this.underlineThickness = 1.0,
    this.underlineColor = Colors.white,
    this.animationDuration = const Duration(milliseconds: 500),
  });

  @override
  _AppTextState createState() => _AppTextState();
}

class _AppTextState extends State<AppText> {
  double _underlineWidth = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        _underlineWidth = _calculateTextWidth() * 0.5; 
      });
    });
  }

  double _calculateTextWidth() {
    final textPainter = TextPainter(
      text: TextSpan(
        text: widget.text,
        style: TextStyle(
          fontFamily: widget.fontFamily,
          fontSize: widget.fontSize.sp,
          fontWeight: widget.fontWeight,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    return textPainter.width;
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(
      fontFamily: widget.fontFamily,
      color: widget.color,
      fontSize: widget.fontSize.sp,
      fontWeight: widget.fontWeight,
      shadows: widget.isTextShadow
          ? [
              const Shadow(
                offset: Offset(1.0, 1.0),
                blurRadius: 2.0,
                color: Colors.grey,
              )
            ]
          : [],
    );

    if (!widget.isHeader) {
      return Text(
        widget.text,
        textAlign: widget.textAlign,
        overflow: widget.overflow,
        style: textStyle,
        maxLines: widget.maxLines,
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: widget.underlineGap + widget.underlineThickness),
            child: Text(
              widget.text,
              textAlign: widget.textAlign,
              overflow: widget.overflow,
              style: textStyle,
              maxLines: widget.maxLines,
            ),
          ),
          AnimatedContainer(
            duration: widget.animationDuration,
            curve: Curves.easeOut,
            width: _underlineWidth,
            height: widget.underlineThickness,
            color: widget.underlineColor,
          ),
        ],
      );
    }
  }
}







// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';

// class AppText extends StatefulWidget {
//   final String text;
//   final TextAlign? textAlign;
//   final TextOverflow overflow;
//   final Color color;
//   final double fontSize;
//   final FontWeight fontWeight;
//   final int? maxLines;
//   final bool isTextShadow;
//   final bool isHeader;
//   final double underlineGap;
//   final double underlineThickness;
//   final Color underlineColor;
//   final Duration animationDuration;

//   const AppText({
//     super.key,
//     required this.text,
//     this.textAlign,
//     this.overflow = TextOverflow.ellipsis,
//     this.color = Colors.white,
//     this.fontSize = 14.0,
//     this.fontWeight = FontWeight.bold,
//     this.maxLines = 5,
//     this.isTextShadow = false,
//     this.isHeader = false,
//     this.underlineGap = 1.0,
//     this.underlineThickness = 1.0,
//     this.underlineColor = Colors.white,
//     this.animationDuration = const Duration(milliseconds: 500),
//   });

//   @override
//   _AppTextState createState() => _AppTextState();
// }

// class _AppTextState extends State<AppText> {
//   double _underlineWidth = 0;

//   @override
//   void initState() {
//     super.initState();
//     Future.delayed(const Duration(milliseconds: 100), () {
//       setState(() {
//         _underlineWidth = _calculateTextWidth() * 0.5;
//       });
//     });
//   }

//   double _calculateTextWidth() {
//     final textPainter = TextPainter(
//       text: TextSpan(
//         text: widget.text,
//         style: GoogleFonts.nunito(
//           fontSize: widget.fontSize.sp,
//           fontWeight: widget.fontWeight,
//         ),
//       ),
//       textDirection: TextDirection.ltr,
//     )..layout();
//     return textPainter.width;
//   }

//   @override
//   Widget build(BuildContext context) {
//     TextStyle textStyle = GoogleFonts.nunito(
//       color: widget.color,
//       fontSize: widget.fontSize.sp,
//       fontWeight: widget.fontWeight,
//       shadows: widget.isTextShadow
//           ? [
//               const Shadow(
//                 offset: Offset(1.0, 1.0),
//                 blurRadius: 2.0,
//                 color: Colors.grey,
//               )
//             ]
//           : [],
//     );

//     if (!widget.isHeader) {
//       return Text(
//         widget.text,
//         textAlign: widget.textAlign,
//         overflow: widget.overflow,
//         style: textStyle,
//         maxLines: widget.maxLines,
//       );
//     } else {
//       return Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: EdgeInsets.only(bottom: widget.underlineGap + widget.underlineThickness),
//             child: Text(
//               widget.text,
//               textAlign: widget.textAlign,
//               overflow: widget.overflow,
//               style: textStyle,
//               maxLines: widget.maxLines,
//             ),
//           ),
//           AnimatedContainer(
//             duration: widget.animationDuration,
//             curve: Curves.easeOut,
//             width: _underlineWidth,
//             height: widget.underlineThickness,
//             color: widget.underlineColor,
//           ),
//         ],
//       );
//     }
//   }
// }
