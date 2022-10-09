import 'package:flutter/material.dart';

import '../../pages/overview/widgets/info_card.dart';

class OverviewCardsMediumScreen extends StatelessWidget {
  const OverviewCardsMediumScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

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
            SizedBox(
              width: _width / 64,
            ),
            InfoCard(
              title: "Packages delivered",
              value: "17",
              topColor: Colors.lightGreen,
              isActive: false,
              onTap: () {},
            ),
          ],
        ),
        SizedBox(height: 16),
        Row(
          children: [
            InfoCard(
              title: "Cancelled delivery",
              value: "3",
              topColor: Colors.redAccent,
              isActive: false,
              onTap: () {},
            ),
            SizedBox(
              width: _width / 64,
            ),
            InfoCard(
              title: "Scheduled deliveries",
              value: "3",
              topColor: Colors.blueGrey,
              isActive: false,
              onTap: () {},
            ),
            SizedBox(
              width: _width / 64,
            ),
          ],
        ),
      ],
    );
  }
}
