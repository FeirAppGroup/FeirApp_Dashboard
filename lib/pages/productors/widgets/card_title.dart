import 'package:flutter/material.dart';

import '../../../constants/controllers.dart';
import '../../../constants/style.dart';
import '../../../routing/routes.dart';
import '../../../utils/dimensions.dart';
import '../../../widgets/Button/button_widget.dart';
import '../../../widgets/Text/custom_text.dart';

class CardTitle extends StatelessWidget {
  final String title;
  bool isActive;

  CardTitle({
    Key? key,
    required this.title,
    this.isActive = false,
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
            ButtonWidget(
              text: 'Cancelar',
              backgroundColor: active,
              height: Dimensions.height40,
              width: Dimensions.width150,
              textColor: textWhite,
              onTap: () {
                navigationController.navigateTo(productorPageRoute);
              },
            )
          ],
        ),
      ),
    );
  }
}
