import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ProfileImagePreview extends StatelessWidget {
  static const String routeName = "ProfileImagePreview";
  final String imageUrl;
  final String userName;

  const ProfileImagePreview({
    super.key,
    required this.imageUrl,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "$userName's Profile Picture",
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: PhotoView(
          imageProvider: NetworkImage(imageUrl),
          backgroundDecoration: const BoxDecoration(color: Colors.black),
        ),
      ),
    );
  }
}
