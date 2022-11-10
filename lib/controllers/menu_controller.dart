import 'package:dashboard_feirapp/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/style.dart';
import '../routing/routes.dart';

class MenuController extends GetxController {
  static MenuController instance = Get.find();

  var activeItem = overViewPageDisplayName.obs;
  var hoverItem = "".obs;

  changeActiveitemTo(String itemName) {
    activeItem.value = itemName;
  }

  onHover(String itemName) {
    if (!isActive(itemName)) hoverItem.value = itemName;
  }

  isActive(String itemName) => activeItem.value == itemName;

  isHovering(String itemName) => hoverItem.value == itemName;

  Widget returnIconFor(String itemName) {
    switch (itemName) {
      case overViewPageDisplayName:
        return _customIcon(Icons.trending_up, itemName);
      case productorPageDisplayName:
        return _customIcon(Icons.person_add, itemName);
      case clientsPageDisplayName:
        return _customIcon(Icons.add_home_work_rounded, itemName);
      case authenticationPageDisplayName:
        return _customIcon(Icons.exit_to_app, itemName);
      default:
        return _customIcon(Icons.exit_to_app, itemName);
    }
  }

  Widget _customIcon(IconData icon, String itemName) {
    if (isActive(itemName)) {
      return Icon(
        icon,
        size: Dimensions.icon22,
        color: textGray,
      );
    }

    return Icon(
      icon,
      color: isHovering(itemName) ? textGray : textWhite,
    );
  }
}
