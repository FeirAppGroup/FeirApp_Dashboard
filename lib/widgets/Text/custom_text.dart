import 'package:dashboard_feirapp/utils/dimensions.dart';
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  double? size;
  Color? color;
  FontWeight? weight;
  CustomText({
    Key? key,
    required this.text,
    this.size,
    this.color,
    this.weight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size ?? Dimensions.font16,
        color: color ?? Colors.black,
        fontWeight: weight ?? FontWeight.normal,
      ),
    );
  }
}
