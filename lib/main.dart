import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mo_app/screens/main_screen.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          title: 'Mo Mobile App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.grey,
              elevation: 0,
            ),
            brightness: Brightness.light,
            fontFamily: GoogleFonts.poppins().fontFamily,
          ),
          home: CustomBottomNavBar(),
        );
      },
    );
  }
}
