import 'package:dashboard_feirapp/data/api/api_client.dart';
import 'package:get/get.dart';

import '../../constants/app_constants.dart';

class ProductRepo extends GetxService {
  final ApiClient apiClient;

  ProductRepo({
    required this.apiClient,
  });

  //Busca as produtos cadastrados
  Future<Response> getProductsList(String token) async {
    apiClient.token = token;
    return await apiClient.getData(AppConstants.PRODUCTS_URI);
  }

  //busca informações do produto pelo ID
  Future<Response> getInfoProduct(int idProduct, String token) async {
    apiClient.token = token;
    return await apiClient.getData('${AppConstants.PRODUCTS_URI}/$idProduct');
  }

  //cadastra um novo produto
  Future<Response> registerNewProduct(String body) async {
    return await apiClient.postData(AppConstants.PRODUCTS_URI, body);
  }

  //edita informações do produto pelo ID
  Future<Response> updateInfoProduct(int idProduct, String token, String body) async {
    apiClient.token = token;
    return await apiClient.putData('${AppConstants.PRODUCTS_URI}/$idProduct', body);
  }

  //deleta informações do produto pelo ID
  Future<Response> deleteProduct(int idProperty, String token) async {
    apiClient.token = token;
    return await apiClient.deleteData('${AppConstants.PRODUCTS_URI}/$idProperty');
  }
}
