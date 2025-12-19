import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mo_app/screens/product_detail_page.dart';
import 'package:mo_app/screens/product_list_page.dart' hide Product;
import 'package:mo_app/screens/search_screen.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../models/product_model.dart';
import '../services/product_services.dart';
import '../widgets/carousel_widget.dart';
import '../widgets/category_widget.dart';
import '../widgets/common_app_bar.dart';
import '../widgets/common_empty_widget.dart';
import '../widgets/common_product_card.dart';
import '../widgets/common_section_header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ProductModel> productList = [];
  bool isLoading = false;
  TextEditingController searchController = TextEditingController();

  initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    setState(() {
      isLoading = true;
    });
    try {
      final Products = await ProductsService.fetchProducts();
      if (Products.productModel.isNotEmpty) {
        productList.addAll(Products.productModel);
      } else if (Products.productModel.isEmpty) {
        print("List is empty ");
      }
    } catch (error) {
      print("Error is $error");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    final bgColor = isDarkMode ? Colors.black : Colors.grey.shade100;
    final searchBg = isDarkMode ? Colors.grey[900] : Colors.white;
    final searchBorder = isDarkMode
        ? Colors.grey.shade800
        : Colors.grey.shade300;
    final searchText = isDarkMode ? Colors.white : Colors.black87;
    final hintColor = isDarkMode ?Colors.white : Colors.black87;
    final arrowColor = isDarkMode ? Colors.white70 : Colors.black54;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: bgColor,
      appBar: CommonAppBar(isProductListPage: false, isHomePage: true),
      body: Padding(
        padding: EdgeInsets.all(6.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 52,
              width: double.infinity,
              decoration: BoxDecoration(
                color: searchBg,
                border: Border.all(color: searchBorder, width: 1.5),
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextField(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          SearchScreen(productList: productList),
                    ),
                  );
                },
                style: TextStyle(color: searchText),
                readOnly: true,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                  prefixIcon: Icon(Icons.search, color: hintColor, size: 28),
                  hintText: "Search any products",
                  hintStyle: TextStyle(fontSize: 15, color: hintColor),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  border: InputBorder.none,
                ),
              ),
            ),
            12.verticalSpace,
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonSectionHeader(title: "Key Featured"),
                    CategoryContainer(
                      categories: [
                        CategoryItem(
                          icon: Icons.phone_iphone,
                          title: 'Mobile',
                          gradientColors: [Colors.blue, Colors.purple],
                        ),
                        CategoryItem(
                          icon: Icons.directions_car,
                          title: 'Vehicles',
                          gradientColors: [
                            Color(0xFF232526),
                            Color(0xFF414345),
                          ],
                        ),
                        CategoryItem(
                          icon: PhosphorIcons.sparkle(),
                          title: 'Beauty',
                          gradientColors: [
                            Color(0xFFFF9A9E),
                            Color(0xFFFAD0C4),
                          ],
                        ),

                        CategoryItem(
                          icon: PhosphorIcons.tShirt(),
                          title: 'Fashion',
                          gradientColors: [
                            Color(0xFFA18CD1),
                            Color(0xFFFBC2EB),
                          ],
                        ),
                        CategoryItem(
                          icon: PhosphorIcons.dress(),
                          title: 'Women',
                          gradientColors: [
                            Color(0xFFFF758C),
                            Color(0xFFFF7EB3),
                          ],
                        ),
                        CategoryItem(
                          icon: Icons.pets,
                          title: 'Pet Supplies',
                          gradientColors: [
                            Color(0xFFFF758C),
                            Color(0xFFFF7EB3),
                          ],
                        ),
                        CategoryItem(
                          icon: Icons.sports_esports,
                          title: 'Gaming',
                          gradientColors: [Colors.green, Colors.teal],
                        ),
                        CategoryItem(
                          icon: Icons.health_and_safety,
                          title: 'Health & Nutrition',
                          gradientColors: [
                            Color(0xFF56AB2F),
                            Color(0xFFA8E063),
                          ],
                        ),
                        CategoryItem(
                          icon: Icons.camera_alt,
                          title: 'Photography',
                          gradientColors: [Colors.orange, Colors.red],
                        ),
                        CategoryItem(
                          icon: Icons.local_florist,
                          title: 'Nature',
                          gradientColors: [Colors.yellow, Colors.orange],
                        ),
                      ],
                    ),
                    ProductCarousel(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CommonSectionHeader(title: "Top Feature"),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    ProductListPage(products: productList),
                              ),
                            );
                          },
                          child: Icon(
                            Icons.arrow_forward_ios,
                            size: 25,
                            color: arrowColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 230,
                      child: isLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Colors.red,
                                strokeWidth: 2,
                              ),
                            )
                          : productList.isEmpty
                          ? const Center(
                              child: CommonEmptyWidget(
                                title: "No Products Found",
                              ),
                            )
                          : ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: productList.length,
                              itemBuilder: (context, index) {
                                return ProductCard(
                                  labelName: "TOP BUY",
                                  imageUrl: productList[index].thumbnail,
                                  title: productList[index].title,
                                  price: productList[index].price,
                                  oldPrice: 5000,
                                  discount: "60%",
                                  isDiscountShow: true,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => ProductDetailsPage(
                                          products: productList[index],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CommonSectionHeader(title: "MO Designer"),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    ProductListPage(products: productList),
                              ),
                            );
                          },
                          child: Icon(
                            Icons.arrow_forward_ios,
                            size: 25,
                            color: arrowColor,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 390,
                      child: isLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Colors.red,
                                strokeWidth: 2,
                              ),
                            )
                          : productList.isEmpty
                          ? const Center(
                              child: CommonEmptyWidget(
                                title: "No Products Found",
                              ),
                            )
                          : GridView.builder(
                              scrollDirection: Axis.horizontal,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 12,
                                    mainAxisExtent: 150,
                                    childAspectRatio: 0.7,
                                  ),
                              itemCount: productList.length,
                              itemBuilder: (context, index) {
                                return ProductCard(
                                  labelName: "DESIGNER",
                                  imageUrl: productList[index].thumbnail,
                                  title: productList[index].title,
                                  price: productList[index].price,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => ProductDetailsPage(
                                          products: productList[index],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
