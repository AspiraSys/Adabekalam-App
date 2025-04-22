// import 'package:flutter/cupertino.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:shayari_app/constant/app_color.dart';
// import 'package:shayari_app/model/feeds_model.dart';
// import 'package:shayari_app/widgets/text.dart';
// import 'package:share_plus/share_plus.dart';
// import 'package:dio/dio.dart';
// import 'package:path_provider/path_provider.dart';



// class FeedCard extends StatefulWidget {
//   final FeedModel feed;
//   final bool isLiked;
//   final bool isSaved;
//   final VoidCallback onLike;
//   final VoidCallback onSaved;


//   const FeedCard({
//     super.key,
//     required this.feed,
//     required this.isLiked,
//     required this.onLike,
//     required this.isSaved,
//     required this.onSaved,

//   });
//   @override
//   State<FeedCard> createState() => _FeedCardState();
// }

// class _FeedCardState extends State<FeedCard> {



//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 10.h),
//       child: Container(
//         width: double.infinity,
//         decoration: BoxDecoration(
//             gradient: LinearGradient(
//                 colors: [AppColor.darkGrey, AppColor.whiteColor],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight),
//             borderRadius: BorderRadius.circular(10.5.r)),
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(
//                 height: 197.h,
//                 width: double.infinity,
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(10.r),
//                   child: Image.network(
//                     widget.feed.image,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.symmetric(vertical: 15.h),
//                 child: SizedBox(
//                     width: 200.w,
//                     child: AppText(
//                       text: widget.feed.title.toUpperCase(),
//                       color: AppColor.blackColor,
//                       fontSize: 17.sp,
//                       fontWeight: FontWeight.w800,
//                     )),
//               ),
//               SizedBox(
//                 width: 200.w,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: widget.feed.paragraph.split('.').map((line) {
//                     if (line.trim().isEmpty) return SizedBox();
//                     return Padding(
//                       padding: EdgeInsets.only(bottom: 7.h),
//                       child: AppText(
//                         text: '${line.trim()}.',
//                         color: AppColor.blackColor,
//                         fontSize: 15.sp,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     );
//                   }).toList(),
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.symmetric(vertical: 10.h),
//                 child: SizedBox(
//                   width: 275.w,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       AppText(
//                         text: "@${widget.feed.author}",
//                         color: AppColor.blackColor,
//                         fontSize: 11.sp,
//                         fontWeight: FontWeight.normal,
//                       ),
//                       AppText(
//                         text: "@${widget.feed.language}",
//                         color: AppColor.blackColor,
//                         fontSize: 11.sp,
//                         fontWeight: FontWeight.normal,
//                       ),
//                       AppText(
//                         text: "@${widget.feed.category}",
//                         color: AppColor.blackColor,
//                         fontSize: 11.sp,
//                         fontWeight: FontWeight.normal,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 30.h,
//                 width: 100.w,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     GestureDetector(
//                       onTap: widget.onLike,
//                       child: Icon(
//                         widget.isLiked ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
//                         size: 30.w,
//                         color: AppColor.primaryColor,
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: _shareContent,
//                       child: Icon(
//                         CupertinoIcons.share_up,
//                         size: 30.w,
//                         color: AppColor.primaryColor,
//                       ),
//                     ),
             

//                                         GestureDetector(
//                       onTap: widget.onSaved,
//                       child: Icon(
//                         widget.isSaved ?  CupertinoIcons.bookmark_fill :  CupertinoIcons.bookmark,
//                         size: 30.w,
//                         color: AppColor.primaryColor,
//                       ),
//                     ),

//                   ],
//                 ),
//               ),
          
//             ],
//           ),
//         ),
//       ),
//     );
//   }

// void _shareContent() async {
//     final String formattedParagraph = widget.feed.paragraph.replaceAll('. ', '\n\n');
//   try {
//     // Get app's temporary directory
//     final tempDir = await getTemporaryDirectory();
//     final imagePath = "${tempDir.path}/shared_image.jpg";

//     // Download the image
//     final response = await Dio().download(widget.feed.image, imagePath);

//     // Prepare text to share
//     final String textToShare =
//       "${widget.feed.title.toUpperCase()}\n\n$formattedParagraph\n\nBy @${widget.feed.author}";
//     await Share.shareXFiles([XFile(imagePath)], text: textToShare);

//   } catch (e) {
//     print("Error sharing content: $e");
//   }
// }






// }


import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shayari_app/constant/app_color.dart';
import 'package:shayari_app/model/feeds_model.dart';
import 'package:shayari_app/widgets/text.dart';
import 'package:share_plus/share_plus.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class FeedCard extends StatefulWidget {
  final FeedModel feed;
  final bool isLiked;
  final bool isSaved;
  final VoidCallback onLike;
  final VoidCallback onSaved;

  const FeedCard({
    super.key,
    required this.feed,
    required this.isLiked,
    required this.onLike,
    required this.isSaved,
    required this.onSaved,
  });

  @override
  State<FeedCard> createState() => _FeedCardState();
}

class _FeedCardState extends State<FeedCard> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [AppColor.darkGrey, AppColor.whiteColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight),
            borderRadius: BorderRadius.circular(10.5.r)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 197.h,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: Image.network(
                    widget.feed.image,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      
                      return Image.asset(
                        'assets/no-image.png', 
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 197.h,
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15.h),
                child: SizedBox(
                    width: 200.w,
                    child: AppText(
                      text: widget.feed.title.toUpperCase(),
                      color: AppColor.blackColor,
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w800,
                    )),
              ),
              SizedBox(
                width: 200.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // children: widget.feed.paragraph.split('.').map((line) {
                  //   if (line.trim().isEmpty) return SizedBox();
                  //   return Padding(
                  //     padding: EdgeInsets.only(bottom: 7.h),
                  //     child: AppText(
                  //       text: '${line.trim()}.',
                  //       color: AppColor.blackColor,
                  //       fontSize: 15.sp,
                  //       fontWeight: FontWeight.w500,
                  //     ),
                  //   );
                  // }).toList(),


                  children: widget.feed.paragraph.isNotEmpty
    ? widget.feed.paragraph.split('.').where((line) => line.trim().isNotEmpty).map((line) {
        return Padding(
          padding: EdgeInsets.only(bottom: 7.h),
          child: AppText(
            text: '${line.trim()}.',  
            color: AppColor.blackColor,
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
          ),
        );
      }).toList()
    : [SizedBox(),], 

                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: SizedBox(
                  width: 275.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText(
                        text: "@${widget.feed.author}",
                        color: AppColor.blackColor,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.normal,
                      ),
                      AppText(
                        text: "@${widget.feed.language}",
                        color: AppColor.blackColor,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.normal,
                      ),
                      AppText(
                        text: "@${widget.feed.category}",
                        color: AppColor.blackColor,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.normal,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30.h,
                width: 100.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: widget.onLike,
                      child: Icon(
                        widget.isLiked ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
                        size: 30.w,
                        color: AppColor.primaryColor,
                      ),
                    ),
                    GestureDetector(
                      onTap: _shareContent,
                      child: Icon(
                        CupertinoIcons.share_up,
                        size: 30.w,
                        color: AppColor.primaryColor,
                      ),
                    ),
                    GestureDetector(
                      onTap: widget.onSaved,
                      child: Icon(
                        widget.isSaved ? CupertinoIcons.bookmark_fill : CupertinoIcons.bookmark,
                        size: 30.w,
                        color: AppColor.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _shareContent() async {
    final String formattedParagraph = widget.feed.paragraph.replaceAll('. ', '\n\n');
    try {
      final tempDir = await getTemporaryDirectory();
      final imagePath = "${tempDir.path}/shared_image.jpg";

      // Download the image
      final response = await Dio().download(widget.feed.image, imagePath);

      final String textToShare =
        "${widget.feed.title.toUpperCase()}\n\n$formattedParagraph\n\nBy @${widget.feed.author}";
      await Share.shareXFiles([XFile(imagePath)], text: textToShare);

    } catch (e) {
      print("Error sharing content: $e");
    }
  }
}
