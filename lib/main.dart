import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mo_app/screens/main_screen.dart';

void main() {

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      child: MaterialApp(
        title: 'Mo Mobile App',
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
          theme: ThemeData(
            brightness: Brightness.light,
            fontFamily: 'Poppins',
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.grey,
              elevation: 0,
            ),
          ),
      
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            fontFamily: 'Poppins',
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.black,
              elevation: 0,
            ),
          ),
      
        home: CustomBottomNavBar(),
      ),
    );
  }
}
