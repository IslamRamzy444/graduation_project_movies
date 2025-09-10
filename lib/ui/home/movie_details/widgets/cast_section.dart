import 'package:flutter/material.dart';
import 'package:graduation_project_movies/models/movie_details_response.dart';
import 'package:graduation_project_movies/utils/app_colors.dart';
import 'package:graduation_project_movies/utils/app_styles.dart';

class CastSection extends StatelessWidget {
  final List<Cast> castList;

  const CastSection({super.key, required this.castList});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    if (castList.isEmpty) {
      return const SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Cast",
          style: AppStyles.bold20White,
        ),
        SizedBox(height: height * 0.03),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: castList.length,
          itemBuilder: (context, index) {
            final cast = castList[index];
            return Card(
              color: AppColors.darkGreyColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              margin: EdgeInsets.symmetric(vertical: 0.01 * height),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        cast.urlSmallImage ?? "",
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            "assets/images/no_image.png",
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                    SizedBox(width: width * 0.03),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            overflow: TextOverflow.ellipsis,
                            "Name : ${cast.name ?? 'Unknown'}",
                            style: AppStyles.regular18WhiteRoboto,
                          ),
                          SizedBox(height: height * 0.01),
                          Text(
                            overflow: TextOverflow.ellipsis,
                            "Character : ${cast.characterName} ?? '' ",
                            style: AppStyles.regular18WhiteRoboto,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
