import 'package:flutter/material.dart';
import 'package:mo_app/widgets/common_app_bar.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: CommonAppBar(isHomePage: false,
      isProductListPage: true,
      title: "Category Page",),
    );
  }
}
