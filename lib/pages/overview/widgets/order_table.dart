import 'package:dashboard_feirapp/controllers/model_controller/order_controller.dart';
import 'package:dashboard_feirapp/models/model/order_model.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/style.dart';
import '../../../models/dtos/user_login_dto.dart';
import '../../../models/enum/forma_pagamento_enum.dart';
import '../../../models/model/item_cart_model.dart';
import '../../../utils/dimensions.dart';
import '../../../widgets/Button/icon_button_widget.dart';
import '../../../widgets/Text/custom_text.dart';

class OrderTable extends StatefulWidget {
  const OrderTable({Key? key}) : super(key: key);

  @override
  State<OrderTable> createState() => _OrderTableState();
}

class _OrderTableState extends State<OrderTable> {
  var orderController = Get.find<OrderController>();

  List<OrderModel> orders = [];

  UserLoginDto? user;
  String? token;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    loadPref();
  }

  initOrders() async {
    setState(() {
      isLoading = true;
    });

    await orderController.getListOrders(token!);
    orders = orderController.orders!;

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

      initOrders();
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
          text: 'Quantidade de Itens',
          color: textWhite,
        ),
      ),
      DataColumn(
        label: CustomText(
          text: 'Endereço de Entrega',
          color: textWhite,
        ),
      ),
      DataColumn(
        label: CustomText(
          text: 'Valor Total',
          color: textWhite,
        ),
      ),
      // DataColumn(
      //   label: CustomText(
      //     text: 'Aceitar Pedido',
      //     color: textWhite,
      //   ),
      // ),
    ];
  }

  List<DataRow> _createRows(
    BuildContext context,
  ) {
    return orders
        .map(
          (order) => DataRow(
            cells: [
              DataCell(
                CustomText(
                  text: order.id.toString(),
                  color: textWhite,
                ),
              ),
              DataCell(
                CustomText(
                  text: order.itemPedidos.length.toString(),
                  color: textWhite,
                ),
              ),
              DataCell(
                CustomText(
                  text: order.enderecoEntrega,
                  color: textWhite,
                ),
              ),
              DataCell(
                CustomText(
                  text: order.valorTotal.toStringAsFixed(2),
                  color: textWhite,
                ),
              ),
              // DataCell(
              //   IconButtonWidget(
              //     width: Dimensions.width40,
              //     height: Dimensions.height40,
              //     backgroundColor: tertiaryRed,
              //     iconColor: mainBlack,
              //     icon: Icons.delete,
              //     onTap: () {},
              //   ),
              // ),
            ],
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading == true || orders.isEmpty
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
