import 'package:get/get.dart';

import '../../constants/app_constants.dart';
import '../api/api_client.dart';

class OrderRepo extends GetxService {
  final ApiClient apiClient;
  OrderRepo({
    required this.apiClient,
  });

  //busca todos os pedidos do usuário logado
  Future<Response> getListOrders(String token) async {
    apiClient.token = token;
    return await apiClient.getData(AppConstants.ORDERS_URI);
  }

  //Busca os dados da overview
  Future<Response> getOverview(String token) async {
    apiClient.token = token;
    return await apiClient.getData(AppConstants.ORDERS_OVERVIEW_URI);
  }

  //edita informações do produto pelo ID
  Future<Response> updateInfoOrder(int idOrder, String token, String body) async {
    apiClient.token = token;
    return await apiClient.putData('${AppConstants.ORDERS_URI}/$idOrder', body);
  }
}
