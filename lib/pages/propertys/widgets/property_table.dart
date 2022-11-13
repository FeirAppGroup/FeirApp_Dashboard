import 'package:dashboard_feirapp/controllers/model_controller/property_controller.dart';
import 'package:dashboard_feirapp/models/model/property_model.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/style.dart';
import '../../../models/dtos/user_login_dto.dart';
import '../../../utils/dimensions.dart';
import '../../../widgets/Button/icon_button_widget.dart';
import '../../../widgets/Text/custom_text.dart';

/// Example without a datasource
class PropertyTable extends StatefulWidget {
  @override
  State<PropertyTable> createState() => _PropertyTableState();
}

class _PropertyTableState extends State<PropertyTable> {
  var propertyController = Get.find<PropertyController>();

  UserLoginDto? user;
  String? token;

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
    }
  }

  DataTable _createDataTable(BuildContext context) {
    return DataTable(columns: _createColumns(), rows: _createRows(context));
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
          text: 'ID Proprietario',
          color: textWhite,
        ),
      ),
      DataColumn(
        label: CustomText(
          text: 'Nome',
          color: textWhite,
        ),
      ),
      DataColumn(
        label: CustomText(
          text: 'Endereco',
          color: textWhite,
        ),
      ),
      DataColumn(
        label: CustomText(
          text: 'Editar',
          color: textWhite,
        ),
      ),
      DataColumn(
        label: CustomText(
          text: 'Apagar',
          color: textWhite,
        ),
      ),
    ];
  }

  List<DataRow> _createRows(
    BuildContext context,
  ) {
    return propertys
        .map(
          (propertys) => DataRow(
            cells: [
              DataCell(
                CustomText(
                  text: propertys.id.toString(),
                  color: textWhite,
                ),
              ),
              DataCell(
                CustomText(
                  text: propertys.idUsuario.toString(),
                  color: textWhite,
                ),
              ),
              DataCell(
                CustomText(
                  text: propertys.nome,
                  color: textWhite,
                ),
              ),
              DataCell(
                CustomText(
                  text: propertys.endereco,
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
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => ProductorForm(id: productor.id),
                    //   ),
                    // );
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
                    // showModalBottomSheet(
                    //   context: context,
                    //   builder: (BuildContext context) {
                    //     return Container(
                    //       height: 200,
                    //       color: Colors.red,
                    //       child: CustomText(
                    //         text: "Remoção completa",
                    //         color: textWhite,
                    //         size: Dimensions.font12,
                    //       ),
                    //     );
                    //   },
                    // );

                    // _deleteUser(productor.id!);

                    // _reloadPage();
                    // _reloadPage();
                  },
                ),
              ),
            ],
          ),
        )
        .toList();
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
          initPropertys,
          _createDataTable(context),
        ],
      ),
    );
  }
}

List<PropertyModel> propertys = [];

var initPropertys = GetBuilder<PropertyController>(builder: (property) {
  propertys = property.propertyList;
  return Container();
});
