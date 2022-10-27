import 'package:flutter/material.dart';

import '../../constants/style.dart';
import '../../utils/dimensions.dart';
import '../Text/custom_text.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final double width;
  final double height;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback onTap;

  ButtonWidget({
    Key? key,
    required this.text,
    required this.width,
    required this.height,
    required this.backgroundColor,
    required this.textColor,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Center(
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.radius20),
            color: active,
          ),
          child: Center(
            child: CustomText(
              size: Dimensions.font16,
              text: text,
              color: textWhite,
            ),
          ),
        ),
      ),
    );
  }
}
