import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shayari_app/widgets/custom_button.dart';
import 'package:shayari_app/widgets/explore_cards.dart';
import '../../constant/app_color.dart';
import '../../constant/app_images.dart';
import '../../constant/device_id.dart' show getDeviceId;
import '../../firebase/firebase_service.dart' show FirebaseService;
import '../../widgets/text.dart';
import '../bottom navigation/bottom_nav.dart';
import 'controller/explore_controller.dart';

class Explore extends StatelessWidget {
  const Explore({super.key});

  @override
  Widget build(BuildContext context) {
    final List images = [
      AppAsset().peacefull,
      AppAsset().happy,
      AppAsset().joyful,
      AppAsset().inspirational,
      AppAsset().mysterious,
      AppAsset().rebellious,
      AppAsset().happy,
      AppAsset().romantic,
      AppAsset().dream,
    ];

    final List mood = [
      "PEACEFUL",
      "HAPPY",
      "JOYFUL",
      "INSPIRATIONAL",
      "MYSTERIOUS",
      "REBELLIOUS",
      "ROMANTIC",
      "DREAM",
      "SAD",
    ];

    void fetchDeviceId() async {
      String? deviceId = await getDeviceId();
      print("Device ID: $deviceId");
    }

    return Scaffold(
      backgroundColor: AppColor.blackColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColor.primaryColor, AppColor.blackColor],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(
                left: 40.w, right: 40.w, top: 210.h, bottom: 80.h),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AppText(
                    text: 'Find Your Feelings',
                    fontSize: 16.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  AppText(
                    text: 'What Are You Into?',
                    fontSize: 26.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  Expanded(
                    child: Consumer<ExploreController>(
                        builder: (context, controller, child) {
                      return Center(
                        child: SizedBox(
                          width: 320.w,
                          child: GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                              childAspectRatio: 0.9,
                            ),
                            itemCount: 9,
                            itemBuilder: (context, index) {
                              final String image = images[index];
                              final String title = mood[index];
                              final bool isSelected =
                                  controller.selectedMoods.contains(title);
                              return GestureDetector(
                                onTap: () {
                                  controller.toggleMoodSelection(title);
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5.r),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: isSelected
                                            ? Border.all(
                                                color: Colors.white, width: 1.w)
                                            : null),
                                    child: ExploreCards(
                                      imagePath: image,
                                      title: title,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    }),
                  ),
                  CustomButton(
                    title: "EXPLORE",
                    onPressed: () async {
                      String deviceId = await getDeviceId() as String;
                      var controller = Provider.of<ExploreController>(context,
                          listen: false);

                      if (controller.selectedMoods.isNotEmpty) {
                        await FirebaseService()
                            .saveUserData(deviceId, controller.selectedMoods);

                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        await prefs.setString('device_id', deviceId);
                        await prefs.setStringList(
                            'selected_moods', controller.selectedMoods);

                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BottomNavBar()));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content:
                                  Text("Please select at least one mood!")),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}