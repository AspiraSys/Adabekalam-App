//  THIS IS WITH TABBAR
import 'package:cloud_firestore/cloud_firestore.dart' show DocumentSnapshot;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shayari_app/firebase/firebase_service.dart';
import 'package:shayari_app/model/feeds_model.dart';
import 'package:shayari_app/utils/logger.dart' show logger;
import 'package:shayari_app/widgets/feed_card.dart';
import 'package:shayari_app/widgets/language_selection.dart';
import 'package:shayari_app/widgets/poet_card.dart';
import 'package:shayari_app/widgets/text.dart';
import '../../constant/app_color.dart';
import '../../controllers/feed_provider.dart';
import '../../controllers/language_selection.dart';
import '../../controllers/page_view.dart';
import '../../controllers/poet_selection.dart';
import '../../controllers/search_provider.dart';
import '../../model/poet_model.dart';
import '../../utils/get_user.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/poet_name_list.dart';
import '../appbar/appbar.dart';
import '../poet/poet_profile.dart';


class CollectionPage extends StatefulWidget {
  const CollectionPage({super.key});
  @override
  State<CollectionPage> createState() => _CollectionPageState();
}
class _CollectionPageState extends State<CollectionPage> {
  final PageController _pageController = PageController();
  final TextEditingController _searchController = TextEditingController();
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
      backgroundColor: AppColor.blackColor,
      appBar: ReusableAppbar(title: "Adab-E-Kalam", hasBackButton: false),
      body: Padding(
        padding: EdgeInsets.only(top: 20.h),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.r),
              topRight: Radius.circular(10.r),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextfield(hintText: "Search...", controller: _searchController,
                onChanged: (value){
                      Provider.of<SearchProvider>(context, listen: false).updateQuery(value);
                },
                ),
                SizedBox(height: 10.h),
                Consumer<PageViewController>(
                  builder: (context, pageController, child) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildTab(pageController, "Collections", 0, pageController.currentIndex == 0 ? true : false),
                        _buildTab(pageController, "Poets", 1,  pageController.currentIndex == 1 ? true : false),
                      ],
                    );
                  },
                ),
                SizedBox(height: 20.h),
                LanguageSelection(),
                SizedBox(height: 10.h),
                Expanded(
                  child: Consumer<PageViewController>(
                    builder: (context, pageController, child) {
                      return PageView(
                         physics: NeverScrollableScrollPhysics(),
                        controller: _pageController,
                        onPageChanged: (index) {
                          pageController.changePage(index);
                        },
                        children: [
                          _buildCollectionsPage(),
                          _buildPoetsPage(),
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
  Widget _buildTab(PageViewController pageController, String title, int index, bool isHeader) {
    return GestureDetector(
      onTap: () {
        pageController.changePage(index);
        _pageController.jumpToPage(index);
      },
      child: AppText(
        text: title,
        color: pageController.currentIndex == index ? AppColor.whiteColor : AppColor.greyColor,
        fontSize: 23.sp,
        isHeader: isHeader,
      ),
    );
  }
  Widget _buildCollectionsPage() {
    return Column(
      children: [
          Consumer<LanguageProvider>(
                  builder: (context, lang, child) {
                    return StreamBuilder<List<Poet>>(
                      stream: FirebaseService.getPoetBasedOnLanguage(lang.selectedLanguage),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: SizedBox());
                        }
                        if (snapshot.hasError) {
                          logger.e(snapshot.error);
                          return Center(child: Text("Error loading data"));
                        }
                        if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return SizedBox(height: 45.h, width: double.infinity);
                        }
                        final datas = snapshot.data!;
                        return SizedBox(
                          width: double.infinity,
                          height: 45.h,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: datas.length + 1,
                            itemBuilder: (context, index) {
                              String name = (index == 0) ? "ALL" : datas[index - 1].name;
                              return Consumer<PoetSelection>(
                                  builder: (context, controller, child) {
                                return GestureDetector(
                                  onTap: () {
                                    controller.togglePoetSelection(index, name);
                                    logger.d(controller.selectedPoet);
                                  },
                                  child: PoetNameList(
                                    isSelected: controller.isPoetSelected(index),
                                    name: name,
                                  ),
                                );
                              });
                            },
                          ),
                        );
                      },
                    );
                  }
                ),
              
        FutureBuilder<List<String>>(
          future: _loadSelectedMoods(),
          builder: (context, moodSnapshot) {
            if (moodSnapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (!moodSnapshot.hasData || moodSnapshot.data!.isEmpty) {
              return Center(child: Text("No moods selected"));
            }
            List<String> selectedMoods = moodSnapshot.data!;
            return Consumer<LanguageProvider>(
              builder: (context, langController, child) {
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
                      return Consumer2<FeedProvider, SearchProvider>(
                      builder: (context, feedProvider, searchProvider,  child) {
                        var provider = Provider.of<PoetSelection>(context, listen: true);
                        String query = searchProvider.query.toLowerCase();

                            var filteredFeeds = feedProvider.feeds.where((feed) {
      return feed.paragraph.toLowerCase().contains(query) || 
             feed.title.toLowerCase().contains(query);
    }).toList();
                        return Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: filteredFeeds.length,
                            itemBuilder: (context, index) {
                              final feed = filteredFeeds[index];
                                  if(feed.language.toLowerCase() == langController.selectedLanguage.toLowerCase()){
                                    if(feed.author == provider.selectedPoet || provider.selectedPoet == "ALL"){
                                         return FeedCard(
                                    onSaved: () => feedProvider.toggleSaved(feed.id),
                                    isSaved: feed.saved.contains(feedProvider.deviceId),
                                      feed: feed,
                                      isLiked: feed.likes.contains(feedProvider.deviceId),
                                      onLike: () => feedProvider.toggleLike(feed.id),
                                    );
                                    }
                                  }
                                  return SizedBox();
                            },
                          ),
                        );
                      },
                    );
                  },
                );
              },
            );
          },
        ),
      ],
    );
  }
  Widget _buildPoetsPage() {
    return Consumer<LanguageProvider>(
      builder: (context, lang, child) {
         logger.d("Current language: ${lang.selectedLanguage}");
        return StreamBuilder<List<Poet>>(
          stream: FirebaseService.getPoetBasedOnLanguage(lang.selectedLanguage),
          builder: (context, snapshot) {
            // if (snapshot.connectionState == ConnectionState.waiting) {
            //   return Center(child: CircularProgressIndicator());
            // }
            // if (!snapshot.hasData || snapshot.data!.isEmpty) {
            //   return Center(child: Text("No poets available"));
            // }
             if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            logger.e("Error loading poets: ${snapshot.error}");
            return Center(child: Text("Error loading poets"));
          }
           if (!snapshot.hasData || snapshot.data!.isEmpty) {
            logger.w("No poets found for ${lang.selectedLanguage}");
            return Center(child: Text("No poets available for ${lang.selectedLanguage}"));
          }
            final poets = snapshot.data!;
            return ListView.builder(
              itemCount: poets.length,
              itemBuilder: (context, index) {
                final poet = poets[index];
                return GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => PoetProfile(
                          image: poet.image, 
                          language: poet.language,
                          name: poet.name,
                          )));
                      },
                      child: PoetCard(name: poet.name, language: poet.language, mood: poet.mood, image: poet.image));
              },
            );
          },
        );
      },
    );
  }
}