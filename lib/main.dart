import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:shayari_app/views/explore/controller/explore_controller.dart';
import 'package:shayari_app/views/splash%20screen/splash_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'constant/app_theme.dart';
import 'controllers/feed_provider.dart';
import 'controllers/language_selection.dart';
import 'controllers/page_view.dart';
import 'controllers/poet_selection.dart';
import 'controllers/search_provider.dart';
import 'controllers/theme_provider.dart';
import 'views/bottom navigation/controller/bottomnav_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // await Firebase.initializeApp(
  //   options: FirebaseOptions(
  //   apiKey: 'AIzaSyBBdb1iBbTRMR9HTVl3t9ALmstm8SUYXwE',
  //   appId: '1:660171371502:web:f59aa59c0d84f5bd1b94ff',
  //   messagingSenderId: '660171371502',
  //   projectId: 'shayari-0',
  //   authDomain: 'shayari-0.firebaseapp.com',
  //   storageBucket: 'shayari-0.firebasestorage.app',
  //   measurementId: 'G-YY9GWZV9PZ',
  //   )
  // );
  runApp(
    // const MyApp()
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => ExploreController()),
      ChangeNotifierProvider(create: (context) => BottomNavController()),
      ChangeNotifierProvider(create: (context) => LanguageProvider()),
      ChangeNotifierProvider(create: (context) => PoetSelection()),
        ChangeNotifierProvider(create: (_) => PageViewController()),
        ChangeNotifierProvider(create: (_) => FeedProvider()),
        ChangeNotifierProvider(create: (_) => SearchProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
    ], child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
      final themeProvider = Provider.of<ThemeProvider>(context);
    return ScreenUtilInit(
      builder: (context, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Shayari',
      // theme: ThemeData.light(),
      // darkTheme: ThemeData.dark(),
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.themeMode,
          home: const SplashScreen()),
      designSize: const Size(412, 917),
      minTextAdapt: true,
      splitScreenMode: true,
    );
  }
}
