import 'package:dashboard_feirapp/controllers/model_controller/product_controller.dart';
import 'package:dashboard_feirapp/pages/products/widgets/products_form.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/style.dart';
import '../../../models/dtos/user_login_dto.dart';
import '../../../models/model/product_model.dart';
import '../../../utils/dimensions.dart';
import '../../../widgets/Button/icon_button_widget.dart';
import '../../../widgets/Text/custom_text.dart';

class ProductsTable extends StatefulWidget {
  const ProductsTable({Key? key}) : super(key: key);

  @override
  State<ProductsTable> createState() => _ProductsTableState();
}

class _ProductsTableState extends State<ProductsTable> {
  var productController = Get.find<ProductController>();

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
    }
  }

  DataTable _createDataTable(BuildContext context) {
    return DataTable(columns: _createColumns(), rows: _createRows(context));
  }

  List<DataColumn> _createColumns() {
    return [
      DataColumn2(
        label: CustomText(
          text: 'Nome',
          color: textWhite,
          size: Dimensions.font12,
        ),
        size: ColumnSize.L,
      ),
      DataColumn(
        label: CustomText(
          text: 'Valor',
          color: textWhite,
          size: Dimensions.font10,
        ),
      ),
      DataColumn(
        label: CustomText(
          text: 'Editar',
          color: textWhite,
          size: Dimensions.font12,
        ),
      ),
      DataColumn(
        label: CustomText(
          text: 'Apagar',
          color: textWhite,
          size: Dimensions.font12,
        ),
      ),
    ];
  }

  List<DataRow> _createRows(
    BuildContext context,
  ) {
    return products
        .map(
          (products) => DataRow(
            cells: [
              DataCell(
                CustomText(
                  text: products.nome,
                  color: textWhite,
                ),
              ),
              DataCell(
                CustomText(
                  text: products.valor.toString(),
                  color: textWhite,
                ),
              ),
              DataCell(
                IconButtonWidget(
                  width: Dimensions.width40,
                  height: Dimensions.height40,
                  backgroundColor: textLiteblue,
                  iconColor: mainBlack,
                  icon: Icons.edit,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductsForm(id: products.id),
                      ),
                    );
                  },
                ),
              ),
              DataCell(
                IconButtonWidget(
                  width: Dimensions.width40,
                  height: Dimensions.height40,
                  backgroundColor: tertiaryRed,
                  iconColor: mainBlack,
                  icon: Icons.delete,
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          height: 200,
                          color: Colors.red,
                          child: CustomText(
                            text: "Remoção completa",
                            color: textWhite,
                            size: Dimensions.font12,
                          ),
                        );
                      },
                    );

                    _deleteProduct(products.id!);
                  },
                ),
              ),
            ],
          ),
        )
        .toList();
  }

  Future<void> _deleteProduct(int idProduct) async {
    await productController.deleteProduct(idProduct, token!);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Dimensions.height16),
      margin: EdgeInsets.only(bottom: Dimensions.height30),
      decoration: BoxDecoration(
        color: mainBlack,
        borderRadius: BorderRadius.circular(Dimensions.radius8),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, Dimensions.height5),
            color: lightGrey.withOpacity(.1),
            blurRadius: Dimensions.radius12,
          ),
        ],
        border: Border.all(
          color: mainWhite,
          width: .5,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          initProducts,
          _createDataTable(context),
        ],
      ),
    );
  }
}

List<ProductModel> products = [];

var initProducts = GetBuilder<ProductController>(builder: (product) {
  products = product.productsList;
  return Container();
});
