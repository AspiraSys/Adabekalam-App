// import 'package:flutter/material.dart';
// import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';
// import '../../controllers/theme_provider.dart';

// class ThemeSwitch extends StatefulWidget {
//   const ThemeSwitch({super.key});
//   @override
//   _ThemeSwitchState createState() => _ThemeSwitchState();
// }

// class _ThemeSwitchState extends State<ThemeSwitch> {
//   final _controller = ValueNotifier<bool>(false);

//   @override
//   void initState() {
//     super.initState();
//     final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
//     _controller.value = themeProvider.themeMode == ThemeMode.dark;
//     _controller.addListener(_handleSwitchChange);
//   }

//   void _handleSwitchChange() {
//     final isDarkMode = _controller.value;
//     final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
//     themeProvider.toggleTheme(isDarkMode);
//   }

//   @override
//   void dispose() {
//     _controller.removeListener(_handleSwitchChange);
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final isDarkMode = Theme.of(context).brightness == Brightness.dark;
//     return AdvancedSwitch(
//       controller: _controller,
//       activeColor: isDarkMode ? Colors.green : Colors.blue,
//       inactiveColor: isDarkMode ? Colors.grey : Colors.grey[300]!,
//       activeChild: Text('Dark', style: TextStyle(color: isDarkMode ? Colors.white : Colors.black)),
//       inactiveChild: Text('Light', style: TextStyle(color: isDarkMode ? Colors.white : Colors.black)),
//       borderRadius: BorderRadius.all(Radius.circular(15)),
//       width: 60.0.w,
//       height: 25.0.h,
//       enabled: true,
//       disabledOpacity: 0.5,
//     );
//   }
// }