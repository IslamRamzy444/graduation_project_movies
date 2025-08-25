import 'package:flutter/material.dart';

import 'package:graduation_project_movies/utils/app_styles.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home",style: AppStyles.regular16PrimaryRoboto,),
      ),
    );
  }
}

