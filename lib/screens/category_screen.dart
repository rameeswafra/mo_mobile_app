import 'package:flutter/material.dart';
import 'package:mo_app/screens/home_screen.dart';
import 'package:mo_app/widgets/common_app_bar.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? Colors.grey[900] : Colors.grey[100];
    return Scaffold(
      backgroundColor: bgColor,
      appBar: CommonAppBar(
        isHomePage: false,
        isProductListPage: true,
        title: "Categories",
        backButtonPress: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => HomeScreen()),
          );
        },
      ),
    );
  }
}
