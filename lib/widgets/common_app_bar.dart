import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isProductListPage;
  final bool isHomePage;
  final String? title;

  const CommonAppBar({
    super.key,
    required this.isProductListPage,
    required this.isHomePage,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: Colors.transparent,
      backgroundColor: Colors.grey.shade100,
      elevation: 0,
      leading: isHomePage
          ? IconButton(
              icon: const Icon(Icons.menu, color: Colors.black),
              onPressed: () {},
            )
          : IconButton(
              icon: const Icon(Icons.arrow_back_outlined, color: Colors.black),
              onPressed: () {
                Navigator.pop(context);
              },
            ),

      title: isHomePage
          ? Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [SvgPicture.asset("assets/svgs/image.svg", height: 35)],
            )
          : isProductListPage
          ? Center(
              child: Text(
                title ?? "",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
            )
          : SizedBox.shrink(),

      actions: [
        Row(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(PhosphorIconsBold.bell, color: Colors.black),
                Positioned(
                  top: -1,
                  right: -1,
                  child: Container(
                    width: 15,
                    height: 15,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        "9+",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(width: 20),
            Icon(PhosphorIconsBold.shoppingCart, color: Colors.black),
            SizedBox(width: 40),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
