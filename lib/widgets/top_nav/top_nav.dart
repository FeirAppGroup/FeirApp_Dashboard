// ignore_for_file: prefer_const_constructors

import 'package:dashboard_feirapp/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/style.dart';
import '../../helpers/responsiveness.dart';
import '../Text/custom_text.dart';

AppBar topNavigationBar(BuildContext context, GlobalKey<ScaffoldState> key) {
  return AppBar(
    leading: !ResponsiveWidget.isSmallScreen(context)
        ? Row(
            children: [
              Container(
                padding: EdgeInsets.only(left: 14),
                child: Image.asset(
                  'assets/icons/logo.png',
                  width: 28,
                ),
              ),
            ],
          )
        : IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              key.currentState?.openDrawer();
            },
          ),
    elevation: 0,
    title: Row(
      children: [
        Visibility(
          child: CustomText(
            text: 'Dash',
            color: textWhite,
            size: 20,
            weight: FontWeight.bold,
          ),
        ),
        Expanded(
          child: Container(),
        ),
        IconButton(
          icon: Icon(
            Icons.settings,
            color: mainWhite,
          ),
          onPressed: () {},
        ),
        Stack(
          children: [
            IconButton(
              icon: Icon(
                Icons.notifications,
                color: mainWhite,
              ),
              onPressed: () {},
            ),
            Positioned(
              top: 7,
              right: 7,
              child: Container(
                width: 12,
                height: 12,
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: active,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.black, width: 2),
                ),
              ),
            ),
          ],
        ),
        Container(
          width: 1,
          height: 22,
          color: mainWhite,
        ),
        SizedBox(
          width: 24,
        ),
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Container(
            padding: EdgeInsets.all(2),
            margin: EdgeInsets.all(2),
            child: CircleAvatar(
              backgroundColor: mainWhite,
              child: Icon(
                Icons.person_outline,
                color: dark,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () async {
            SharedPreferences preferences = await SharedPreferences.getInstance();
            await preferences.clear();
            Get.toNamed(authenticationPageRoute);
          },
          child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Container(
              padding: EdgeInsets.all(2),
              margin: EdgeInsets.all(2),
              child: CircleAvatar(
                backgroundColor: mainWhite,
                child: Icon(
                  Icons.clear,
                  color: dark,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
    iconTheme: IconThemeData(color: dark),
    backgroundColor: Colors.transparent,
  );
}
