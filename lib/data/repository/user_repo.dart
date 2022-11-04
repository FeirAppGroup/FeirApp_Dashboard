import 'package:get/get.dart';

import 'package:dashboard_feirapp/data/api/api_client.dart';

import '../../constants/app_constants.dart';

class UserRepo extends GetxService {
  final ApiClient apiClient;

  UserRepo({
    required this.apiClient,
  });

  Future<Response> getProductorList(String token) async {
    apiClient.token = token;
    return await apiClient.getData(AppConstants.USER_URI);
  }

  //busca informações do usuário
  Future<Response> getInfoProfileUser(int idUser, String token) async {
    apiClient.token = token;
    return await apiClient.getData(AppConstants.USER_URI + '/$idUser');
  }

//cadastra um novo usuário
  Future<Response> registerNewUser(String body) async {
    return await apiClient.postData(AppConstants.USER_URI, body);
  }
}
