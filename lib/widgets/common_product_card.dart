import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String labelName;
  final double price;
  final double? oldPrice;
  final String? discount;
  final VoidCallback? onTap;
  final bool isShowLabel;
  final bool isDiscountShow;

  const ProductCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.labelName,
    this.oldPrice,
    this.discount,
    this.isShowLabel = false,
    this.isDiscountShow = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    final cardColor = isDarkMode ? Colors.grey[900] : Colors.white;
    final titleColor = isDarkMode ? Colors.white : Colors.black87;
    final priceColor = isDarkMode ? Colors.greenAccent : Colors.green;
    final oldPriceColor = isDarkMode ? Colors.grey : Colors.grey.shade600;
    final discountColor = isDarkMode ? Colors.redAccent : Colors.red;
    final shadowColor = isDarkMode
        ? Colors.black.withOpacity(0.5)
        : Colors.grey.withOpacity(0.3);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150,
        height: 50,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: shadowColor,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    height: 95,
                    width: double.infinity,
                    fit: BoxFit.contain,
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.red,
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.broken_image, size: 30),
                  ),
                ),
                if (labelName.isNotEmpty)
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      decoration: BoxDecoration(
                        color: getLabelColor(labelName),
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: Row(
                        children: [
                          Text(
                            labelName,
                            style: const TextStyle(
                              fontSize: 6.5,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(
                            getIconData(labelName),
                            size: 12,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
            Padding(
              padding:  EdgeInsets.all( 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: titleColor,
                    ),
                  ),
                  10.verticalSpace,
                  Text(
                    "Rs. ${price.toString()}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: priceColor,
                    ),
                  ),
                  5.verticalSpace,
                  if (isDiscountShow)
                    Row(
                      children: [
                        Text(
                          oldPrice != null ? "Rs ${oldPrice.toString()}" : "",
                          style: TextStyle(
                            fontSize: 12,
                            color: oldPriceColor,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        8.horizontalSpace,
                        Text(
                          discount ?? "",
                          style: TextStyle(
                            fontSize: 12,
                            color: discountColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Color getLabelColor(String label) {
  switch (label.toUpperCase()) {
    case "NEW":
      return Colors.greenAccent;
    case "DESIGNER":
      return Colors.redAccent;
    case "TOP BUY":
      return Colors.orangeAccent;
    default:
      return Colors.grey;
  }
}

IconData getIconData(String label) {
  switch (label.toUpperCase()) {
    case "RECENT":
      return Icons.access_alarm;
    case "DESIGNER":
      return Icons.brush;
    case "TOP BUY":
      return Icons.star;
    default:
      return Icons.label;
  }
}
