import 'package:flutter/material.dart';

import '../../pages/overview/widgets/info_card_small.dart';

class OverviewCardsSmallScreen extends StatelessWidget {
  String title1;
  String value1;

  String title2;
  String value2;

  String title3;
  String value3;

  String title4;
  String value4;

  OverviewCardsSmallScreen({
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

    return Container(
      height: 400,
      child: Column(
        children: [
          InfoCardSmall(
            title: title1,
            value: value1,
            isActive: true,
            onTap: () {},
          ),
          SizedBox(
            height: _width / 64,
          ),
          InfoCardSmall(
            title: title2,
            value: value2,
            isActive: false,
            onTap: () {},
          ),
          SizedBox(
            height: _width / 64,
          ),
          InfoCardSmall(
            title: title3,
            value: value3,
            isActive: false,
            onTap: () {},
          ),
          SizedBox(
            height: _width / 64,
          ),
          InfoCardSmall(
            title: title4,
            value: value4,
            isActive: false,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
