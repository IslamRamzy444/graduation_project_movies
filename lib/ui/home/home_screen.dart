import 'package:flutter/material.dart';
import 'package:graduation_project_movies/utils/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: Center(
          child: Text(
            'Consider it Home screen now :-)',
            style: TextStyle(
                color: AppColors.redColor,
                fontSize: 80,
                fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }
}
