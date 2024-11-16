import 'package:flutter/material.dart';
import 'package:video_app/pages/firstpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home: VideoScreen(),
      theme: ThemeData(
        primaryColor: Color(0xa0d2eb), // Blue Light
        scaffoldBackgroundColor: Color(0x7c677f), // Freeze Purple
        appBarTheme: AppBarTheme(
          color: Color(0xFF8458B3), // Purple Pain
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Color(0xe5eaf5), // Blue Light
        ),


      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
