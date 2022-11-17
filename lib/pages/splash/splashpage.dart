import 'dart:async';

import 'package:dashboard_feirapp/helpers/shared_pref.dart';
import 'package:dashboard_feirapp/models/model/user_model.dart';
import 'package:dashboard_feirapp/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controllers/model_controller/user_controller.dart';
import '../../models/dtos/user_login_dto.dart';
import '../../routing/routes.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashPage> with TickerProviderStateMixin {
  late Animation<double> animation;

  late AnimationController controller;

  int diff = 0;
  loadPref() async {
    SharedPreferences sharedUser = await SharedPreferences.getInstance();
    print(sharedUser.getString('user'));

    var existTime = await sharedUser.getInt('expireTime');

    if (existTime != null) {
      int? oldTime = await sharedUser.getInt('expireTime');
      diff = DateTime.now().millisecondsSinceEpoch - oldTime!;
    }

    if (diff > 3600000) {
      await sharedUser.clear();
      Get.toNamed(
        authenticationPageRoute,
      );
    }

    if (sharedUser.getString('user') != null) {
      user = UserLoginDto.fromJson(sharedUser.getString('user') ?? "");
      token = user!.token;
      print(token);
    }

    // SharedPref.readTimeout();
    // var diff = 0;
    // SharedPref.getIntByKey('diff', diff);

    // if (diff > 3600000) {
    //   SharedPref.clearPreferences();
    //   Get.toNamed(
    //     authenticationPageRoute,
    //   );
    // }

    // SharedPref.read('user', user);

    // if (user != null) {
    //   SharedPref.read('user', user);
    //   token = user!.token;
    //   print(token);
    // }

    setState(() {
      isLoading = false;
    });
  }

  var userController = Get.find<UserController>();

  UserLoginDto? user;
  String? token;
  bool isLoading = true;

  @override
  void initState() {
    loadPref();
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..forward();
    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.decelerate,
    );

    Timer(const Duration(seconds: 5), () {
      if (token == null) {
        Get.toNamed(
          authenticationPageRoute,
        );
      } else {
        Get.toNamed(rootRoute);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
            scale: animation,
            child: Center(
              child: Image.asset(
                'assets/images/logo.png',
                width: Dimensions.width350,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
