import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shayari_app/firebase/firebase_service.dart';
import 'package:shayari_app/model/feeds_model.dart';
import 'package:shayari_app/widgets/custom_fav_list.dart';
import 'package:shayari_app/widgets/text.dart';
import '../../constant/app_color.dart';
import '../../controllers/feed_provider.dart';
import '../../controllers/page_view.dart';
import '../appbar/appbar.dart';
import 'package:shimmer/shimmer.dart';

class Favorite extends StatefulWidget {
  const Favorite({super.key});

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkUserStatus();
    });
  }

  Future<void> _checkUserStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final deviceId = prefs.getString('device_id');
    if (deviceId != null) {
      Provider.of<FeedProvider>(context, listen: false).setDeviceId(deviceId);
    }
  }

  @override
  Widget build(BuildContext context) {
 
    return Scaffold(
      backgroundColor: AppColor.blackColor,
      appBar: ReusableAppbar(title: "Adab-E-Kalam", hasBackButton: false),
      body: Padding(
        padding: EdgeInsets.only(top: 20.h),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColor.primaryColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.r),
              topRight: Radius.circular(10.r),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.h),
                Consumer<PageViewController>(
                  builder: (context, pageController, child) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildTab(pageController, "Saved", 0, pageController.currentIndex == 0),
                        _buildTab(pageController, "Liked", 1, pageController.currentIndex == 1),
                      ],
                    );
                  },
                ),
                SizedBox(height: 20.h),
                Expanded(
                  child: Consumer<PageViewController>(
                    builder: (context, pageController, child) {
                      return PageView(
                         physics: NeverScrollableScrollPhysics(),

                        controller: _pageController,
                        onPageChanged: pageController.changePage,
                        children: [
                          _buildSavedList(),
                          _buildLikedList(),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTab(PageViewController pageController, String title, int index, bool isActive) {
    return GestureDetector(
      onTap: () {
        pageController.changePage(index);
        _pageController.jumpToPage(index);
      },
      child: AppText(
        text: title,
        color: isActive ? AppColor.whiteColor : AppColor.greyColor,
        fontSize: 23.sp,
        isHeader: isActive,
      ),
    );
  }

Widget _buildSavedList() {
  final feedProvider =  Provider.of<FeedProvider>(context, listen: false);
  return StreamBuilder<List<FeedModel>>(
    stream: FirebaseService().getSavedList(deviceId: feedProvider.deviceId),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator());
      }
      if (!snapshot.hasData || snapshot.data!.isEmpty) {
        return Center(child: Text("No Data"));
      }
      return GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.w,
          mainAxisSpacing: 10.h,
            childAspectRatio: (MediaQuery.of(context).size.width / 2) / (185.h + 90.h),

        ),
        itemCount: snapshot.data!.length,
        itemBuilder: (context, index) {
          final data = snapshot.data![index];
          return CustomFavList(
            isLiked: false,
            image: data.image,
            title: data.title,
          );
        },
      );
    },
  );
}

Widget _buildLikedList() {
  final feedProvider = Provider.of<FeedProvider>(context, listen: false);

  return StreamBuilder<List<FeedModel>>(
    stream: FirebaseService().getLikedList(deviceId: feedProvider.deviceId),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator());
      }
      if (!snapshot.hasData || snapshot.data!.isEmpty) {
        return Center(child: Text("No Data"));
      }
      return GridView.builder(
        shrinkWrap: true,
        cacheExtent: 1000,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.w,
          mainAxisSpacing: 10.h,
          childAspectRatio: (MediaQuery.of(context).size.width / 2) / (185.h + 90.h),
        ),
        itemCount: snapshot.data!.length,
        itemBuilder: (context, index) {
          final data = snapshot.data![index];
          return CustomFavList(
            isLiked: true,
            image: data.image,
            title: data.title,
          );
        },
      );
    },
  );
}


}


Widget _buildShimmerEffect(int count) {
  return GridView.builder(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: 10.w,
      mainAxisSpacing: 10.h,
      childAspectRatio: 1.4.h / 1.75.w,
    ),
    itemCount: count,
    itemBuilder: (context, index) {
      return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          height: 150.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
      );
    },
  );
}

