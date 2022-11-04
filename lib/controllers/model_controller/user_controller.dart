import 'package:dashboard_feirapp/models/model/user_model.dart';
import 'package:get/get.dart';

import 'package:dashboard_feirapp/data/repository/user_repo.dart';

class UserController extends GetxController with StateMixin {
  final UserRepo userRepo;

  UserController({
    required this.userRepo,
  });

  List<UserModel> _productorList = [];

  List<UserModel> get productorList => _productorList;

  Future<void> getProductorList(String token) async {
    Response response = await userRepo.getProductorList(token);
    if (response.statusCode == 200) {
      _productorList = response.body
          .map<UserModel>(
            (e) => UserModel.fromMap(e),
          )
          .toList();
      update();
    } else {}
  }

  Future<String> registerNewUser(UserModel user) async {
    Response response = await userRepo.registerNewUser(user.toJson());
    print(user.toJson());
    if (response.statusCode == 200) {
      return 'Usuário cadastrado com sucesso!';
    } else {
      return 'Erro ao cadastrar usuário!';
    }
  }
}
