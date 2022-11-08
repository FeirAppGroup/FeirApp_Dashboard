import 'package:dashboard_feirapp/models/dtos/user_edit_dto.dart';
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
    Response response = await userRepo.getProductorsList(token);
    if (response.statusCode == 200) {
      _productorList = response.body
          .map<UserModel>(
            (e) => UserModel.fromMap(e),
          )
          .toList();
      update();
    } else {}
  }

  Future<UserModel> getInfoProfileUser(int idUser, String token) async {
    Response response = await userRepo.getInfoProfileUser(idUser, token);
    if (response.statusCode == 200) {
      return UserModel.fromMap(response.body);
    } else {
      return throw Exception('Erro ao buscar produtor.');
    }
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

  Future<String> updateInfoProfileUser(int idUser, String token, UserEditDto user) async {
    Response response = await userRepo.updateInfoProfileUser(idUser, token, user.toJson());
    print(user.toJson());
    if (response.statusCode == 200) {
      return 'Usuário atualizado com sucesso!';
    } else {
      return 'Erro ao atualizar usuário!';
    }
  }
}
