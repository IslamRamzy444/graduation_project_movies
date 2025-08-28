import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_movies/ui/auth/register/cubit/register_view_model.dart';
import 'package:graduation_project_movies/ui/auth/register/cubit/user_states.dart';
import 'package:graduation_project_movies/ui/widgets/custom_Elevated_button.dart';
import 'package:graduation_project_movies/ui/widgets/custom_text_form_field.dart';
import 'package:graduation_project_movies/utils/app_assets.dart';
import 'package:graduation_project_movies/utils/app_colors.dart';
import 'package:graduation_project_movies/utils/app_routes.dart';
import 'package:graduation_project_movies/utils/app_styles.dart';
import 'package:graduation_project_movies/utils/dialog_utils.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../../cubits/language_cubit/language_cubit.dart';
import '../../../l10n/app_localizations.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}
class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController=TextEditingController();

  TextEditingController emailController=TextEditingController();

  TextEditingController passwordController=TextEditingController();

  TextEditingController rePasswordController=TextEditingController();

  TextEditingController phoneController=TextEditingController();
  RegisterViewModel viewModel=RegisterViewModel();
  int avatarId=1;
  bool obscured1=true;
  bool obscured2=true;
  List<String> avatars=[
    AppAssets.avatar1,AppAssets.avatar2,AppAssets.avatar3,AppAssets.avatar4,AppAssets.avatar5,AppAssets.avatar6,AppAssets.avatar7,AppAssets.avatar8,AppAssets.avatar9
  ];
  @override
  Widget build(BuildContext context) {
    var languageCubit = context.read<LanguageCubit>();
    final locale = context.watch<LanguageCubit>().state;
    var width=MediaQuery.sizeOf(context).width;
    var height=MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.register,style: AppStyles.regular16PrimaryRoboto,),
      ),
      body: BlocListener<RegisterViewModel,UserStates>(
        bloc: viewModel,
        listener: (context, state) {
          if(state is UserLoadingState){
            DialogUtils.showLoading(context: context, loadingText: AppLocalizations.of(context)!.loading);
          }else if(state is UserSuccessState){
            DialogUtils.removeLoading(context: context);
            DialogUtils.showMessage(
              context: context, 
              message: state.successMessage,
              posActionName: AppLocalizations.of(context)!.ok,
              posAction: (){
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, AppRoutes.homeScreenRouteName);
              }
            );
          }else if(state is UserErrorState){
            DialogUtils.removeLoading(context: context);
            DialogUtils.showMessage(context: context, message: state.errorMessage,title: AppLocalizations.of(context)!.failure,negActionName: AppLocalizations.of(context)!.ok);
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 0.04*width),
            child: Column(
              children: [
                SizedBox(
                  height: 0.17*height,
                  child: CarouselSlider(
                    options: CarouselOptions(
                      height: 0.15*height,
                      enlargeCenterPage: true,
                      viewportFraction: 0.3
                    ),
                    items: avatars.map((avatar) {
                      return Builder(
                        builder: (BuildContext context) {
                          return InkWell(
                        onTap: () {
                          // selectedAvatar=avatar;
                          avatarId=avatars.indexOf(avatar)+1;
                        },
                        child: CircleAvatar(
                          radius: 0.09*width,
                          child: Image.asset(avatar),
                        ),
                      );
                        },
                      );
                    }).toList(),
                  ),
                ),
                Text(AppLocalizations.of(context)!.avatar,style: AppStyles.regular16WhiteRoboto,),
                SizedBox(height: 0.01*height,),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        controller: nameController,
                        validator: (text) {
                          if(text==null || text.trim().isEmpty){
                            return AppLocalizations.of(context)!.empty_name_error;
                          }
                          return null;
                        },
                        hintText: AppLocalizations.of(context)!.name,
                        prefixIcon: ImageIcon(AssetImage(AppAssets.userNameIcon,),color: AppColors.whiteColor,),
                      ),
                      SizedBox(height: 0.02*height,),
                      CustomTextField(
                        controller: emailController,
                        validator: (text) {
                          if(text==null || text.trim().isEmpty){
                            return AppLocalizations.of(context)!.empty_email_error;
                          }
                          final bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(text.trim());
                          if(!emailValid){
                            return AppLocalizations.of(context)!.invalid_email_error;
                          }
                          return null;
                        },
                        hintText: AppLocalizations.of(context)!.email,
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: ImageIcon(AssetImage(AppAssets.emailIcon),color: AppColors.whiteColor,),
                      ),
                      SizedBox(height: 0.02*height,),
                      CustomTextField(
                        controller: passwordController,
                        validator: (text) {
                          if(text==null || text.trim().isEmpty){
                            return AppLocalizations.of(context)!.empty_password_error;
                          }
                          if(text.trim().length<8){
                            return AppLocalizations.of(context)!.short_password_error;
                          }
                          return null;
                        },
                        hintText: AppLocalizations.of(context)!.password,
                        prefixIcon: ImageIcon(AssetImage(AppAssets.passwordIcon),color: AppColors.whiteColor,),
                        hintStyle: AppStyles.regular15WhiteRoboto,
                        obscureText: obscured1,
                        suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              obscured1=!obscured1;
                            });
                          },
                          child: obscured1?Icon(Icons.visibility_off,color: AppColors.whiteColor,):Icon(Icons.visibility,color: AppColors.whiteColor,),
                        ),
                      ),
                      SizedBox(height: 0.02*height,),
                      CustomTextField(
                        controller: rePasswordController,
                        validator: (text) {
                          if(text==null || text.trim().isEmpty){
                            return AppLocalizations.of(context)!.empty_re_password_error;
                          }
                          if(text.trim().length<8){
                            return AppLocalizations.of(context)!.short_password_error;
                          }
                          if(passwordController.text.trim()!=text.trim()){
                            return AppLocalizations.of(context)!.mis_match_re_password;
                          }
                          return null;
                        },
                        hintText: AppLocalizations.of(context)!.confirm_password,
                        prefixIcon: ImageIcon(AssetImage(AppAssets.passwordIcon),color: AppColors.whiteColor,),
                        hintStyle: AppStyles.regular15WhiteRoboto,
                        obscureText: obscured2,
                        suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              obscured2=!obscured2;
                            });
                          },
                          child: obscured2?Icon(Icons.visibility_off,color: AppColors.whiteColor,):Icon(Icons.visibility,color: AppColors.whiteColor,),
                        ),
                      ),
                      SizedBox(height: 0.02*height,),
                      CustomTextField(
                        controller: phoneController,
                        validator: (text) {
                          if(text==null || text.trim().isEmpty){
                            return AppLocalizations.of(context)!.empty_phone_error;
                          }
                          return null;
                        },
                        hintText: AppLocalizations.of(context)!.phone_number,
                        prefixIcon: ImageIcon(AssetImage(AppAssets.phoneIcon),color: AppColors.whiteColor,),
                      ),
                      SizedBox(height: 0.02*height,),
                      CustomElevatedButton(
                        buttonTextStyle: AppStyles.regular20BlackRoboto,
                        buttonText: AppLocalizations.of(context)!.create_account, 
                        onPressed: () {
                          register();
                        },
                      )
                    ],
                  )
                ),
                SizedBox(height: 0.02*height,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(AppLocalizations.of(context)!.already_have_account,style: AppStyles.regular14WhiteRoboto,),
                    InkWell(
                      onTap: (){
                        login();
                      },
                      child: Text(AppLocalizations.of(context)!.login,style: AppStyles.regular14PrimaryRoboto,)
                    )
                  ],
                ),
                SizedBox(height: 0.02*height,),
                ToggleSwitch(
                    initialLabelIndex:locale.languageCode == 'en' ? 0 : 1,
                    totalSwitches: 2,
                    dividerColor: AppColors.transparentColor,
                    activeFgColor: AppColors.whiteColor,
                    inactiveBgColor: AppColors.transparentColor,
                    activeBgColors: [
                      [AppColors.primaryColor],[AppColors.primaryColor]
                    ],
                    borderColor: [AppColors.primaryColor],
                    borderWidth: 2,
                    minWidth: 60,
                    minHeight: 30,
                    radiusStyle:true ,
                    cornerRadius: 30,
                    customWidgets: [
                      Image.asset(AppAssets.usaFlagIcon,width: 24, height: 24),
                      Image.asset(AppAssets.egFlagIcon,width: 24, height: 24),
                    ],
                    onToggle: (index) {
                      if(index==0){
                        languageCubit.changeLanguage(Locale('en'));
                      }else{
                        languageCubit.changeLanguage(Locale('ar'));
                      }
                    },
                  )
              ],
            ),
          )
        ),
      ),
    );
  }
  void login(){
    Navigator.pushNamed(context, AppRoutes.loginScreenRouteName);
  }
  void register(){
    if(_formKey.currentState!.validate()==true){
      viewModel.registerWithApi(
        nameController.text, 
        emailController.text, 
        passwordController.text, 
        rePasswordController.text, 
        phoneController.text, 
        avatarId
      );
    }
  }
}
