import 'package:flutter/material.dart';
import '../widgets/common_app_bar.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: CommonAppBar(isHomePage: false,
        isProductListPage: true,
        title: "Chat Page",),
    );
  }
}
