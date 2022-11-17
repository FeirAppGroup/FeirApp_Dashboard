import 'package:dashboard_feirapp/controllers/model_controller/product_controller.dart';
import 'package:dashboard_feirapp/controllers/model_controller/property_controller.dart';
import 'package:dashboard_feirapp/pages/products/widgets/products_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/controllers.dart';
import '../../constants/style.dart';
import '../../helpers/responsiveness.dart';
import '../../models/dtos/user_login_dto.dart';
import '../../utils/dimensions.dart';
import '../../widgets/Button/button_widget.dart';
import '../../widgets/Button/icon_button_widget.dart';
import '../../widgets/Cards/card_title_table.dart';
import '../../widgets/Text/custom_text.dart';
import 'widgets/products_table.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  UserLoginDto? user;
  String? token;

  @override
  void initState() {
    super.initState();
    loadPref();
  }

  loadPref() async {
    SharedPreferences sharedUser = await SharedPreferences.getInstance();
    if (sharedUser.getString('user') != null) {
      user = UserLoginDto.fromJson(sharedUser.getString('user') ?? "");
      token = user!.token;
      print(token);

      Get.find<ProductController>().getProductsList(token!);
      Get.find<PropertyController>().getPropertyList(token!);
    }
  }

  _nextPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ProductsForm(id: null),
      ),
    );
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
                CardTitleTable(
                  title: "Tabela de Produtos",
                  isActive: true,
                  button: ButtonWidget(
                    onTap: () {
                      _nextPage();
                    },
                    text: 'Adicionar Produto',
                    backgroundColor: active,
                    height: Dimensions.height40,
                    width: Dimensions.width150,
                    textColor: textWhite,
                  ),
                  iconButton: IconButtonWidget(
                    backgroundColor: starTableColor,
                    height: Dimensions.height40,
                    width: Dimensions.width64,
                    onTap: () {
                      // Just insert this code to button to refresh page.​
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductsPage()), // this mainpage is your page to refresh.
                        (Route<dynamic> route) => false,
                      );
                    },
                    icon: Icons.replay_outlined,
                    iconColor: mainWhite,
                  ),
                ),
              ],
            ),
          ),
          ProductsTable(),
        ],
      ),
    );
  }
}
