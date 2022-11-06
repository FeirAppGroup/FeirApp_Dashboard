import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'constants/style.dart';
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
  @override
  void initState() {
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: splashPageRoute,
      //home: SiteLayout(),
      unknownRoute: GetPage(
        name: notfoundPageRoute,
        page: () => PageNotFound(),
        transition: Transition.fadeIn,
      ),
      getPages: Routes.routes,

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
