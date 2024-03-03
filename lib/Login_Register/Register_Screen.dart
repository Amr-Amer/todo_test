import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:todo_test/Home/Home_Screen.dart';
import 'package:todo_test/Login_Register/Dialog_Utils.dart';
import 'package:todo_test/Login_Register/Login_Screen.dart';
import 'package:todo_test/Login_Register/custom_text_form_field.dart';
import 'package:todo_test/Model/user.dart';
import 'package:todo_test/My_theme.dart';
import 'package:todo_test/Providers/Auth_provider.dart';
import 'package:todo_test/firebase_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterScreen extends StatefulWidget {

  static const String routeName = 'register_screen' ;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var formKey = GlobalKey<FormState>();

  TextEditingController userNameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTheme.backgroundLight,
      body: Stack(
        children: [
          Image.asset('assets/images/shape.png'),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.1,),
                Center(
                  child: Text(AppLocalizations.of(context)!.welcome_back,
                    style: Theme
                        .of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: MyTheme.blackColor),),
                ),
                SizedBox(height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.02,),
                Center(
                  child: Text(AppLocalizations.of(context)!.lets_help_you_meet_your_tasks,
                    style: Theme
                        .of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(color: MyTheme.lableColor),),
                ),
                SizedBox(height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.1,),

                Form(
                    key: formKey,
                    child: Column(
                      children: [
                        CustomTextFormField(
                          text: AppLocalizations.of(context)!.enter_user_name,
                          controller: userNameController,
                          validetor: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return AppLocalizations.of(context)!.please_enter_user_name;
                            }
                            return null;
                          },),
                        CustomTextFormField(
                          text: AppLocalizations.of(context)!.email,
                          controller: emailController,
                          validetor: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return AppLocalizations.of(context)!.please_enter_email;
                            }
                            bool emailValid =
                            RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(emailController.text);
                            if (!emailValid) {
                              return AppLocalizations.of(context)!.this_email_is_not_valid;
                            }
                            return null;
                          },),
                        // SizedBox(height: MediaQuery.of(context).size.height *0.02,),

                        // SizedBox(height: MediaQuery.of(context).size.height *0.02,),
                        CustomTextFormField(
                          text: AppLocalizations.of(context)!.enter_password,
                          controller: passwordController,
                          obscureText: true,
                          validetor: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return AppLocalizations.of(context)!.please_enter_password;
                            }
                            return null;
                          },),
                        // SizedBox(height: MediaQuery.of(context).size.height *0.02,),
                        CustomTextFormField(
                          text: AppLocalizations.of(context)!.confirm_password,
                          controller: confirmPasswordController,
                          obscureText: true,
                          validetor: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return AppLocalizations.of(context)!.please_enter_confirm_password;
                            }
                            return null;
                          },),
                      ],
                    )),

                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                            MyTheme.backgroundOwner),),
                      onPressed: () {
                        register();
                      },
                      child: Text(AppLocalizations.of(context)!.register)),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                            MyTheme.backgroundOwner),),
                      onPressed: () {
                        signInWithGoogle();
                      },
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(AppLocalizations.of(context)!.sign_in_with_google,),
                      const SizedBox(width: 10,),
                      Image.asset('assets/images/google.png' , width: 22,)
                    ],
                  )),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(AppLocalizations.of(context)!.already_have_an_account,
                      style: Theme
                          .of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(color: MyTheme.brownColor),),
                    GestureDetector(
                      onTap: (){
                        Navigator.pushReplacementNamed(context, LoginScreen.routeName);
                      },
                      child: Text(AppLocalizations.of(context)!.sign_in,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(color: MyTheme.brownColor),),
                    ),
                  ],
                ) ,


                // Padding(
                //   padding: const EdgeInsets.all(10.0),
                //   child: ElevatedButton(onPressed: () {
                //     signInWithGoogle();
                //   },
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           Text(AppLocalizations.of(context)!.sign_in_with_google,
                //             style: Theme.of(context).textTheme.titleLarge,),
                //           const SizedBox(width: 10,),
                //           Image.asset('assets/images/iconGoogle.png' , width: 30,)
                //         ],
                //       )),
                // ),

              ],
            ),
          )
        ],
      ),
    );
  }

  void register() async {
    if (formKey.currentState?.validate() == true) {
      try {

        DialogUtils.showLoading(context);
        final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        MyUser myUser = MyUser(
            uId: credential.user?.uid,
            name: userNameController.text,
            email: emailController.text);

        var authProvider = Provider.of<AuthProviders>(context , listen: false);

        authProvider.updateUser(myUser);

        await FirebaseUtils.addUserToFireStore(myUser);

        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(context: context, content:AppLocalizations.of(context)!.register_successfully,
            postActionName: AppLocalizations.of(context)!.accept,
            postAction: (){Navigator.pushReplacementNamed(context, HomeScreen.routeName);});
        print('register successfully');
      }
      on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(context: context,
              content: AppLocalizations.of(context)!.the_password_provided_is_too_weak ,
              postActionName: AppLocalizations.of(context)!.ok);
          print('The password provided is too weak.');
        }
        else if (e.code == 'email-already-in-use') {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(context: context,
              content: AppLocalizations.of(context)!.the_account_already_exists_for_that_email,
              postActionName: AppLocalizations.of(context)!.ok);
          print('The account already exists for that email.');
        }
      }
      catch (e) {
        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(context: context, content: '${e}',
            postActionName:AppLocalizations.of(context)!.ok );
        print(e);
      }
    }
  }

  Future<void> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) {
      return;
    }

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential);

    Navigator.of(context).pushReplacementNamed(HomeScreen.routeName) ;

  }

}