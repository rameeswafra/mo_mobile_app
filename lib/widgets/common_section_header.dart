import 'package:flutter/material.dart';

class CommonSectionHeader extends StatelessWidget {
  final String title;
  final double? fontSize;
  final FontWeight? fontWeight;


  const CommonSectionHeader({
    super.key,
    required this.title,
    this.fontSize,
    this.fontWeight,

  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Row(
        children: [
          Row(
            children: [
              Text(
                title,
                style:  TextStyle(
                  fontSize: fontSize?? 18,
                  fontWeight: fontWeight ?? FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
