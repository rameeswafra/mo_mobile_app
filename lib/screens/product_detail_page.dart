import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../models/product_model.dart';
import '../widgets/common_empty_widget.dart';
import '../widgets/common_product_card.dart';
import '../widgets/common_section_header.dart';

class ProductDetailsPage extends StatefulWidget {
  final ProductModel products;
  final List<ProductModel>? productList;

  ProductDetailsPage({super.key, required this.products, this.productList});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  @override
  Widget build(BuildContext context) {
    final similarProducts = (widget.productList ?? [])
        .where((product) => product.category == widget.products.category)
        .toList();
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final bgColor = isDarkMode ? Colors.black : Colors.grey.shade100;
    final cardColor = isDarkMode ? Colors.grey[900] : Colors.grey[50];
    final textPrimary = isDarkMode ? Colors.white : Colors.black87;
    final textSecondary = isDarkMode ? Colors.white70 : Colors.grey;
    final dividerColor = isDarkMode
        ? Colors.grey.shade800
        : Colors.grey.shade300;
    final appBarColor = isDarkMode ? Colors.black : Colors.grey.shade100;

    final inStock = widget.products.stock > 0;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text(
          widget.products.title,
          style: TextStyle(color: textPrimary),
        ),
        iconTheme: IconThemeData(color: textPrimary),
        surfaceTintColor: Colors.transparent,
        backgroundColor: appBarColor,
        elevation: 0,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CachedNetworkImage(
                  imageUrl: widget.products.thumbnail,
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      15.verticalSpace,
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              widget.products.title,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: textPrimary,
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          5.horizontalSpace,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'Rs.${widget.products.price}',
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                inStock
                                    ? "In Stock : ${widget.products.stock}"
                                    : "Out of Stock",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: inStock ? Colors.green : Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      15.verticalSpace,

                      Row(
                        children: [
                          ...List.generate(5, (index) {
                            final rating = widget.products.rating;
                            if (index < rating.floor()) {
                              return Icon(
                                Icons.star,
                                color: Colors.orange,
                                size: 20,
                              );
                            } else if (index < rating) {
                              return Icon(
                                Icons.star_half,
                                color: Colors.orange,
                                size: 20,
                              );
                            } else {
                              return Icon(
                                Icons.star_border,
                                color: Colors.orange,
                                size: 20,
                              );
                            }
                          }),
                          10.horizontalSpace,
                          Text(
                            "${widget.products.rating} (${widget.products.reviews.length} reviews)",
                            style: TextStyle(
                              fontSize: 14,
                              color: textSecondary,
                            ),
                          ),
                        ],
                      ),

                      15.verticalSpace,

                      Text(
                        "Product Overview",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: textPrimary,
                        ),
                      ),

                      15.verticalSpace,

                      Text(
                        widget.products.description,
                        style: TextStyle(fontSize: 16, color: textPrimary),
                      ),

                      15.verticalSpace,
                      Text(
                        widget.products.shippingInformation,
                        style: TextStyle(fontSize: 16, color: textPrimary),
                      ),
                      15.verticalSpace,
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: inStock ? () {} : null,
                              icon: const Icon(
                                Icons.shopping_cart,
                                color: Colors.white,
                              ),
                              label: const Text(
                                "Add to Cart",
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red.shade400,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                          10.horizontalSpace,
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: inStock ? () {} : null,
                              icon: const Icon(
                                Icons.payment,
                                color: Colors.white,
                              ),
                              label: const Text(
                                "Buy Now",
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,

                                  color: Colors.white,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      15.verticalSpace,

                      CommonSectionHeader(title: "More Images"),
                      Divider(color: dividerColor),

                      SizedBox(
                        height: 280,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.products.images.length,
                          itemBuilder: (context, index) {
                            return Image.network(widget.products.images[index]);
                          },
                        ),
                      ),

                      const CommonSectionHeader(title: "Customer Reviews"),
                      Divider(color: dividerColor),

                      widget.products.reviews.isEmpty
                          ? Text(
                              "No reviews yet.",
                              style: TextStyle(color: textSecondary),
                            )
                          : Column(
                              children: widget.products.reviews.map((review) {
                                return Card(
                                  color: cardColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  elevation: 3,
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 6,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              radius: 16,
                                              backgroundColor:
                                                  Colors.red.shade400,
                                              child: Text(
                                                review.reviewerName[0]
                                                    .toUpperCase(),
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            10.horizontalSpace,
                                            Expanded(
                                              child: Text(
                                                review.reviewerName,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: textPrimary,
                                                ),
                                              ),
                                            ),

                                            Row(
                                              children: List.generate(5, (
                                                index,
                                              ) {
                                                return Icon(
                                                  index < review.rating
                                                      ? Icons.star
                                                      : Icons.star_border,
                                                  color: Colors.orange,
                                                  size: 16,
                                                );
                                              }),
                                            ),
                                          ],
                                        ),

                                        8.verticalSpace,

                                        Text(
                                          review.comment,
                                          style: TextStyle(
                                            color: textPrimary,
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),

                      CommonSectionHeader(title: "Similar Products"),
                      Divider(color: dividerColor),
                      8.verticalSpace,
                      similarProducts.isEmpty
                          ? CommonEmptyWidget(
                              title: "No similar products found",
                            )
                          : SizedBox(
                              height: 250,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: similarProducts.length,
                                itemBuilder: (context, index) {
                                  return ProductCard(
                                    labelName: "NEW",
                                    imageUrl: similarProducts[index].thumbnail,
                                    title: similarProducts[index].title,
                                    price: similarProducts[index].price,
                                    isDiscountShow: true,
                                    oldPrice: 4500.00,
                                    discount: "Rs 600.00",
                                  );
                                },
                              ),
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
