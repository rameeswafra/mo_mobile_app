import 'package:flutter/material.dart';

import '../widgets/common_app_bar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? Colors.grey[900] : Colors.grey[100];
    return Scaffold(
      backgroundColor: bgColor,
      appBar: CommonAppBar(
        isHomePage: false,
        isProductListPage: true,
        title: "Profile",
      ),
    );
  }
}
