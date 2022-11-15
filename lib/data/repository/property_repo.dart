import 'package:get/get.dart';

import 'package:dashboard_feirapp/data/api/api_client.dart';

import '../../constants/app_constants.dart';

class PropertyRepo extends GetxService {
  final ApiClient apiClient;

  PropertyRepo({
    required this.apiClient,
  });

  //Busca as propriedades cadastradas
  Future<Response> getPropertysList(String token) async {
    apiClient.token = token;
    return await apiClient.getData(AppConstants.PROPERTY_URI);
  }

  //busca informações da propriedade pelo ID
  Future<Response> getInfoProperty(int idProperty, String token) async {
    apiClient.token = token;
    return await apiClient.getData(AppConstants.PROPERTY_URI + '/$idProperty');
  }

  //cadastra um novo propriedade
  Future<Response> registerNewProperty(String body) async {
    return await apiClient.postData(AppConstants.PROPERTY_URI, body);
  }

  //edita informações da propriedade pelo ID
  Future<Response> updateInfoProperty(int idProperty, String token, String body) async {
    apiClient.token = token;
    return await apiClient.putData(AppConstants.PROPERTY_URI + '/$idProperty', body);
  }

  //deleta informações da propriedade pelo ID
  Future<Response> deleteProperty(int idProperty, String token) async {
    apiClient.token = token;
    return await apiClient.deleteData(AppConstants.PROPERTY_URI + '/$idProperty');
  }
}
