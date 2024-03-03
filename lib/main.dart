import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_test/Home/Home_Screen.dart';
import 'package:todo_test/Login_Register/Login_Screen.dart';
import 'package:todo_test/Login_Register/Register_Screen.dart';
import 'package:todo_test/My_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_test/Providers/App_config_provider.dart';
import 'package:todo_test/Providers/Auth_provider.dart';
import 'Providers/List_provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // await FirebaseFirestore.instance.disableNetwork();
  // FirebaseFirestore.instance.settings =
  //     const Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);

  // FirebaseFirestore.instance.clearPersistence();

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AppConfigProvider(),),
        ChangeNotifierProvider(create:
            (context) => ListProvider(),),
        ChangeNotifierProvider(create:
            (context) => AuthProviders(),),
      ],
          child: MyApp(),));
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    var provider = Provider.of<AppConfigProvider>(context);

    return MaterialApp(
      locale: Locale(provider.appLanguge),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      theme: MyTheme.lightTheme,
      initialRoute: LoginScreen.routeName,
      routes: {
        LoginScreen.routeName:(context) => LoginScreen(),
        RegisterScreen.routeName:(context) => RegisterScreen(),
        HomeScreen.routeName:(context) => HomeScreen(),} ,
    );
    }
}
