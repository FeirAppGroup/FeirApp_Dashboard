import 'dart:convert';

import 'package:dashboard_feirapp/main.dart';
import 'package:dashboard_feirapp/models/dtos/user_login_dto.dart';
import 'package:dashboard_feirapp/pages/overview/widgets/revenue_section/revenue_section_large.dart';
import 'package:dashboard_feirapp/pages/overview/widgets/revenue_section/revenue_section_small.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/controllers.dart';
import '../../constants/style.dart';
import '../../helpers/responsiveness.dart';
import '../../widgets/Cards/overview_cards_large.dart';
import '../../widgets/Cards/overview_cards_medium.dart';
import '../../widgets/Cards/overview_cards_small.dart';
import '../../widgets/Text/custom_text.dart';
import 'widgets/available_drivers.dart';

class OverviewPage extends StatefulWidget {
  @override
  State<OverviewPage> createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {
  loadPref() async {
    SharedPreferences sharedUser = await SharedPreferences.getInstance();
    user = UserLoginDto.fromJson(sharedUser.getString('user') ?? "");
    print(user);

    setState(() {
      isLoading = false;
    });
  }

  UserLoginDto? user;

  @override
  void initState() {
    loadPref();
    super.initState();
  }

  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? SpinKitCircle(
            itemBuilder: (BuildContext context, int index) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
              );
            },
          )
        : Column(
            children: [
              Obx(
                () => Row(
                  children: [
                    Container(
                      height: 50,
                      margin: EdgeInsets.only(
                        top: ResponsiveWidget.isSmallScreen(context) ? 56 : 6,
                      ),
                      child: CustomText(
                        text: menuController.activeItem.value,
                        size: 24,
                        color: textWhite,
                        weight: FontWeight.bold,
                      ),
                    ),
                    Text("Nome: " + user!.email)
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    if (ResponsiveWidget.isLargeScreen(context) || ResponsiveWidget.isMediumScreen(context))
                      if (ResponsiveWidget.isCustomSize(context))
                        OverviewCardsMediumScreen()
                      else
                        OverviewCardsLargeScreen()
                    else
                      OverviewCardsSmallScreen(),
                    if (!ResponsiveWidget.isSmallScreen(context)) RevenueSectionLarge() else RevenueSectionSmall(),
                    AvailableDrivers(),
                  ],
                ),
              ),
            ],
          );
  }
}
