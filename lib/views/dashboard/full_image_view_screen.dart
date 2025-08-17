import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
        child: Center(
          child: InteractiveViewer(
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              placeholder:
                  (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
              errorWidget:
                  (context, url, error) =>
                      const Icon(Icons.error, color: Colors.red, size: 50),
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
