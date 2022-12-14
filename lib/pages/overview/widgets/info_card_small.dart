import 'package:flutter/material.dart';

import '../../../constants/style.dart';
import '../../../widgets/Text/custom_text.dart';

class InfoCardSmall extends StatelessWidget {
  final String title;
  final String value;
  bool isActive;
  final VoidCallback onTap;

  InfoCardSmall({
    Key? key,
    required this.title,
    required this.value,
    this.isActive = false,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: mainBlack,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isActive ? textWhite : lightGrey,
              width: .5,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: title,
                size: 24,
                weight: FontWeight.w300,
                color: isActive ? textWhite : lightGrey,
              ),
              CustomText(
                text: value,
                size: 24,
                weight: FontWeight.bold,
                color: isActive ? textWhite : lightGrey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
