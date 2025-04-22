import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';
import '../constant/app_color.dart';
import '../model/feeds_model.dart';
import 'text.dart';
import 'package:path_provider/path_provider.dart';

class ReusableSlider extends StatefulWidget {
  final List<FeedModel> feeds;
  final double height;
  final VoidCallback onPressed;
  final ValueChanged<String> onLike; // callback for like
  final ValueChanged<String> onSave; // callback for save
  final String deviceId;

  const ReusableSlider({
    super.key,
    required this.feeds,
    this.height = 503,
    required this.onPressed,
    required this.onLike, 
    required this.onSave,
    required this.deviceId, 
  });

  @override
  State<ReusableSlider> createState() => _ReusableSliderState();
}

class _ReusableSliderState extends State<ReusableSlider> {
  int _currentIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      if (mounted) {
        setState(() {
          _currentIndex = (_currentIndex + 1) % widget.feeds.length;
        });
      }
    });
  }

  void _onSwipe(bool isNext) {
    setState(() {
      if (isNext) {
        _currentIndex = (_currentIndex + 1) % widget.feeds.length;
      } else {
        _currentIndex =
            (_currentIndex - 1 + widget.feeds.length) % widget.feeds.length;
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentFeed = widget.feeds[_currentIndex];
    return Stack(
      alignment: Alignment.center,
      children: [
        ClipRRect(
          child: Stack(
            children: [
              Image.network(
                currentFeed.image,
                height: widget.height.h,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Container(
                height: widget.height.h,
                width: double.infinity,
                color: Colors.black.withOpacity(0.6),
              ),
            ],
          ),
        ),
        Positioned(
          top: 20.h,
          left: 20.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                text: "Trending",
                isHeader: true,
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(height: 15.h),
              SizedBox(
                  width: 200.w,
                  child: AppText(
                    text: currentFeed.title.toUpperCase(),
                    color: AppColor.whiteColor,
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w800,
                  )),
              SizedBox(
                width: 200.w,
                height: 180.h,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: currentFeed.paragraph.split('.').map((line) {
                      if (line.trim().isEmpty) return SizedBox();
                      return Padding(
                        padding: EdgeInsets.only(bottom: 7.h),
                        child: AppText(
                          text: '${line.trim()}.',
                          color: AppColor.whiteColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: SizedBox(
                  width: 245.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText(
                        text: "@${currentFeed.author}",
                        color: AppColor.whiteColor,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.normal,
                      ),
                      AppText(
                        text: "@${currentFeed.language}",
                        color: AppColor.whiteColor,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.normal,
                      ),
                      AppText(
                        text: "@${currentFeed.category}",
                        color: AppColor.whiteColor,
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
                      onTap: () => widget.onLike(currentFeed.id), 
                      child: Icon(
                        currentFeed.likes.contains(widget.deviceId)
                            ? CupertinoIcons.heart_fill
                            : CupertinoIcons.heart,
                        size: 30.w,
                        color: AppColor.whiteColor,
                      ),
                    ),
                    GestureDetector(
                      onTap: () async{
                         final String formattedParagraph = currentFeed.paragraph.replaceAll('. ', '\n\n');
  try {
    // Get app's temporary directory
    final tempDir = await getTemporaryDirectory();
    final imagePath = "${tempDir.path}/shared_image.jpg";

    // Download the image
    final response = await Dio().download(currentFeed.image, imagePath);

    // Prepare text to share
    final String textToShare =
      "${currentFeed.title.toUpperCase()}\n\n$formattedParagraph\n\nBy @${currentFeed.author}";
    await Share.shareXFiles([XFile(imagePath)], text: textToShare);

  } catch (e) {
    print("Error sharing content: $e");
  }
                      },
                      child: Icon(
                        CupertinoIcons.share_up,
                        size: 30.w,
                        color: AppColor.whiteColor,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => widget.onSave(currentFeed.id), // passing the feed id
                      child: Icon(
                        currentFeed.saved.contains(widget.deviceId)
                            ? CupertinoIcons.bookmark_fill
                            : CupertinoIcons.bookmark,
                        size: 30.w,
                        color: AppColor.whiteColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 10.h,
          left: 15.w,
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => _onSwipe(false),
          ),
        ),
        Positioned(
          bottom: 10.h,
          right: 15.w,
          child: IconButton(
            icon: Icon(Icons.arrow_forward_ios, color: Colors.white),
            onPressed: () => _onSwipe(true),
          ),
        ),
        Positioned(
          bottom: 30.h,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              widget.feeds.length,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: EdgeInsets.symmetric(horizontal: 5.sp),
                width: _currentIndex == index ? 10.sp : 8.sp,
                height: _currentIndex == index ? 10.sp : 8.sp,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentIndex == index ? Colors.white : Colors.white54,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
