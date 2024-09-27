import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hrm_aqtech/utils/constants/image_paths.dart';

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
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius), // Border radius for the image
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
              : FadeInImage.assetNetwork(
                  placeholder: MyImagePaths.avatarPlaceholderImage,
                  image: imageUrl,
                  width: radius * 2,
                  height: radius * 2,
                  fit: BoxFit.cover,
                  imageErrorBuilder: (context, error, stackTrace) {
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
