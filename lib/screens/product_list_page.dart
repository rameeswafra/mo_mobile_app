import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mo_app/screens/product_detail_page.dart';
import 'package:mo_app/screens/search_screen.dart';
import 'package:provider/provider.dart';
import '../models/product_model.dart';
import '../providers/wishlist_provider.dart';
import '../widgets/common_app_bar.dart';
import '../widgets/common_section_header.dart';

class ProductListPage extends StatefulWidget {
  final List<ProductModel> products;

  const ProductListPage({super.key, required this.products});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  List<ProductModel> allProducts = [];
  List<ProductModel> filteredProducts = [];

  Set<int> favoriteIds = {};

  List<ProductModel> displayProducts = [];

  @override
  void initState() {
    super.initState();
    allProducts = widget.products;
    displayProducts = widget.products;
    filteredProducts = List.from(allProducts);
  }

  bool filterInStock = false;
  bool filterDiscounted = false;
  RangeValues priceRange = const RangeValues(0, 100);

  void sortHighToLow() {
    setState(() {
      filteredProducts.sort((a, b) => b.price.compareTo(a.price));
    });
  }

  void sortLowToHigh() {
    setState(() {
      filteredProducts.sort((a, b) => a.price.compareTo(b.price));
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final bgColor = isDark ? Colors.black : Colors.grey.shade100;
    final cardColor = isDark ? Colors.grey[900] : Colors.grey[50];
    final textPrimary = isDark ? Colors.white : Colors.black87;
    final searchText = isDark ? Colors.white : Colors.black87;
    final textSecondary = isDark ? Colors.white70 : Colors.grey;
    final hintColor = isDark ? Colors.white : Colors.black87;
    final searchBg = isDark ? Colors.grey[900] : Colors.white;
    final searchBorder = isDark ? Colors.grey.shade800 : Colors.grey.shade300;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: CommonAppBar(
        isHomePage: false,
        title: "Products",
        isProductListPage: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
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
                            SearchScreen(productList: widget.products),
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
              15.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: 80,
                    height: 35,
                    decoration: BoxDecoration(
                      color: cardColor,
                      border: Border.all(
                        color: isDark
                            ? Colors.grey.shade800
                            : Colors.grey.shade200,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                          ),
                          builder: (_) => StatefulBuilder(
                            builder: (context, setModalState) {
                              return SafeArea(
                                child: Padding(
                                  padding: EdgeInsets.all(15.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Filters",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SwitchListTile(
                                        title: const Text("In Stock Only"),
                                        value: filterInStock,
                                        onChanged: (val) {
                                          setModalState(
                                            () => filterInStock = val,
                                          );
                                        },
                                      ),
                                      SwitchListTile(
                                        title: const Text("Discounted Items"),
                                        value: filterDiscounted,
                                        onChanged: (val) {
                                          setModalState(
                                            () => filterDiscounted = val,
                                          );
                                        },
                                      ),
                                      10.verticalSpace,
                                      Text("Price Range"),
                                      RangeSlider(
                                        min: 0,
                                        max: 100000,
                                        divisions: 100,
                                        values: priceRange,
                                        labels: RangeLabels(
                                          "Rs ${priceRange.start.toInt()}",
                                          "Rs ${priceRange.end.toInt()}",
                                        ),
                                        onChanged: (values) {
                                          setModalState(
                                            () => priceRange = values,
                                          );
                                        },
                                      ),
                                      10.verticalSpace,
                                      Row(
                                        children: [
                                          Expanded(
                                            child: OutlinedButton(
                                              onPressed: () {
                                                setState(() {
                                                  filterInStock = false;
                                                  filterDiscounted = false;
                                                  priceRange =
                                                      const RangeValues(
                                                        0,
                                                        100000,
                                                      );
                                                });

                                                Navigator.pop(context);
                                              },
                                              child: const Text("Reset"),
                                            ),
                                          ),
                                          10.horizontalSpace,
                                          Expanded(
                                            child: ElevatedButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text("Apply"),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Filter", style: TextStyle(color: textPrimary)),
                          Icon(Icons.filter_alt, color: textPrimary),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              15.verticalSpace,
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: displayProducts.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.6,
                  ),
                  itemBuilder: (context, index) {
                    final product = displayProducts[index];
                    final inStock = product.stock > 0;

                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ProductDetailsPage(
                              products: product,
                              productList: widget.products,
                            ),
                          ),
                        );
                      },
                      child: Card(
                        color: cardColor,
                        elevation: isDark ? 1 : 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(16),
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl: product.thumbnail,
                                    height: 150,
                                    width: double.infinity,
                                    fit: BoxFit.contain,
                                    placeholder: (context, url) => Center(
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Colors.red,
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.broken_image, size: 30),
                                  ),
                                ),

                                if (product.discountPercentage > 1)
                                  Positioned(
                                    top: 8,
                                    left: 8,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.redAccent,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        "-${product.discountPercentage.toStringAsFixed(0)}%",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),

                                Positioned(
                                  top: 6,
                                  right: 6,
                                  child: Consumer<WishlistProvider>(
                                    builder: (context, wishlist, _) {
                                      final isFavorite = wishlist.isFavorite(
                                        product.id,
                                      );

                                      return IconButton(
                                        icon: AnimatedSwitcher(
                                          duration: const Duration(
                                            milliseconds: 300,
                                          ),
                                          child: Icon(
                                            isFavorite
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            key: ValueKey(isFavorite),
                                            color: Colors.red,
                                          ),
                                        ),
                                        iconSize: 30,
                                        onPressed: () {
                                          wishlist.toggleWishlist(product.id);
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),

                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.title,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: textPrimary,
                                    ),
                                  ),
                                  5.verticalSpace,
                                  Text(
                                    product.brand ?? "",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: textSecondary,
                                    ),
                                  ),
                                  5.verticalSpace,

                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: List.generate(5, (starIndex) {
                                          double rating = product.rating;
                                          if (starIndex < rating.floor()) {
                                            return const Icon(
                                              Icons.star,
                                              size: 16,
                                              color: Colors.orange,
                                            );
                                          } else if (starIndex < rating) {
                                            return const Icon(
                                              Icons.star_half,
                                              size: 16,
                                              color: Colors.orange,
                                            );
                                          } else {
                                            return const Icon(
                                              Icons.star_border,
                                              size: 16,
                                              color: Colors.orange,
                                            );
                                          }
                                        }),
                                      ),
                                      Text(
                                        inStock ? "In Stock" : "Out of Stock",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: inStock
                                              ? Colors.green
                                              : Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                  5.verticalSpace,
                                  Text(
                                    "Rs ${product.price}",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.green,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
