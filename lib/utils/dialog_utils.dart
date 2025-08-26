import 'package:flutter/material.dart';
import 'package:graduation_project_movies/utils/app_colors.dart';
import 'package:graduation_project_movies/utils/app_styles.dart';

class DialogUtils {
  static void showLoading({required BuildContext context,required String loadingText}){
    showDialog(
      context: context,
      barrierDismissible: false, 
      builder: (context) => AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(color: AppColors.primaryColor,),
            Text(loadingText,style: AppStyles.regular16PrimaryRoboto,)
          ],
        ),
      ),
    );
  }
  static void removeLoading({required BuildContext context}){
    Navigator.pop(context);
  }
  static void showMessage({required BuildContext context,String? title,required String message,String? posActionName,Function? posAction,String? negActionName,Function? negAction}){
    List<Widget>? actions=[];
    if(posActionName!=null){
      actions.add(TextButton(
        onPressed: () {
          Navigator.pop(context);
          posAction?.call();
        }, 
        child: Text(posActionName,style: AppStyles.regular16DarkGreyRoboto,)
      )
      );
    }
    if(negActionName!=null){
      actions.add(TextButton(
        onPressed: () {
          Navigator.pop(context);
          negAction?.call();
        }, 
        child: Text(negActionName,style: AppStyles.regular16DarkGreyRoboto,)
      )
      );
    }
    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        title: Text(title?? '',style: AppStyles.regular20BlackRoboto,),
        content: Text(message,style: AppStyles.regular16DarkGreyRoboto,),
        actions: actions,
      ),
    );
  }
}