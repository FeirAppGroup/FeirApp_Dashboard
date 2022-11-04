import 'package:dashboard_feirapp/controllers/model_controller/user_controller.dart';
import 'package:dashboard_feirapp/models/model/user_model.dart';
import 'package:dashboard_feirapp/utils/dimensions.dart';
import 'package:dashboard_feirapp/widgets/Button/button_widget.dart';
import 'package:dashboard_feirapp/widgets/Button/icon_button_widget.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/style.dart';
import '../../../widgets/Text/custom_text.dart';

/// Example without a datasource
class ProductorTable extends StatefulWidget {
  const ProductorTable({Key? key}) : super(key: key);

  @override
  State<ProductorTable> createState() => _ProductorTableState();
}

class _ProductorTableState extends State<ProductorTable> {
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
          initProductors,
          _createDataTable(),
        ],
      ),
    );
  }
}

List<UserModel> productors = [];

var userController = Get.find<UserController>();

var initProductors = GetBuilder<UserController>(builder: (productor) {
  productors = productor.productorList;
  return Container();
});

DataTable _createDataTable() {
  return DataTable(columns: _createColumns(), rows: _createRows());
}

List<DataColumn> _createColumns() {
  return [
    DataColumn2(
      label: CustomText(
        text: 'ID',
        color: textWhite,
      ),
      size: ColumnSize.L,
    ),
    DataColumn(
      label: CustomText(
        text: 'Nome',
        color: textWhite,
      ),
    ),
    DataColumn(
      label: CustomText(
        text: 'Email',
        color: textWhite,
      ),
    ),
    DataColumn(
      label: CustomText(
        text: 'Ação',
        color: textWhite,
      ),
    ),
  ];
}

List<DataRow> _createRows() {
  return productors
      .map(
        (productor) => DataRow(
          cells: [
            DataCell(
              CustomText(
                text: productor.id.toString(),
                color: textWhite,
              ),
            ),
            DataCell(
              CustomText(
                text: productor.nome,
                color: textWhite,
              ),
            ),
            DataCell(
              CustomText(
                text: productor.email,
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
                onTap: () {},
              ),
            ),
          ],
        ),
      )
      .toList();
}
