import 'package:dashboard_feirapp/main.dart';
import 'package:dashboard_feirapp/pages/overview/widgets/revenue_section/revenue_section_large.dart';
import 'package:dashboard_feirapp/pages/overview/widgets/revenue_section/revenue_section_small.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/controllers.dart';
import '../../constants/style.dart';
import '../../helpers/responsiveness.dart';
import '../../widgets/Cards/overview_cards_large.dart';
import '../../widgets/Cards/overview_cards_medium.dart';
import '../../widgets/Cards/overview_cards_small.dart';
import '../../widgets/Text/custom_text.dart';
import 'widgets/available_drivers.dart';

class OverviewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
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
            ],
          ),
        ),
        Expanded(
          child: ListView(
            children: [
              if (ResponsiveWidget.isLargeScreen(context) || ResponsiveWidget.isMediumScreen(context))
                if (ResponsiveWidget.isCustomSize(context)) OverviewCardsMediumScreen() else OverviewCardsLargeScreen()
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
