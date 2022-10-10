import 'package:dashboard_feirapp/widgets/Menu_Item/side_menu_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/controllers.dart';
import '../../constants/style.dart';
import '../../helpers/responsiveness.dart';
import '../../routing/routes.dart';
import '../Text/custom_text.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    return Container(
      color: mainBlack,
      child: ListView(
        children: [
          if (ResponsiveWidget.isSmallScreen(context))
            Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: _width / 48,
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 12),
                      child: Image.asset("assets/icons/logo.png"),
                    ),
                    Flexible(
                      child: CustomText(
                        text: "Dash",
                        size: 20,
                        weight: FontWeight.bold,
                        color: textGray,
                      ),
                    ),
                    SizedBox(
                      width: _width / 48,
                    ),
                  ],
                ),
              ],
            ),
          SizedBox(
            height: 40,
          ),
          Divider(
            color: mainDividers,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: sideMenuItems
                .map(
                  (item) => SideMenuItem(
                    itemName: item.name,
                    onTap: () {
                      if (item.route == authenticationPageRoute) {
                        menuController.changeActiveitemTo(overViewPageDisplayName);
                        Get.offAllNamed(authenticationPageRoute);
                      }

                      if (!menuController.isActive(item.name)) {
                        menuController.changeActiveitemTo(item.name);
                        if (ResponsiveWidget.isSmallScreen(context)) {
                          Get.back();
                        }
                        navigationController.navigateTo(item.route);
                      }
                    },
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
