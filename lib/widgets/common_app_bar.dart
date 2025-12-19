import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isProductListPage;
  final bool isHomePage;
  final VoidCallback? backButtonPress;
  final String? title;

  const CommonAppBar({
    super.key,
    required this.isProductListPage,
    required this.isHomePage,
    this.title,
    this.backButtonPress,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    final backgroundColor = isDarkMode ? Colors.grey[900] : Colors.grey[100];
    final iconColor = isDarkMode ? Colors.white : Colors.black;
    final textColor = isDarkMode ? Colors.white : Colors.black;

    return AppBar(
      surfaceTintColor: Colors.transparent,
      backgroundColor: backgroundColor,
      elevation: 0,
      leading: isHomePage
          ? IconButton(
              icon: Icon(Icons.menu, color: iconColor),
              onPressed: () {},
            )
          : IconButton(
              icon: Icon(Icons.arrow_back_outlined, color: iconColor),
              onPressed:
                  backButtonPress ??
                  () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  },
            ),
      title: isHomePage
          ? Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  "assets/svgs/image.svg",
                  height: 35,
                  color: isDarkMode ? Colors.white : Colors.red,
                ),
              ],
            )
          : isProductListPage
          ? Center(
              child: Text(
                title ?? "",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
            )
          : SizedBox.shrink(),
      actions: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Icon(PhosphorIconsBold.bell, color: iconColor),
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
                          "10",

                          style: TextStyle(
                            fontSize: 7,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,

                          ),

                        ),
                      ),
                    ),
                  ),
                ],
              ),
              12.horizontalSpace,
              Icon(PhosphorIconsBold.shoppingCart, color: iconColor),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
