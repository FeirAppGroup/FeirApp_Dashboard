import 'dart:convert';

import 'package:dashboard_feirapp/main.dart';
import 'package:dashboard_feirapp/models/dtos/user_login_dto.dart';
import 'package:dashboard_feirapp/models/model/overview_model.dart';
import 'package:dashboard_feirapp/pages/overview/widgets/order_table.dart';
import 'package:dashboard_feirapp/pages/overview/widgets/revenue_section/revenue_section_large.dart';
import 'package:dashboard_feirapp/pages/overview/widgets/revenue_section/revenue_section_small.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/controllers.dart';
import '../../constants/style.dart';
import '../../controllers/model_controller/order_controller.dart';
import '../../helpers/responsiveness.dart';
import '../../models/model/order_model.dart';
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
  var orderController = Get.find<OrderController>();

  List<OrderModel> orders = [];
  OverviewModel? overviewModel;

  UserLoginDto? user;
  String? token;
  bool isLoading = true;

  initOrders() async {
    setState(() {
      isLoading = true;
    });

    await orderController.getOverview(token!);
    overviewModel = orderController.overviewModel!;

    setState(() {
      isLoading = false;
    });
  }

  loadPref() async {
    SharedPreferences sharedUser = await SharedPreferences.getInstance();
    if (sharedUser.getString('user') != null) {
      user = UserLoginDto.fromJson(sharedUser.getString('user') ?? "");
      token = user!.token;
      print(user);

      initOrders();
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    loadPref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading || overviewModel == null
        ? Center(
            child: SpinKitCircle(
              itemBuilder: (BuildContext context, int index) {
                return const DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                );
              },
            ),
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
                    //Text("Email: " + user!.email)
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    if (ResponsiveWidget.isLargeScreen(context) || ResponsiveWidget.isMediumScreen(context))
                      if (ResponsiveWidget.isCustomSize(context))
                        OverviewCardsMediumScreen(
                          title1: 'Total de Produtores',
                          value1: overviewModel!.totalProductors.toString(),
                          title2: 'Total de Usuários',
                          value2: overviewModel!.totalUsers.toString(),
                          title3: 'Pedidos Abertos',
                          value3: overviewModel!.orderOpened.toString(),
                          title4: 'Pedidos Fechados',
                          value4: overviewModel!.orderClosed.toString(),
                        )
                      else
                        OverviewCardsLargeScreen(
                          title1: 'Total de Produtores',
                          value1: overviewModel!.totalProductors.toString(),
                          title2: 'Total de Usuários',
                          value2: overviewModel!.totalUsers.toString(),
                          title3: 'Pedidos Abertos',
                          value3: overviewModel!.orderOpened.toString(),
                          title4: 'Pedidos Fechados',
                          value4: overviewModel!.orderClosed.toString(),
                        )
                    else
                      OverviewCardsSmallScreen(
                        title1: 'Total de Produtores',
                        value1: overviewModel!.totalProductors.toString(),
                        title2: 'Total de Usuários',
                        value2: overviewModel!.totalUsers.toString(),
                        title3: 'Pedidos Abertos',
                        value3: overviewModel!.orderOpened.toString(),
                        title4: 'Pedidos Fechados',
                        value4: overviewModel!.orderClosed.toString(),
                      ),
                    if (!ResponsiveWidget.isSmallScreen(context))
                      RevenueSectionLarge(
                        value1: double.parse(overviewModel!.totalProductors.toString()),
                        value2: double.parse(overviewModel!.totalUsers.toString()),
                        value3: double.parse(overviewModel!.orderOpened.toString()),
                        value4: double.parse(overviewModel!.orderClosed.toString()),
                      )
                    else
                      RevenueSectionSmall(
                        value1: double.parse(overviewModel!.totalProductors.toString()),
                        value2: double.parse(overviewModel!.totalUsers.toString()),
                        value3: double.parse(overviewModel!.orderOpened.toString()),
                        value4: double.parse(overviewModel!.orderClosed.toString()),
                      ),
                    OrderTable(),
                  ],
                ),
              ),
            ],
          );
  }
}
