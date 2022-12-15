import 'package:dashboard_feirapp/data/api/api_client.dart';
import 'package:get/get.dart';

import '../../constants/app_constants.dart';

class InventoryRepo extends GetxService {
  final ApiClient apiClient;

  InventoryRepo({
    required this.apiClient,
  });

  //Busca os estoques cadastrados
  Future<Response> getInventoryList(String token) async {
    apiClient.token = token;
    return await apiClient.getData(AppConstants.INVENTORY_URI);
  }

  //Busca os estoques cadastrados
  Future<Response> getInventoryListProductName(String token) async {
    apiClient.token = token;
    return await apiClient.getData(AppConstants.INVENTORY_INFOPRODUCT_URI);
  }

  //busca informações do estoque pelo seu ID
  Future<Response> getInfoInventory(int idInventory, String token) async {
    apiClient.token = token;
    return await apiClient.getData('${AppConstants.INVENTORY_URI}/$idInventory');
  }

  //busca informações do estoque pelo seu ID
  Future<Response> getInventoryToProduct(int idProduct, String token) async {
    apiClient.token = token;
    return await apiClient.getData('${AppConstants.INVENTORY_PRODUCT_URI}/$idProduct');
  }

  //cadastra um novo estoque
  Future<Response> registerNewInventory(String body) async {
    return await apiClient.postData(AppConstants.INVENTORY_URI, body);
  }

  //edita informações do estoque pelo ID
  Future<Response> updateInfoInventory(int idInventory, String token, String body) async {
    apiClient.token = token;
    return await apiClient.putData('${AppConstants.INVENTORY_URI}/$idInventory', body);
  }

  //deleta informações do estoque pelo ID
  Future<Response> deleteInventory(int idInventory, String token) async {
    apiClient.token = token;
    return await apiClient.deleteData('${AppConstants.INVENTORY_URI}/$idInventory');
  }
}
