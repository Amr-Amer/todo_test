import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DialogUtils {

  static void showLoading(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return  AlertDialog(
          content: Row(
            children: [
              const CircularProgressIndicator(color: Colors.brown,),
              const SizedBox(width: 20,),
              Text(AppLocalizations.of(context)!.loading)
            ],
          ),
        );
      },);
  }

  static void hideLoading(BuildContext context) {
    Navigator.pop(context);
  }

  static void showMessage({
    required BuildContext context,
    required String content,
    // String title = '',
    Function? postAction,
    String? postActionName,
    String? negActionName}) {
    List<Widget> actionList = [];
    if (postActionName != null) {
      actionList.add(TextButton(
          onPressed: () {
            Navigator.pop(context);
            if (postAction != null) {
              postAction.call();
            }
          },
          child: Text(postActionName)));

      if (negActionName != null) {
        actionList.add(TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(negActionName)));
      }
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0),),),
            // title: Text(title),
            content: Text(content,),
            actions: actionList,);
        },);
    }
  }
}