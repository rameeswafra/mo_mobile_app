import 'package:flutter/material.dart';

class CommonEmptyWidget extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData? icon;

  const CommonEmptyWidget({
    super.key,
    required this.title,
    this.subtitle,
    this.icon = Icons.search_off,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final iconColor = isDarkMode ? Colors.grey[400] : Colors.grey[600];
    final titleColor = isDarkMode ? Colors.white : Colors.grey[800];

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 6),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: iconColor),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: titleColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
