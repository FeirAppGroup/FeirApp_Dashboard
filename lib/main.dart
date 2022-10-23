import 'package:dashboard_feirapp/helpers/shared_pref.dart';
import 'package:dashboard_feirapp/pages/authentication/authentication.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants/style.dart';
import 'layout.dart';
import 'models/dtos/user_login_dto.dart';
import 'pages/404/error_page.dart';
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
  loadPref() async {
    SharedPreferences sharedUser = await SharedPreferences.getInstance();
    user = UserLoginDto.fromJson(sharedUser.getString('user') ?? "");
    token = user.token;
    print(token);

    setState(() {
      isLoading = false;
    });
  }

  late UserLoginDto user;
  String? token;
  bool isLoading = true;

  @override
  void initState() {
    loadPref();
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: isLoading
          ? notfoundPageRoute
          : token == null
              ? authenticationPageRoute
              : rootRoute,
      unknownRoute: GetPage(
        name: notfoundPageRoute,
        page: () => PageNotFound(),
        transition: Transition.fadeIn,
      ),
      getPages: [
        GetPage(name: rootRoute, page: () => SiteLayout()),
        GetPage(name: authenticationPageRoute, page: () => AuthenticationPage()),
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
