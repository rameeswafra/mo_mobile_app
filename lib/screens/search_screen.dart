import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mo_app/screens/product_detail_page.dart';

import '../models/product_model.dart';

class SearchScreen extends StatefulWidget {
  final List<ProductModel> productList;

  const SearchScreen({super.key, required this.productList});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();

  List<ProductModel> filteredProducts = [];

  @override
  void initState() {
    super.initState();
    filteredProducts = widget.productList;
  }

  void filterProducts(String query) {
    setState(() {
      filteredProducts = widget.productList
          .where(
            (product) =>
                product.title.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final searchBg = isDarkMode ? Colors.grey[900] : Colors.white;
    final searchBorder = isDarkMode
        ? Colors.grey.shade800
        : Colors.grey.shade300;
    final searchText = isDarkMode ? Colors.white : Colors.black87;
    final hintColor = theme.colorScheme.onSurface.withOpacity(0.6);


    return Scaffold(
      backgroundColor: searchBg,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: searchBg,
        elevation: 0,
        iconTheme: IconThemeData(color: searchText),
        title: Container(
          height: 45,
          decoration: BoxDecoration(
            color: searchBg,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: searchBorder, width: 1.5),
          ),
          child: TextField(
            controller: searchController,
            autofocus: true,
            style: TextStyle(color: searchText),
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search, color: hintColor,size: 28,),
              hintText: "Search any products",
              hintStyle: TextStyle(color: hintColor),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 12),
            ),
            onChanged: filterProducts,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: filteredProducts.length >4 ? 4 :filteredProducts.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              filteredProducts[index].title,
              style: TextStyle(color: searchText),
            ),
            onTap: () {
              print("Selected: ${filteredProducts[index]}");

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      ProductDetailsPage(products: filteredProducts[index],
                      productList: filteredProducts,
                      ),
                ),
              );
            },
            leading: SizedBox(
              width: 100,
              height: 100,
              child: CachedNetworkImage(
                imageUrl: filteredProducts[index].thumbnail,
                height: 300,
                width: double.infinity,
                fit: BoxFit.contain,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.red,
                  ),
                ),
                errorWidget: (context, url, error) =>
                    Icon(Icons.broken_image, size: 30),
              ),
            ),
          );
        },
      ),
    );
  }
}
