import 'package:flutter/material.dart';

import '../../constants/style.dart';
import '../../utils/dimensions.dart';
import '../Text/custom_text.dart';

class IconButtonWidget extends StatelessWidget {
  final double width;
  final double height;
  final Color backgroundColor;
  final Color iconColor;
  final VoidCallback onTap;
  final IconData icon;

  const IconButtonWidget({
    Key? key,
    required this.width,
    required this.height,
    required this.backgroundColor,
    required this.onTap,
    required this.icon,
    required this.iconColor,
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
            color: backgroundColor,
          ),
          child: Center(
            child: Icon(
              icon,
              color: iconColor,
            ),
          ),
        ),
      ),
    );
  }
}
