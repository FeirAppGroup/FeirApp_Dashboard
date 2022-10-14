import 'package:get/get.dart';

import '../../data/repository/login_repo.dart';
import '../../models/dtos/login_dto.dart';
import '../../models/dtos/user_login_dto.dart';

class LoginController extends GetxController with StateMixin {
  final LoginRepo loginRepo;
  LoginController({
    required this.loginRepo,
  });

  UserLoginDto? _user;

  UserLoginDto? get user => _user;

  Future<void> postAuth(LoginDTO login) async {
    print(login.login);
    print(login.senha);

    Response response = await loginRepo.postAuth(login);
    if (response.statusCode == 200) {
      _user = UserLoginDto.fromMap(response.body);
      _saveToken();
      update();
    } else {}
    print(response.statusCode);
    print(response.body);
  }

  Future<void> logout() async {
    // to save token in local storage
    _user != null ? _user!.token = '' : '';
    update();
  }

  _saveToken() async {
    // to save token in local storage
  }

  Future<String?> getToken() async {
    return null;
  }
}
