import 'package:dashboard_feirapp/constants/style.dart';
import 'package:dashboard_feirapp/controllers/model_controller/user_controller.dart';
import 'package:dashboard_feirapp/models/enum/type_user_enum.dart';
import 'package:dashboard_feirapp/models/model/user_model.dart';
import 'package:dashboard_feirapp/pages/productors/productor_form.dart';
import 'package:dashboard_feirapp/routing/routes.dart';
import 'package:dashboard_feirapp/utils/dimensions.dart';
import 'package:dashboard_feirapp/widgets/Button/button_widget.dart';
import 'package:dashboard_feirapp/widgets/Button/icon_button_widget.dart';
import 'package:dashboard_feirapp/widgets/TextFormField/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/controllers.dart';
import '../../helpers/responsiveness.dart';
import '../../layout.dart';
import '../../models/dtos/user_login_dto.dart';
import '../../widgets/Text/custom_text.dart';
import 'widgets/productor_table.dart';

class ProductorPage extends StatefulWidget {
  @override
  State<ProductorPage> createState() => _ProductorPageState();
}

class _ProductorPageState extends State<ProductorPage> {
  UserLoginDto? user;
  String? token;

  final UserController c = Get.put(UserController(userRepo: Get.find()));

  @override
  void initState() {
    super.initState();
    loadPref();
  }

  loadPref() async {
    SharedPreferences sharedUser = await SharedPreferences.getInstance();
    //print(sharedUser.getString('user'));
    if (sharedUser.getString('user') != null) {
      user = UserLoginDto.fromJson(sharedUser.getString('user') ?? "");
      token = user!.token;
      print(token);

      Get.find<UserController>().getProductorList(token!);
    }
  }

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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProductorForm(id: null),
                      ),
                    );
                  },
                  text: 'Adicionar Produtor',
                  backgroundColor: active,
                  height: Dimensions.height40,
                  width: Dimensions.width150,
                  textColor: textWhite,
                ),
                SizedBox(
                  width: Dimensions.width20,
                ),
                IconButtonWidget(
                  backgroundColor: starTableColor,
                  height: Dimensions.height40,
                  width: Dimensions.width64,
                  onTap: () {
                    // Just insert this code to button to refresh page.​
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductorPage()), // this mainpage is your page to refresh.
                      (Route<dynamic> route) => false,
                    );
                  },
                  icon: Icons.replay_outlined,
                  iconColor: mainWhite,
                ),
              ],
            ),
          ),
          ProductorTable(),
        ],
      ),
    );
  }
}
