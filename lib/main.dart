import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';

import 'userscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  MaterialColor mycolor = const MaterialColor(
    0xFF606BA1,
    <int, Color>{
      50: Color(0xFF606BA1),
      100: Color(0xFF606BA1),
      200: Color(0xFF606BA1),
      300: Color(0xFF606BA1),
      400: Color(0xFF606BA1),
      500: Color(0xFF606BA1),
      600: Color(0xFF606BA1),
      700: Color(0xFF606BA1),
      800: Color(0xFF606BA1),
      900: Color(0xFF606BA1),
    },
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // ignore: deprecated_member_use
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      title: 'BMI Calculator',
      theme: ThemeData(
        primaryColor: const Color(0xFF606BA1),
        primarySwatch: mycolor,
        scaffoldBackgroundColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      home: UserInfoScreen(),
    );
  }
}
