import 'dart:convert';

import 'package:dashboard_feirapp/helpers/shared_pref.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/repository/login_repo.dart';
import '../../main.dart';
import '../../models/dtos/login_dto.dart';
import '../../models/dtos/user_login_dto.dart';

class LoginController extends GetxController with StateMixin {
  final LoginRepo loginRepo;
  LoginController({
    required this.loginRepo,
  });

  UserLoginDto? _user;

  UserLoginDto? get user => _user;

  Future<String> postAuth(LoginDTO login) async {
    print(login.login);
    print(login.senha);

    Response response = await loginRepo.postAuth(login);
    if (response.statusCode == 200) {
      _user = UserLoginDto.fromMap(response.body);
      _saveToken();

      SharedPreferences prefs = await SharedPreferences.getInstance();
      Map<String, dynamic> userMap = _user!.toMap();
      await prefs.setString('user', json.encode(userMap));

      print(response.statusCode);
      print(response.body);

      //sharedPref.save("user", _user);

      update();

      return 'Ok';
    } else {
      return 'erro';
    }
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
