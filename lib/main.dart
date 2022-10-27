import 'package:after_layout/after_layout.dart';
import 'package:dashboard_feirapp/helpers/shared_pref.dart';
import 'package:dashboard_feirapp/pages/404/circular.dart';
import 'package:dashboard_feirapp/pages/authentication/authentication.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:after_layout/after_layout.dart';

import 'constants/style.dart';
import 'layout.dart';
import 'models/dtos/user_login_dto.dart';
import 'pages/404/error_page.dart';
import 'pages/splash/splashpage.dart';
import 'routing/routes.dart';
import 'helpers/dependences.dart' as dep;

// SharedPref sharedPref = SharedPref();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      //initialRoute: splashPageRoute,
      home: SiteLayout(),
      unknownRoute: GetPage(
        name: notfoundPageRoute,
        page: () => PageNotFound(),
        transition: Transition.fadeIn,
      ),
      getPages: [
        GetPage(name: rootRoute, page: () => SiteLayout()),
        GetPage(name: authenticationPageRoute, page: () => AuthenticationPage()),
        GetPage(name: splashPageRoute, page: () => SplashPage()),
      ],
      debugShowCheckedModeBanner: false,
      title: 'FeirApp Dashboard',
      theme: ThemeData(
        scaffoldBackgroundColor: bgBlackMain,
        pageTransitionsTheme: const PageTransitionsTheme(builders: {
          TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
        }),
        primaryColor: Colors.blue,
      ),
    );
  }
}
