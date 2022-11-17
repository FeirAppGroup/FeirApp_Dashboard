import 'package:dashboard_feirapp/utils/dimensions.dart';
import 'package:flutter/material.dart';

import '../../../constants/style.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final String value;
  final Color topColor;
  bool isActive;
  final VoidCallback onTap;

  InfoCard({
    Key? key,
    required this.title,
    required this.value,
    required this.topColor,
    this.isActive = false,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: Dimensions.height136,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: mainBlack,
            boxShadow: [
              BoxShadow(
                offset: Offset(0, Dimensions.height5),
                color: lightGrey.withOpacity(.1),
                blurRadius: Dimensions.radius12,
              ),
            ],
            borderRadius: BorderRadius.circular(Dimensions.radius8),
            border: Border.all(),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      color: topColor,
                      height: Dimensions.height5,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Container(),
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "$title\n",
                      style: TextStyle(
                        fontSize: Dimensions.font16,
                        color: isActive ? textGray : textWhite,
                      ),
                    ),
                    TextSpan(
                      text: "$value\n",
                      style: TextStyle(
                        fontSize: Dimensions.font40,
                        color: isActive ? textGray : textWhite,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
