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
}
