import 'package:dashboard_feirapp/utils/dimensions.dart';
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

    final space40 = SizedBox(
      height: Dimensions.height40,
    );

    final width48 = SizedBox(
      width: _width / Dimensions.width48,
    );

    return Container(
      color: mainBlack,
      child: ListView(
        children: [
          if (ResponsiveWidget.isSmallScreen(context))
            Column(
              children: [
                space40,
                Row(
                  children: [
                    width48,
                    Padding(
                      padding: EdgeInsets.only(right: Dimensions.width12),
                      child: Icon(
                        Icons.agriculture,
                        color: textWhite,
                      ),
                    ),
                    Flexible(
                      child: CustomText(
                        text: "Painel FeirApp",
                        size: Dimensions.font20,
                        weight: FontWeight.bold,
                        color: textWhite,
                      ),
                    ),
                    width48,
                  ],
                ),
              ],
            ),
          space40,
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
