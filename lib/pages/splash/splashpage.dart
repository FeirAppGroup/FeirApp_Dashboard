import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  //TODO AJustar timeout
  loadPref() async {
    SharedPreferences sharedUser = await SharedPreferences.getInstance();
    print(sharedUser.getString('user'));
    if (sharedUser.getString('user') != null) {
      user = UserLoginDto.fromJson(sharedUser.getString('user') ?? "");
      token = user!.token;
      print(token);
    }

    setState(() {
      isLoading = false;
    });
  }

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
                width: 150,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
