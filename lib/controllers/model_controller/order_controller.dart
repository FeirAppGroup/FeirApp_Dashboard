import 'package:dashboard_feirapp/data/repository/order_repo.dart';
import 'package:dashboard_feirapp/models/model/overview_model.dart';
import 'package:get/get.dart';

import '../../models/dtos/shipping_address_dto.dart';
import '../../models/model/item_cart_model.dart';
import '../../models/model/order_model.dart';

class OrderController extends GetxController with StateMixin {
  final OrderRepo orderRepo;

  OrderController({
    required this.orderRepo,
  });

  //lista de pedidos
  List<dynamic>? _orders;
  List<OrderModel>? get orders => _orders!.cast<OrderModel>();

  OverviewModel? overviewModel;

  Future<void> getListOrders(String token) async {
    Response response = await orderRepo.getListOrders(token);
    if (response.statusCode == 200) {
      _orders = response.body.map((e) => OrderModel.fromMap(e)).toList();
      update();
    }
  }

  Future<void> getOverview(String token) async {
    Response response = await orderRepo.getOverview(token);
    if (response.statusCode == 200) {
      overviewModel = OverviewModel.fromMap(response.body);
      update();
    }
  }

  Future<String> updateInfoOrder(int idOrder, String token, OrderModel order) async {
    Response response = await orderRepo.updateInfoOrder(idOrder, token, order.toJson());
    print(order.toJson());
    if (response.statusCode == 200) {
      return 'Pedido atualizado com sucesso!';
    } else {
      return 'Erro ao atualizar pedido!';
    }
  }
}
