import 'package:flutter/material.dart';

import '../../pages/overview/widgets/info_card.dart';
import '../../utils/dimensions.dart';

class OverviewCardsMediumScreen extends StatelessWidget {
  const OverviewCardsMediumScreen({Key? key}) : super(key: key);

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
              title: "Rides in progress",
              value: "7",
              topColor: Colors.orange,
              isActive: false,
              onTap: () {},
            ),
            divider64,
            InfoCard(
              title: "Packages delivered",
              value: "17",
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
              title: "Cancelled delivery",
              value: "3",
              topColor: Colors.redAccent,
              isActive: false,
              onTap: () {},
            ),
            divider64,
            InfoCard(
              title: "Scheduled deliveries",
              value: "3",
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
