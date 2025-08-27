import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_movies/models/dummy_class.dart';
import 'package:graduation_project_movies/ui/home/home_screen/film_card.dart';
import 'package:graduation_project_movies/utils/app_assets.dart';
import 'package:graduation_project_movies/utils/app_styles.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  //this is dummy data to test with it the carousel slider
  List<DummyClass> dummyList = [
    DummyClass(imagePath: AppAssets.movieImage, rating: "7.8"),
    DummyClass(imagePath: AppAssets.movieImage, rating: "7.8"),
    DummyClass(imagePath: AppAssets.movieImage, rating: "7.8"),
    DummyClass(imagePath: AppAssets.movieImage, rating: "7.8"),
    DummyClass(imagePath: AppAssets.movieImage, rating: "7.8"),
    DummyClass(imagePath: AppAssets.movieImage, rating: "7.8"),
    DummyClass(imagePath: AppAssets.movieImage, rating: "7.8"),
    DummyClass(imagePath: AppAssets.movieImage, rating: "7.8"),
    DummyClass(imagePath: AppAssets.movieImage, rating: "7.8"),
    DummyClass(imagePath: AppAssets.movieImage, rating: "7.8")
  ];

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: width,
                height: height * 0.68,
                decoration: BoxDecoration(
                  //color: Colors.red,
                  image: DecorationImage(
                    //this is the big backgrrond image by default it change with the image of the slider we stop on it
                    image: AssetImage(AppAssets.movieImage),
                    fit: BoxFit.fill,
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.5),
                      BlendMode.dstOut,
                    ),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(AppAssets.availableNowImage),
                    CarouselSlider(
                      options: CarouselOptions(
                          height: 400.0,
                          enlargeCenterPage: true,
                          viewportFraction: 0.6),
                      //her i used the list of dummy data we will use the api to get the data
                      //and acsess the image of the movie and the rating of it
                      items: dummyList.map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            //this card i created it to show the image of the film and the rating of it
                            return FilmCard(
                              image: i.imagePath,
                              rating: i.rating,
                            );
                          },
                        );
                      }).toList(),
                    ),
                    Image.asset(AppAssets.watchNowImage),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                child: Column(
                  children: [
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Category",
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
                          return FilmCard(
                            image: dummyList[index].imagePath,
                            rating: dummyList[index].rating,
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            width: width * 0.03,
                          );
                        },
                        itemCount: dummyList.length,
                        scrollDirection: Axis.horizontal,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
