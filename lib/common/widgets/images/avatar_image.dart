import 'dart:convert';
import 'package:flutter/material.dart';

class AvatarImage extends StatelessWidget {
  final String imageUrl;
  final double radius;

  const AvatarImage({
    super.key,
    required this.imageUrl,
    this.radius = 40.0,
  });

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: imageUrl.isNotEmpty
          ? (imageUrl.startsWith('data:image/')
              ? Image.memory(
                  base64Decode(imageUrl.split(',')[1]),
                  width: radius * 2,
                  height: radius * 2,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return _placeholder();
                  },
                )
              : Image.network(
                  imageUrl,
                  width: radius * 2,
                  height: radius * 2,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return _placeholder(); // Placeholder on error
                  },
                ))
          : _placeholder(),
    );
  }

  Widget _placeholder() {
    return Container(
      width: radius * 2,
      height: radius * 2,
      color: Colors.grey,
      child: const Icon(Icons.person, color: Colors.white),
    );
  }
}
