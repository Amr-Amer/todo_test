import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_test/My_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../Providers/App_config_provider.dart';

class LangugeChickBox extends StatefulWidget {

  @override
  State<LangugeChickBox> createState() => _LangugeChickBoxState();
}

class _LangugeChickBoxState extends State<LangugeChickBox> {
  bool choseEnglish = false ;

  bool choseArabic= false ;

  @override
  Widget build(BuildContext context) {

    var provider = Provider.of<AppConfigProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding:  EdgeInsets.all(MediaQuery.sizeOf(context).height *.01),
          child: Text(AppLocalizations.of(context)!.language ,
            style: Theme.of(context).textTheme.titleMedium,),
        ),
        Container(
          margin: EdgeInsets.all(MediaQuery.sizeOf(context).height *.01),
          padding: EdgeInsets.all(MediaQuery.sizeOf(context).height *.01),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: MyTheme.witheColor,
            boxShadow: [BoxShadow(
              color: MyTheme.backgroundOwner,
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 3),)],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppLocalizations.of(context)!.english),
                  Checkbox(
                    value: choseEnglish,
                    onChanged: (bool ? newValue) {
                      choseEnglish = newValue!;
                      if (choseEnglish == true ){
                        provider.changeLanguge('en');
                        choseArabic = false;
                      }
                      setState(() {});
                    },),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppLocalizations.of(context)!.arabic),
                  Checkbox
                    (value: choseArabic,
                    onChanged: (bool ? newValue) {
                      choseArabic = newValue!;
                      if (choseArabic == true ){
                        provider.changeLanguge('ar');
                        choseEnglish = false;
                      }
                      setState(() {});
                    },),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
