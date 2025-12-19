import 'package:flutter/material.dart';
import 'package:mo_app/screens/home_screen.dart';
import '../widgets/common_app_bar.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? Colors.grey[900] : Colors.grey[100];

    return Scaffold(
      backgroundColor: bgColor,
      appBar:  CommonAppBar(
        isHomePage: false,
        isProductListPage: true,
        title: "Let's Connect",
        backButtonPress: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => HomeScreen()),
          );
        },
      ),
    );
  }
}
