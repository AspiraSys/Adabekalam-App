import 'package:cloud_firestore/cloud_firestore.dart' show DocumentSnapshot;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart'
    show SharedPreferences;
import 'package:shayari_app/views/appbar/appbar.dart';
import '../../constant/app_color.dart';
import '../../controllers/feed_provider.dart';
import '../../controllers/language_selection.dart' show LanguageProvider;
import '../../firebase/firebase_service.dart' show FirebaseService;
import '../../model/feeds_model.dart';
import '../../utils/get_user.dart';
import '../../widgets/feed_card.dart';
import '../../widgets/slider.dart';
import '../../widgets/text.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> image = [
    'assets/happy.jpg',
    'assets/dream.jpg',
    'assets/inspirational.jpg',
  ];

  Future<List<String>> _loadSelectedMoods() async {
    return await LocalStorage.getSelectedMoods() ?? [];
  }

  @override
  void initState() {
    super.initState();
    _checkUserStatus();
  }

  Future<void> _checkUserStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final deviceId = prefs.getString('device_id')!;
    // Set device ID in FeedProvider
    Provider.of<FeedProvider>(context, listen: false).setDeviceId(deviceId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: ReusableAppbar(title: "Adab-E-Kalam", hasBackButton: false),
      body: CustomScrollView( // Wrap the body inside CustomScrollView
        slivers: [
          // ✅ SliverToBoxAdapter with PageView
          SliverToBoxAdapter(
            child: SizedBox(
              height: 420.h,
              child: Consumer<FeedProvider>(
                builder: (context, provider, child) {
                  return provider.topFeeds.isNotEmpty
                      ? ReusableSlider(
                          feeds: provider.topFeeds,
                          onPressed: () {},
                          onLike: (feedId) => provider.toggleLike(feedId),
                          onSave: (feedId) => provider.toggleSaved(feedId),
                          deviceId: provider.deviceId,
                        )
                      : Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ),

          // ✅ Sticky Header
          SliverPersistentHeader(
            pinned: true,
            delegate: _StickyHeaderDelegate(),
          ),

          // ✅ List View with Feed Items
          SliverToBoxAdapter(
            child: Consumer<LanguageProvider>(
              builder: (context, langController, child) {
                return FutureBuilder<List<String>>(
                  future: _loadSelectedMoods(),
                  builder: (context, moodSnapshot) {
                    if (moodSnapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (!moodSnapshot.hasData || moodSnapshot.data!.isEmpty) {
                      return Center(child: Text("No moods selected"));
                    }
                    List<String> selectedMoods = moodSnapshot.data!;
                    return FutureBuilder<List<DocumentSnapshot>>(
                      future: FirebaseService().fetchFilteredFeeds(selectedMoods),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }
                        if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return Center(child: Text("No feeds available"));
                        }
                        final feeds = snapshot.data!
                            .map((doc) => FeedModel.fromJson(doc.data() as Map<String, dynamic>))
                            .toList();
                        // Load feeds into FeedProvider
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          Provider.of<FeedProvider>(context, listen: false).loadFeeds(feeds);
                        });
                        return Consumer<FeedProvider>(
                          builder: (context, provider, child) {
                            return ListView.builder(
                              cacheExtent: 1000,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: feeds.length,
                              itemBuilder: (context, index) {
                                final feed = feeds[index];
                                return Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                                  child: FeedCard(
                                    onSaved: () => provider.toggleSaved(feed.id),
                                    isSaved: feed.saved.contains(provider.deviceId),
                                    feed: feed,
                                    isLiked: feed.likes.contains(provider.deviceId),
                                    onLike: () => provider.toggleLike(feed.id),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


// Ensure this class is defined before or within the _HomeScreenState
class _StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  double get minExtent => 50; 

  @override
  double get maxExtent => 50; 

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: AppColor.primaryColor,
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: AppText(
          text: "Feeds",
          fontFamily: 'nunito',
          fontSize: 21.sp,
          isHeader: true,
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;
}


