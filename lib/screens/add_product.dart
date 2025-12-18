import 'package:flutter/material.dart';
import 'package:mo_app/widgets/common_app_bar.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar:CommonAppBar(isHomePage: false,
        isProductListPage: true,
      title: "Add Products",
      ) ,
    );
  }
}
