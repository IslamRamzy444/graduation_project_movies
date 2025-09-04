import 'package:flutter/material.dart';
import 'package:graduation_project_movies/utils/app_assets.dart';

class ScreenShotCard extends StatelessWidget {
  String imageUrl;
  ScreenShotCard({super.key,required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: (imageUrl.isNotEmpty)?Image.network(imageUrl):Image.asset(AppAssets.availableNowImage),
    );
  }
}