import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final List<Color> gradientColors;

  const CategoryItem({
    super.key,
    required this.icon,
    required this.title,
    required this.gradientColors,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    final titleColor =
    isDarkMode ? Colors.white70 : Colors.black87;

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Container(
            height: 64,
            width: 54,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: gradientColors,
              ),
              boxShadow: [
                BoxShadow(
                  color: gradientColors.last.withOpacity(
                      isDarkMode ? 0.6 : 0.35),
                  blurRadius: 60,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 28,
            ),
          ),
         5.verticalSpace,
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: titleColor,
            ),
          ),
        ],
      ),
    );
  }
}


class CategoryContainer extends StatelessWidget {
  final List<CategoryItem> categories;

  const CategoryContainer({
    super.key,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    final bgColor =
    isDarkMode ? Colors.grey[900] : Colors.white;
    final borderColor =
    isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 112,
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: bgColor,
            border: Border.all(color: borderColor, width: 1.5),
            borderRadius: BorderRadius.circular(15),
          ),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            separatorBuilder: (_, __) =>
            const SizedBox(width: 12),
            itemBuilder: (context, index) {
              return categories[index];
            },
          ),
        ),
      ],
    );
  }
}

