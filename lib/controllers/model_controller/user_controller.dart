import 'package:dashboard_feirapp/models/model/user_model.dart';
import 'package:get/get.dart';

import 'package:dashboard_feirapp/data/repository/user_repo.dart';

class UserController extends GetxController {
  final UserRepo userRepo;

  UserController({
    required this.userRepo,
  });

  Future<String> registerNewUser(UserModel user) async {
    Response response = await userRepo.registerNewUser(user.toJson());
    if (response.statusCode == 200) {
      return 'Usuário cadastrado com sucesso!';
    } else {
      return 'Erro ao cadastrar usuário!';
    }
  }
}
