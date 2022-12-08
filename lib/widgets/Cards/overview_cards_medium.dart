import 'package:flutter/material.dart';

import '../../pages/overview/widgets/info_card.dart';
import '../../utils/dimensions.dart';

class OverviewCardsMediumScreen extends StatelessWidget {
  String title1;
  String value1;

  String title2;
  String value2;

  String title3;
  String value3;

  String title4;
  String value4;

  OverviewCardsMediumScreen({
    Key? key,
    required this.title1,
    required this.value1,
    required this.title2,
    required this.value2,
    required this.title3,
    required this.value3,
    required this.title4,
    required this.value4,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    var divider64 = SizedBox(
      width: _width / Dimensions.width64,
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            InfoCard(
              title: title1,
              value: value1,
              topColor: Colors.orange,
              isActive: false,
              onTap: () {},
            ),
            divider64,
            InfoCard(
              title: title2,
              value: value2,
              topColor: Colors.lightGreen,
              isActive: false,
              onTap: () {},
            ),
          ],
        ),
        SizedBox(height: Dimensions.height16),
        Row(
          children: [
            InfoCard(
              title: title3,
              value: value3,
              topColor: Colors.redAccent,
              isActive: false,
              onTap: () {},
            ),
            divider64,
            InfoCard(
              title: title4,
              value: value4,
              topColor: Colors.blueGrey,
              isActive: false,
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }
}
