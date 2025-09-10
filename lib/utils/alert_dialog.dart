import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_styles.dart';

class DialogUtils {
  static void showLoading({
    required BuildContext context,
    required String loadingText,
  }) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(color: AppColors.primaryColor),
            Expanded(
              child: Text(
                  overflow: TextOverflow.ellipsis,
                  loadingText,
                  style: AppStyles.semiBold20Primary),
            ),
          ],
        ),
      ),
    );
  }

  static void hideLoading({required BuildContext context}) {
    Navigator.pop(context);
  }

  static void showMessage({
    required BuildContext context,
    required String message,
    String? title,
    String? postActionName,
    Function? posAction,
    String? negActionName,
    Function? negAction,
    bool barrierDismissible = true,
  }) {
    List<Widget> actions = [];
    if (postActionName != null) {
      actions.add(
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            // if(posAction != null ){
            //   posAction.call();
            // }
            posAction?.call();
          },
          child: Text(postActionName, style: AppStyles.semiBold20Primary),
        ),
      );
    }
    if (negActionName != null) {
      actions.add(
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            // if(posAction != null ){
            //   posAction.call();
            // }
            negAction?.call();
          },
          child: Text(negActionName, style: AppStyles.semiBold20Primary),
        ),
      );
    }
    showDialog(
      barrierDismissible: barrierDismissible,
      context: context,
      builder: (context) => AlertDialog(
        actions: actions,
        title: Text(title ?? '', style: AppStyles.semiBold20Primary),
        content: Text(message, style: AppStyles.semiBold20Primary),
      ),
    );
  }
}
