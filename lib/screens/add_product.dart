import 'package:flutter/material.dart';
import '../widgets/common_app_bar.dart';

class AddProductScreen extends StatelessWidget {
  const AddProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? Colors.grey[900] : Colors.grey[100];

    return Scaffold(
      backgroundColor: bgColor,
      appBar: const CommonAppBar(
        isHomePage: false,
        isProductListPage: true,
        title: "Add Products",
      ),
      body: const Center(
        child: Text(
          "Add Products Screen",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
