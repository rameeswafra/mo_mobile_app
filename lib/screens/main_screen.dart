import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mo_app/screens/add_product.dart';
import 'package:mo_app/screens/category_screen.dart';
import 'package:mo_app/screens/profile_page.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'chat_screen.dart';
import 'home_screen.dart';

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({super.key});

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  int selectedIndex = 0;

  final pages = const [
    HomeScreen(),
    CategoryScreen(),
    AddProductScreen(),
    ChatScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final bottomBarColor = isDarkMode ? Colors.grey[900] : Colors.white;
    final selectedColor = Colors.red;
    final unselectedColor = isDarkMode ? Colors.grey[400]! : Colors.black54;

    final fabBgColor = isDarkMode ? Colors.white : Colors.red;
    final fabIconColor = isDarkMode ? Colors.black : Colors.white;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: pages[selectedIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            selectedIndex = 2;
          });
        },
        backgroundColor: fabBgColor,
        elevation: 8,
        child: Icon(PhosphorIcons.plus(), color: fabIconColor, size: 30),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8,
        elevation: 10,
        color: bottomBarColor,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildNavItem(
                index: 0,
                icon: PhosphorIconsBold.house,
                label: "Home",
                selectedColor: selectedColor,
                unselectedColor: unselectedColor,
              ),
              buildNavItem(
                index: 1,
                icon: PhosphorIconsBold.squaresFour,
                label: "Categories",
                selectedColor: selectedColor,
                unselectedColor: unselectedColor,
              ),
              12.horizontalSpace,
              buildNavItem(
                index: 3,
                icon: PhosphorIconsBold.chatCircleText,
                label: "Chats",
                selectedColor: selectedColor,
                unselectedColor: unselectedColor,
              ),
              buildNavItem(
                index: 4,
                icon: PhosphorIconsBold.userCircle,
                label: "Profile",
                selectedColor: selectedColor,
                unselectedColor: unselectedColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildNavItem({
    required int index,
    required IconData icon,
    required String label,
    required Color selectedColor,
    required Color unselectedColor,
  }) {
    final isSelected = selectedIndex == index;
    final color = isSelected ? selectedColor : unselectedColor;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color),
          5.verticalSpace,
          Text(label, style: TextStyle(color: color, fontSize: 12)),
        ],
      ),
    );
  }
}
