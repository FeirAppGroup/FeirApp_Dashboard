import 'package:flutter/material.dart';

import '../../../../constants/style.dart';
import '../../../../widgets/Text/custom_text.dart';

import 'revenue_info.dart';

class RevenueSectionLarge extends StatelessWidget {
  const RevenueSectionLarge({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      margin: EdgeInsets.symmetric(vertical: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(offset: Offset(0, 6), color: lightGrey.withOpacity(.1), blurRadius: 12),
        ],
        border: Border.all(color: lightGrey, width: .5),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomText(
                  text: "Revenue Chart",
                  size: 20,
                  weight: FontWeight.bold,
                  color: lightGrey,
                ),
                Container(
                  width: 500,
                  height: 200,
                  //child: ChartsDrivers(),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      RevenueInfo(
                        title: "Today\'s revenue",
                        amount: "23",
                      ),
                      RevenueInfo(
                        title: "Last 7 days",
                        amount: "150",
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      RevenueInfo(
                        title: "Last 30 days",
                        amount: "1,203",
                      ),
                      RevenueInfo(
                        title: "Last 12 months",
                        amount: "3,234",
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
