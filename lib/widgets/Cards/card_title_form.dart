import 'package:flutter/material.dart';

import '../../constants/controllers.dart';
import '../../constants/style.dart';
import '../../routing/routes.dart';
import '../../utils/dimensions.dart';
import '../Button/button_widget.dart';
import '../Text/custom_text.dart';

// ignore: must_be_immutable
class CardTitleForm extends StatelessWidget {
  final String title;
  bool isActive;
  ButtonWidget button;

  CardTitleForm({
    Key? key,
    required this.title,
    this.isActive = false,
    required this.button,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.fromLTRB(
          Dimensions.width20,
          Dimensions.height30,
          Dimensions.width20,
          Dimensions.height30,
        ),
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
              weight: FontWeight.bold,
              color: isActive ? textWhite : lightGrey,
            ),
            button,
          ],
        ),
      ),
    );
  }
}
