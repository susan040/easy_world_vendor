import 'package:flutter/material.dart';

class FullImageViewScreen extends StatelessWidget {
  final String imageUrl;

  const FullImageViewScreen({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: SafeArea(
        child: Center(child: InteractiveViewer(child: Image.network(imageUrl))),
      ),
    );
  }
}
