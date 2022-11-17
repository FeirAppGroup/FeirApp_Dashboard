import 'package:get/get.dart';

import '../../constants/app_constants.dart';
import '../../models/dtos/login_dto.dart';
import '../api/api_client.dart';

class LoginRepo extends GetxService {
  final ApiClient apiClient;
  LoginRepo({
    required this.apiClient,
  });

  Future<Response> postAuth(LoginDTO login) async {
    return await apiClient.postAuth(AppConstants.AUTH_URI, login);
  }
}
