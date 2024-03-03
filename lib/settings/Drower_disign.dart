import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_test/Login_Register/Login_Screen.dart';
import 'package:todo_test/My_theme.dart';
import 'package:todo_test/Providers/Auth_provider.dart';
import 'package:todo_test/settings/Languge.dart';
import 'package:todo_test/settings/Theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DrowerTab extends StatefulWidget {

  @override
  State<DrowerTab> createState() => _DrowerTabState();
}

class _DrowerTabState extends State<DrowerTab> {

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProviders>(context);
    return Container(
      color: MyTheme.backgroundLight,
      child: ListView(
        children: [
          Column(
            children: [
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
                    offset: Offset(0, 3),)
                  ],
                ),
                child: Text('Hello ${authProvider.curentUser!.name ?? ''}',
                    style: Theme
                        .of(context)
                        .textTheme
                        .titleLarge),
              ),
              LangugeChickBox(),
              ThemeCheckBox(),
              SizedBox(height: MediaQuery
                  .sizeOf(context)
                  .height * 0.04,),
              InkWell(
                onTap: () {
                  Navigator.pushReplacementNamed(
                      context, LoginScreen.routeName);
                },
                child: Container(
                    margin: EdgeInsets.all(MediaQuery.sizeOf(context).height *.01),
                    padding: EdgeInsets.all(MediaQuery.sizeOf(context).height *.01),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: MyTheme.witheColor,
                      boxShadow: [BoxShadow(
                        color: MyTheme.backgroundOwner,
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: const Offset(0, 3),)
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.logout_outlined,),
                        const SizedBox(width: 10,),
                        Text(AppLocalizations.of(context)!.logout),

                      ],
                    )
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
