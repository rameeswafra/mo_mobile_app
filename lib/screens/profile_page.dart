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
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: CommonAppBar(isHomePage: false,
        isProductListPage: true,
        title: "Profile",),
    );
  }
}
