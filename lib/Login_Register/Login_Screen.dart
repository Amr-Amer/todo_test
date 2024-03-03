import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_test/Home/Home_Screen.dart';
import 'package:todo_test/Login_Register/Dialog_Utils.dart';
import 'package:todo_test/Login_Register/Register_Screen.dart';
import 'package:todo_test/Login_Register/custom_text_form_field.dart';
import 'package:todo_test/My_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_test/Providers/Auth_provider.dart';
import 'package:todo_test/firebase_utils.dart';

class LoginScreen extends StatefulWidget {

  static const String routeName = 'login_screen' ;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTheme.backgroundLight,
      body: Stack(
        children: [
          Image.asset('assets/images/shape.png'),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height *0.08,),
              Center(
                child: Text(AppLocalizations.of(context)!.welcome_back,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(color: MyTheme.blackColor),),
              ),
              SizedBox(height: MediaQuery.of(context).size.height *0.02,),
              Center(
                child: Text(AppLocalizations.of(context)!.lets_help_you_meet_your_tasks,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(color: MyTheme.lableColor),),
              ),
              Image.asset('assets/images/person.png',
                  width: MediaQuery.of(context).size.height *0.4,
                  height: MediaQuery.of(context).size.width *0.6),

              Form(
                  key: formKey,
                  child: Column(
                    children: [
                      CustomTextFormField(
                        text: AppLocalizations.of(context)!.enter_user_name,
                        controller: emailController,
                        validetor: (text) {
                          if(text == null || text.trim().isEmpty){
                            return AppLocalizations.of(context)!.please_enter_user_name ;
                          }
                          return null;
                        },),
                      SizedBox(height: MediaQuery.of(context).size.height *0.02,),
                      CustomTextFormField(
                        text: AppLocalizations.of(context)!.enter_password,
                        controller: passwordController,
                        obscureText: true,
                        validetor: (text) {
                          if(text == null || text.trim().isEmpty){
                            return AppLocalizations.of(context)!.please_enter_password ;
                          }
                          return null;
                        },),
                    ],
                  )),

              InkWell(
                onTap: (){},
                child: Text(AppLocalizations.of(context)!.forget_password ,
                   style: Theme.of(context).textTheme.titleMedium?.copyWith(color: MyTheme.brownColor),
                   textAlign: TextAlign.center,),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                    onPressed: () {
                    login();
                    },
                    child: Text(AppLocalizations.of(context)!.login)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Text(AppLocalizations.of(context)!.dont_have_an_account ,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(color: MyTheme.brownColor),),
                  InkWell(
                    onTap: (){
                      Navigator.pushNamed(context, RegisterScreen.routeName);
                    },
                    child: Text(AppLocalizations.of(context)!.logout,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(color: MyTheme.brownColor),),
                  ),
                ],
              )

            ],
          )
        ],
      ),
    );
  }

  void login () async{
    if (formKey.currentState?.validate() == true) {
      try {
        DialogUtils.showLoading(context);
        final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text
        );
        var user = await FirebaseUtils.readUserFromFireStore(credential.user!.uid);
        if (user == null ){
          return;
        }

        var authProvider = Provider.of<AuthProviders>(context , listen: false);

        authProvider.updateUser(user);

        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(context: context, content:AppLocalizations.of(context)!.login_successfully,
            postActionName: AppLocalizations.of(context)!.ok,
            postAction: (){Navigator.pushReplacementNamed(context, HomeScreen.routeName);});
        print('login successfully');
      }
      on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(context: context,
            content:AppLocalizations.of(context)!.no_user_found_for_that_email,
              postActionName: AppLocalizations.of(context)!.ok,);
          print('No user found for that email.');
        }

        else if (e.code == 'wrong-password')
          DialogUtils.hideLoading(context);
        DialogUtils.showMessage(context: context,
          content:AppLocalizations.of(context)!.wrong_password_provided_for_that_user,
          postActionName: AppLocalizations.of(context)!.ok,);
          print('Wrong password provided for that user.');
        }
      }
    }
  }
