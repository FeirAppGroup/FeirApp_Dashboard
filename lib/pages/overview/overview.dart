import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/controllers.dart';
import '../../helpers/responsiveness.dart';
import '../../widgets/Cards/overview_cards_large.dart';
import '../../widgets/Cards/overview_cards_medium.dart';
import '../../widgets/Cards/overview_cards_small.dart';
import '../../widgets/Text/custom_text.dart';

class OverviewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(
          () => Row(
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: ResponsiveWidget.isSmallScreen(context) ? 56 : 6,
                ),
                child: CustomText(
                  text: menuController.activeItem.value,
                  size: 24,
                  weight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: ListView(
            children: [
              if (ResponsiveWidget.isLargeScreen(context) || ResponsiveWidget.isMediumScreen(context))
                if (ResponsiveWidget.isCustomSize(context)) OverviewCardsMediumScreen() else OverviewCardsLargeScreen()
              else
                OverviewCardsSmallScreen()
            ],
          ),
        ),
      ],
    );
  }
}
