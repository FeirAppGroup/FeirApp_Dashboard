import 'package:dashboard_feirapp/constants/style.dart';
import 'package:dashboard_feirapp/controllers/model_controller/user_controller.dart';
import 'package:dashboard_feirapp/models/enum/type_user_enum.dart';
import 'package:dashboard_feirapp/models/model/user_model.dart';
import 'package:dashboard_feirapp/routing/routes.dart';
import 'package:dashboard_feirapp/utils/dimensions.dart';
import 'package:dashboard_feirapp/widgets/Button/button_widget.dart';
import 'package:dashboard_feirapp/widgets/TextFormField/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

import '../../constants/controllers.dart';
import '../../helpers/responsiveness.dart';
import '../../layout.dart';
import '../../widgets/Text/custom_text.dart';
import 'widgets/productor_table.dart';

class ProductorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Obx(
            () => Row(
              children: [
                Container(
                  height: Dimensions.height50,
                  margin: EdgeInsets.only(
                    top: ResponsiveWidget.isSmallScreen(context) ? Dimensions.height56 : Dimensions.height5,
                  ),
                  child: CustomText(
                    text: menuController.activeItem.value,
                    size: Dimensions.font24,
                    color: mainWhite,
                    weight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ButtonWidget(
                  onTap: () {
                    navigationController.navigateTo(productorFormRoute);
                  },
                  text: 'Adicionar Produtor',
                  backgroundColor: active,
                  height: Dimensions.height40,
                  width: Dimensions.width150,
                  textColor: textWhite,
                ),
              ],
            ),
          ),
          ProductorTable()
        ],
      ),
    );
  }
}
