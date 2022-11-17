import 'package:flutter/material.dart';

import '../../constants/style.dart';
import '../../utils/dimensions.dart';

class CardBottomForm extends StatelessWidget {
  double? marginLeft;
  double? marginTop;
  double? marginRight;
  double? marginBottom;

  CardBottomForm({
    Key? key,
    this.marginLeft,
    this.marginTop,
    this.marginRight,
    this.marginBottom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        Dimensions.width20,
        Dimensions.height30,
        Dimensions.width20,
        Dimensions.height50,
      ),
      margin: EdgeInsets.fromLTRB(
        marginLeft ?? 0,
        marginTop ?? 0,
        marginRight ?? 0,
        marginBottom ?? 0,
      ),
      decoration: BoxDecoration(
        color: mainBlack,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: textWhite,
          width: .5,
        ),
      ),
    );
  }
}
