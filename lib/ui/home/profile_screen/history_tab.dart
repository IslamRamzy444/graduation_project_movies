import 'package:flutter/material.dart';
import 'package:graduation_project_movies/utils/app_assets.dart';

class HistoryTab extends StatelessWidget {
  const HistoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image.asset(AppAssets.emptyWatchList, height: 124, width: 124),
      ),
    );
  }
}
