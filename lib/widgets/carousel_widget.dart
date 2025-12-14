import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProductCarousel extends StatelessWidget {
  final List<String> productImages = [
    "assets/svgs/banner.svg",
    "assets/svgs/banner2.svg",
    "assets/svgs/banner3.svg",
    "assets/svgs/banner4.svg",

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
          borderRadius: BorderRadius.circular(12),
          child: SvgPicture.asset(
            item,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
        ),
      )).toList(),

    );
  }
}
