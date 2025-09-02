import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_movies/ui/home/home_screen/cubit/category_states.dart';
import 'package:graduation_project_movies/ui/home/home_screen/cubit/categroy_view_model.dart';
import 'package:graduation_project_movies/utils/app_colors.dart';
import 'package:graduation_project_movies/utils/app_routes.dart';

import '../../../utils/app_styles.dart';
import 'film_card.dart';

class CategoryItem extends StatefulWidget {
  CategoryItem({super.key});

  @override
  State<CategoryItem> createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  static final CategoriesViewModel categoriesViewModel = CategoriesViewModel();

  @override
  void initState() {
    super.initState();
    categoriesViewModel.getAllCategories();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return BlocBuilder(
        bloc: categoriesViewModel,
        builder: (context, state) {
          if (state is CategoriesSuccess) {
            return Column(
              children: [
                SizedBox(
                  height: height * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      categoriesViewModel.currentGenre,
                      style: AppStyles.regular20White,
                    ),
                    InkWell(
                        onTap: () {
                          ///to do will navigate to screen of all category
                        },
                        child: Text(
                          "See More→",
                          style: AppStyles.regular16PrimaryRoboto,
                        ))
                  ],
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                SizedBox(
                  height: height * 0.25,
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.pushNamed(context,AppRoutes.movieDetailsScreenRouteName,arguments: state.categoriesList![index].id);
                        },
                        child: FilmCard(
                          isCategory: true,
                          image: state.categoriesList![index].mediumCoverImage!,
                          rating: state.categoriesList![index].rating,
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        width: width * 0.03,
                      );
                    },
                    itemCount: state.categoriesList!.length,
                    scrollDirection: Axis.horizontal,
                  ),
                )
              ],
            );
          } else if (state is CategoriesFailure) {
            return SafeArea(
                child: Center(
              child: Text(
                state.errorMessage,
                style: AppStyles.regular20White,
              ),
            ));
          } else {
            return SafeArea(
                child: Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
              ),
            ));
          }
        });
  }
}
