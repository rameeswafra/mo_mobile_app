import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProductCarousel extends StatelessWidget {
  final List<String> productImages = [
    "assets/pngs/mo_1.png",
    "assets/pngs/mo_2.png",
    "assets/pngs/mo_3.png",
    "assets/pngs/mo_4.png",

  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        enlargeCenterPage: true,
        viewportFraction: 0.8,
        aspectRatio: 16/9,
        autoPlayInterval: Duration(seconds: 3),
      ),
      items: productImages.map((item) => Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            height: 190,
            width: double.infinity,
            color: Colors.grey.shade100,
            padding: const EdgeInsets.all(12),
            child: Image.asset(
              item,
              fit: BoxFit.contain,
            ),
          ),
        ),

      )).toList(),

    );
  }
}
