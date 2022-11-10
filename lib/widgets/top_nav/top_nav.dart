// ignore_for_file: prefer_const_constructors

import 'package:dashboard_feirapp/routing/routes.dart';
import 'package:dashboard_feirapp/utils/dimensions.dart';
import 'package:dashboard_feirapp/widgets/Button/icon_button_widget.dart';
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
                padding: EdgeInsets.only(left: Dimensions.width20),
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
            size: Dimensions.font20,
            weight: FontWeight.bold,
          ),
        ),
        Expanded(
          child: Container(),
        ),
        IconButtonWidget(
          width: Dimensions.width30,
          height: Dimensions.height40,
          backgroundColor: Colors.transparent,
          onTap: () {},
          icon: Icons.settings,
          iconColor: mainWhite,
        ),
        Stack(
          children: [
            IconButtonWidget(
              width: Dimensions.width30,
              height: Dimensions.height40,
              backgroundColor: Colors.transparent,
              onTap: () {},
              icon: Icons.notifications,
              iconColor: mainWhite,
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
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
                  border: Border.all(color: Colors.black, width: 2),
                ),
              ),
            ),
          ],
        ),
        Container(
          width: 2,
          height: Dimensions.height30,
          color: mainWhite,
        ),
        _space12,
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: mainStroke,
            borderRadius: BorderRadius.circular(Dimensions.radius30),
          ),
          child: Container(
            padding: EdgeInsets.all(2),
            margin: EdgeInsets.all(2),
            child: CircleAvatar(
              backgroundColor: mainWhite,
              child: Icon(
                Icons.person_outline,
                color: mainBlack,
              ),
            ),
          ),
        ),
        _space12,
        GestureDetector(
          onTap: () async {
            SharedPreferences preferences = await SharedPreferences.getInstance();
            await preferences.clear();
            Get.toNamed(authenticationPageRoute);
          },
          child: SizedBox(
            height: 40,
            width: 40,
            child: Container(
              padding: EdgeInsets.all(2),
              margin: EdgeInsets.all(2),
              child: CircleAvatar(
                backgroundColor: mainWhite,
                child: Icon(
                  Icons.clear,
                  color: mainBlack,
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

final _space12 = SizedBox(
  width: Dimensions.width12,
);

final _space24 = SizedBox(
  width: Dimensions.width24,
);
