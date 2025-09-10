import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_movies/models/movies_list_repsonse.dart';
import 'package:graduation_project_movies/ui/home/home_screen/film_card.dart';
//import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:graduation_project_movies/ui/home/profile_screen/cubit/profile_states.dart';
import 'package:graduation_project_movies/ui/home/profile_screen/cubit/profile_view_model.dart';
import 'package:graduation_project_movies/l10n/app_localizations.dart';
import 'package:graduation_project_movies/ui/home/profile_screen/history_manager/history_manager.dart';
//import 'package:graduation_project_movies/models/dummy_class.dart';
import 'package:graduation_project_movies/ui/home/profile_screen/profile_screen_tab.dart';
import 'package:graduation_project_movies/ui/widgets/custom_Elevated_button.dart';
import 'package:graduation_project_movies/utils/app_assets.dart';
import 'package:graduation_project_movies/utils/app_colors.dart';
import 'package:graduation_project_movies/utils/app_routes.dart';

import '../../../utils/app_styles.dart';
import '../../updateProfile/update_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  String? token;
  ProfileScreen({super.key, this.token});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool watchHistory = true;

  //this class will be filled with the history and watch list then from the api
  List<DummyClass> movieList = [];
  List<Movies> historyList = [];
  ProfileViewModel viewModel = ProfileViewModel();
  void _loadHistory(){
    setState(() {
      historyList=HistoryManager.getMovies();
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.getProfile(widget.token!);
    _loadHistory();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<ProfileViewModel, ProfileStates>(
          bloc: viewModel,
          builder: (context, state) {
            if (state is ProfileLoadingState) {
              return Center(
                child: CircularProgressIndicator(
                  color: AppColors.primaryColor,
                ),
              );
            } else if (state is ProfileFetchingState){
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                    color: AppColors.darkGreyColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //this will change to network image to load the image that the user used it when creating the account
                            Image.asset(
                              "assets/images/avatar_${state.userProfile.avaterId}.png",
                              scale: 0.8,
                            ),
                            Column(
                              children: [
                                Text(
                                  "12",
                                  style: AppStyles.bold36White,
                                ),
                                Text(
                                  AppLocalizations.of(context)!.wish_list,
                                  style: AppStyles.bold24White,
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Text("12", style: AppStyles.bold36White),
                                Text(
                                  AppLocalizations.of(context)!.history,
                                  style: AppStyles.bold24White,
                                )
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        //here we will add the name of the user
                        Text(
                          state.userProfile.name!,
                          style: AppStyles.bold20White,
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomElevatedButton(
                              buttonText: AppLocalizations.of(context)!.edit_profile,
                              onPressed: () async {
                                // Navigate to update profile screen with ProfileViewModel instance
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UpdateProfileScreen(
                                      userData: state.userProfile,
                                      token: widget.token!,
                                      profileViewModel: viewModel, // Pass the viewModel instance
                                    ),
                                  ),
                                );
                                // No need for manual refresh here since UpdateProfileScreen handles it
                              },
                              size: Size(width * 0.64, height * 0.07),
                            ),
                            CustomElevatedButton(
                              buttonText: AppLocalizations.of(context)!.exit,
                              buttonTextStyle: AppStyles.regular20White,
                              onPressed: () {
                                Navigator.pushReplacementNamed(context, AppRoutes.loginScreenRouteName);
                              },
                              size: Size(width * 0.26, height * 0.07),
                              buttonColor: AppColors.redColor,
                              borderColor: AppColors.redColor,
                              suffixIcon: ImageIcon(
                                  AssetImage(AppAssets.exitIcon),
                                  color: AppColors.whiteColor),
                            )
                          ],
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ProfileScreenTab(
                              icon: AppAssets.watchListIcon,
                              onTap: () {
                                watchHistory = !watchHistory;
                                setState(() {});
                              },
                              text: AppLocalizations.of(context)!.watch_list,
                              isSelected: watchHistory,
                            ),
                            ProfileScreenTab(
                              icon: AppAssets.historyIcon,
                              onTap: () {
                                watchHistory = !watchHistory;
                                setState(() {});
                              },
                              text: AppLocalizations.of(context)!.history,
                              isSelected: !watchHistory,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: watchHistory?
                    _buildWatchList():
                    _buildHistoryList()
                  )
                ],
              );
            }
            return Container(color: AppColors.primaryColor,);
          },
        ),
      ),
    );
  }
  Widget _buildHistoryList(){
    if(historyList.isEmpty){
      return Center(child: Image.asset(AppAssets.emptyIcon),);
    }else{
      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 12,
          childAspectRatio: 0.7,
        ), 
        itemBuilder: (context, index) {
          final movie=historyList[index];
          return FilmCard(
            image: movie.mediumCoverImage??'', 
            rating: movie.rating
          );
        },
        itemCount: historyList.length,
      );
    }
  }
  Widget _buildWatchList(){
    return Center(child: Image.asset(AppAssets.emptyIcon));
  }
}

class DummyClass {}

