


//  THIS IS WITH TABBAR
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shayari_app/constant/styles.dart';
import 'package:shayari_app/firebase/firebase_service.dart';
import 'package:shayari_app/model/feeds_model.dart';
import 'package:shayari_app/widgets/text.dart';
import '../../constant/app_color.dart';
import '../../controllers/feed_provider.dart';
import '../../controllers/page_view.dart';
import '../../widgets/feed_card.dart';
import '../appbar/appbar.dart';


class PoetProfile extends StatefulWidget {
  String name;
  String language;
  String image;
  
   PoetProfile({super.key, required this.image, required this.name, required this.language});

  @override
  State<PoetProfile> createState() => _PoetProfileState();
}

class _PoetProfileState extends State<PoetProfile> {
  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    final PageViewController providerController = Provider.of(context, listen: true);
    return Scaffold(
      backgroundColor: 
      AppColor.primaryColor,
      appBar: ReusableAppbar(title: "Adab-E-Kalam", hasBackButton: false),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColor.blackColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.r),
            topRight: Radius.circular(10.r),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Center(
                  child: Container(
                    color: AppColor.blackColor,
                      height: 
                      providerController.currentProfileIndex == 0 ? 
                      380.h : 
                      280.h,
                      width: 
                       providerController.currentProfileIndex == 0 ? 
                       double.infinity : 
                      180.w,
                      child: Image.network(
                      widget.image,
                       
                    fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 25.h,
                  left: 25.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(text: widget.name, fontSize: 23.sp,),
                      AppText(text: "${widget.language} POET", fontSize: 15.sp, fontWeight: FontWeight.normal,),
                    ],
                  )),
                  Positioned(
                    top: 25.h,
                    left: 25.w,
                    child: GestureDetector(
                      onTap: ()=> Navigator.pop(context),
                      child: Icon(Icons.arrow_back_ios, color: AppColor.whiteColor,)))
              ],
            ),
            Consumer<PageViewController>(
              builder: (context, pageController, child) {
                return Container(
                  color: AppColor.primaryColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildTab(pageController, "About", 0, pageController.currentProfileIndex == 0 ? true : false),
                      _buildTab(pageController, "Posts", 1,  pageController.currentProfileIndex == 1 ? true : false),
                    ],
                  ),
                );
              },
            ),
            Container(height: 20.h, color: AppColor.primaryColor,),
            Expanded(
              child: Consumer<PageViewController>(
                builder: (context, pageController, child) {
                  return Container(
                    color: AppColor.primaryColor,
                    child: PageView(
                       physics: NeverScrollableScrollPhysics(),
                      controller: _pageController,
                      onPageChanged: (index) {
                        pageController.changeProfileIndex(index);
                      },
                      children: [
                        about(),
                        posts(),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildTab(PageViewController pageController, String title, int index, bool isHeader) {
    return Container(
      color: AppColor.primaryColor,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
        child: GestureDetector(
          onTap: () {
            pageController.changeProfileIndex(index);
            _pageController.jumpToPage(index);
          },
          child: AppText(
            text: title,
            color: pageController.currentProfileIndex == index ? AppColor.whiteColor : AppColor.greyColor,
            fontSize: 23.sp,
            isHeader: isHeader,
          ),
        ),
      ),
    );
  }

 Widget about() {
  return SingleChildScrollView(
    child: StreamBuilder(
      stream: FirebaseService().getPoetProfile(widget.name),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }
        var data = snapshot.data![0];
        return Column(
          children: [
            buildContainer(
              content: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                child: AppText(
                  text: data.about,
                  color: AppColor.blackColor,
                  fontWeight: FontWeight.normal,
                  fontSize: 13,
                ),
              ),
            ),
            buildContainer(
              content: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      text: 'EDUCATION',
                      color: AppColor.blackColor,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(height: 10.h),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: data.education.map<Widget>((edu) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 5.h),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Text('• ', style: TextStyle(fontSize: 13, color: AppColor.blackColor)),
                              AppText(text: '• ', color: AppColor.blackColor,),
                              Expanded(
                                child: AppText(
                                  text: edu,
                                  color: AppColor.blackColor,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
             buildContainer(
              content: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      text: 'WORK',
                      color: AppColor.blackColor,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(height: 10.h),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: data.work.map<Widget>((edu) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 5.h),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText(text: '• ', color: AppColor.blackColor,),
                              Expanded(
                                child: AppText(
                                  text: edu,
                                  fontWeight: FontWeight.normal,
                                  color: AppColor.blackColor,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
        
          buildContainer(
              content: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      text: 'LEGACY',
                      color: AppColor.blackColor,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(height: 10.h),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: data.awards.map<Widget>((edu) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 5.h),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText(text: '• ', color: AppColor.blackColor,),
                              Expanded(
                                child: AppText(
                                  text: edu,
                                   fontWeight: FontWeight.normal,
                                  color: AppColor.blackColor,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
        
          ],
        );
      },
    ),
  );
}


  Widget posts() {
    return      
     FutureBuilder<List<DocumentSnapshot>>(
                  future: FirebaseService()
                      .poetFeed(widget.name),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return const Center(child: Text("Error loading data"));
                    }

                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text("No feeds available"));
                    }

                    List<FeedModel> feeds = snapshot.data!
                        .map((doc) => FeedModel.fromJson(
                            doc.data() as Map<String, dynamic>))
                        .toList();

                    return Consumer<FeedProvider>(
                        builder: (context, provider, child) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: feeds.length,
                          itemBuilder: (context, index) {
                            final feed = feeds[index];


          // Load feeds into FeedProvider
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Provider.of<FeedProvider>(context, listen: false).loadFeeds(feeds);
          });

                                    return  FeedCard(
                                    onSaved: () => provider.toggleSaved(feed.id),
                                    isSaved: feed.saved.contains(provider.deviceId),
                                      feed: feed,
                                      isLiked: feed.likes.contains(provider.deviceId),
                                      onLike: () => provider.toggleLike(feed.id),
                                    );
                          },
                        ),
                      );
                    });
                  },
                );
         
  }
    Widget buildContainer({required Widget content}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
      child: Container(
        width: double.infinity,
        decoration: Styles.boxShadow,
        child: content,
      ),
    );

    
    
  }
}

