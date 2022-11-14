import 'package:dashboard_feirapp/models/model/property_model.dart';
import 'package:get/get.dart';

import 'package:dashboard_feirapp/data/repository/property_repo.dart';

class PropertyController extends GetxController {
  final PropertyRepo propertyRepo;

  PropertyController({
    required this.propertyRepo,
  });

  List<PropertyModel> _propertyList = [];

  List<PropertyModel> get propertyList => _propertyList;

  Future<void> getPropertyList(String token) async {
    Response response = await propertyRepo.getPropertysList(token);
    if (response.statusCode == 200) {
      _propertyList = response.body
          .map<PropertyModel>(
            (e) => PropertyModel.fromMap(e),
          )
          .toList();
      update();
    } else {}
  }

  Future<PropertyModel> getInfoProperty(int idProperty, String token) async {
    Response response = await propertyRepo.getInfoProperty(idProperty, token);
    if (response.statusCode == 200) {
      return PropertyModel.fromMap(response.body);
    } else {
      return throw Exception('Erro ao buscar propriedade.');
    }
  }

  Future<String> registerNewProperty(PropertyModel property) async {
    Response response = await propertyRepo.registerNewProperty(property.toJson());
    print(property.toJson());
    if (response.statusCode == 200) {
      return 'Propriedade cadastrada com sucesso!';
    } else {
      return 'Erro ao cadastrar propriedade!';
    }
  }

  Future<String> updateInfoProperty(int idProperty, String token, PropertyModel property) async {
    Response response = await propertyRepo.updateInfoProperty(idProperty, token, property.toJson());
    print(property.toJson());
    if (response.statusCode == 200) {
      return 'Propriedade atualizada com sucesso!';
    } else {
      return 'Erro ao atualizar propriedade!';
    }
  }

  Future<String> deleteProperty(int idProperty, String token) async {
    Response response = await propertyRepo.deleteProperty(idProperty, token);
    if (response.statusCode == 200) {
      return 'Propriedade apagada com sucesso!';
    } else {
      return 'Erro ao apagar propriedade!';
    }
  }
}
