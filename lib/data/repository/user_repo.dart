import 'package:dashboard_feirapp/models/model/user_model.dart';
import 'package:get/get.dart';

import 'package:dashboard_feirapp/data/api/api_client.dart';

import '../../constants/app_constants.dart';

class UserRepo extends GetxService {
  final ApiClient apiClient;

  UserRepo({
    required this.apiClient,
  });

  //Busca todos os usuários
  Future<Response> getUsersList(String token) async {
    apiClient.token = token;
    return await apiClient.getData(AppConstants.USER_URI);
  }

  //Busca somente os produtores
  Future<Response> getProductorsList(String token) async {
    apiClient.token = token;
    return await apiClient.getData(AppConstants.USERS_PRODUCTOR_URI);
  }

  //busca informações do usuário pelo ID
  Future<Response> getInfoProfileUser(int idUser, String token) async {
    apiClient.token = token;
    return await apiClient.getData(AppConstants.USER_URI + '/$idUser');
  }

  //cadastra um novo usuário
  Future<Response> registerNewUser(String body) async {
    return await apiClient.postData(AppConstants.USER_URI, body);
  }

  //edita informações do usuário pelo ID
  Future<Response> updateInfoProfileUser(int idUser, String token, String body) async {
    apiClient.token = token;
    return await apiClient.putData(AppConstants.USER_URI + '/$idUser', body);
  }

  //deleta informações do usuário pelo ID
  Future<Response> deleteProfileUser(int idUser, String token) async {
    apiClient.token = token;
    return await apiClient.deleteData(AppConstants.USER_URI + '/$idUser');
  }
}
