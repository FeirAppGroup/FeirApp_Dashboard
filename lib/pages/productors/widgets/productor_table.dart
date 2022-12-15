import 'package:dashboard_feirapp/controllers/model_controller/user_controller.dart';
import 'package:dashboard_feirapp/models/model/user_model.dart';
import 'package:dashboard_feirapp/pages/productors/productor_form.dart';
import 'package:dashboard_feirapp/utils/dimensions.dart';
import 'package:dashboard_feirapp/widgets/Button/icon_button_widget.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/style.dart';
import '../../../models/dtos/user_login_dto.dart';
import '../../../widgets/Text/custom_text.dart';
import '../productor_page.dart';

/// Example without a datasource
class ProductorTable extends StatefulWidget {
  const ProductorTable({Key? key}) : super(key: key);

  @override
  State<ProductorTable> createState() => _ProductorTableState();
}

class _ProductorTableState extends State<ProductorTable> {
  var userController = Get.find<UserController>();

  List<UserModel> productors = [];

  UserLoginDto? user;
  String? token;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    loadPref();
  }

  initProductors() async {
    setState(() {
      isLoading = true;
    });

    await userController.getProductorList(token!);
    productors = userController.productorList;

    setState(() {
      isLoading = false;
    });
  }

  loadPref() async {
    SharedPreferences sharedUser = await SharedPreferences.getInstance();
    //print(sharedUser.getString('user'));
    if (sharedUser.getString('user') != null) {
      user = UserLoginDto.fromJson(sharedUser.getString('user') ?? "");
      token = user!.token;
      print(token);

      initProductors();
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
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductorForm(id: productor.id),
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

                    _deleteUser(productor.id!);

                    _reloadPage();
                    _reloadPage();
                  },
                ),
              ),
            ],
          ),
        )
        .toList();
  }

  Future<void> _deleteUser(int idUser) async {
    await userController.deleteProfileUser(idUser, token!);
  }

  _reloadPage() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => ProductorPage()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return isLoading == true || productors.isEmpty
        ? Center(
            child: SpinKitCircle(
              itemBuilder: (BuildContext context, int index) {
                return const DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                );
              },
            ),
          )
        : Container(
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
                _createDataTable(context),
              ],
            ),
          );
  }
}
