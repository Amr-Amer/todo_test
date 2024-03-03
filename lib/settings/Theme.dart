import 'package:flutter/material.dart';
import 'package:todo_test/My_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ThemeCheckBox extends StatefulWidget {

  @override
  State<ThemeCheckBox> createState() => _ThemeCheckBoxState();
}

class _ThemeCheckBoxState extends State<ThemeCheckBox> {
  bool choseLight = false ;

  bool choseDark = false ;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(AppLocalizations.of(context)!.theme ,
            style: Theme.of(context).textTheme.titleMedium,),
        ),
        Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: MyTheme.witheColor,
            boxShadow: [BoxShadow(
              color: MyTheme.backgroundOwner,
              spreadRadius: 1,
              blurRadius: 4,
              offset: Offset(0, 3),)],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppLocalizations.of(context)!.light),
                  Checkbox
                    (value: choseLight,
                    onChanged: (bool ? newValue) {
                      choseLight = newValue!;
                      setState(() {});
                    },),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppLocalizations.of(context)!.dark),
                  Checkbox
                    (value: choseDark,
                    onChanged: (bool ? newValue) {
                      choseDark = newValue!;
                      setState(() {});
                    },),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
