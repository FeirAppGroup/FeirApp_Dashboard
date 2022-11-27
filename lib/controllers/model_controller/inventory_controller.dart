import 'package:dashboard_feirapp/data/repository/inventory_repo.dart';
import 'package:dashboard_feirapp/models/dtos/inventory_dto.dart';
import 'package:dashboard_feirapp/models/model/inventory_model.dart';

import 'package:get/get.dart';

class InventoryController extends GetxController {
  final InventoryRepo inventoryRepo;

  InventoryController({
    required this.inventoryRepo,
  });

  List<InventoryModel> _inventoryList = [];

  List<InventoryModel> get inventoryList => _inventoryList;

  set inventoryList(List<InventoryModel> inventoryList) {
    _inventoryList = inventoryList;
  }

  List<InventoryDto> inventoryDtoList = [];

  Future<void> getInventoryList(String token) async {
    Response response = await inventoryRepo.getInventoryList(token);
    if (response.statusCode == 200) {
      _inventoryList = response.body
          .map<InventoryModel>(
            (e) => InventoryModel.fromMap(e),
          )
          .toList();
      update();
    } else {}
  }

  Future<void> getInventoryListProductName(String token) async {
    Response response = await inventoryRepo.getInventoryListProductName(token);
    if (response.statusCode == 200) {
      _inventoryList = response.body
          .map<InventoryModel>(
            (e) => InventoryModel.fromMap(e),
          )
          .toList();
      update();
    } else {}
  }

  Future<InventoryModel> getInfoInventory(int idInventory, String token) async {
    Response response = await inventoryRepo.getInfoInventory(idInventory, token);
    if (response.statusCode == 200) {
      return InventoryModel.fromMap(response.body);
    } else {
      return throw Exception('Erro ao buscar estoque.');
    }
  }

  // Future<void> getInventoryToProduct(int idProduct, String token) async {
  //   Response response = await inventoryRepo.getInventoryToProduct(idProduct, token);

  //   if (response.statusCode == 200) {
  //     _productCategoryFrutas = [];
  //     _productCategoryFrutas = response.body
  //         .map<ProductModel>(
  //           (e) => ProductModel.fromMap(e),
  //         )
  //         .toList();
  //     update();
  //   } else {}
  // }

  Future<String> registerNewInventory(InventoryModel inventory) async {
    Response response = await inventoryRepo.registerNewInventory(inventory.toJson());
    print(inventory.toJson());
    if (response.statusCode == 200) {
      return 'Estoque cadastrado com sucesso!';
    } else {
      return 'Erro ao cadastrar estoque!';
    }
  }

  Future<String> updateInfoInventory(int idInventory, String token, InventoryModel inventory) async {
    Response response = await inventoryRepo.updateInfoInventory(idInventory, token, inventory.toJson());
    print(inventory.toJson());
    if (response.statusCode == 200) {
      return 'Estoque atualizado com sucesso!';
    } else {
      return 'Erro ao atualizar estoque!';
    }
  }

  Future<String> deleteInventory(int idInventory, String token) async {
    Response response = await inventoryRepo.deleteInventory(idInventory, token);
    if (response.statusCode == 200) {
      return 'Estoque apagado com sucesso!';
    } else {
      return 'Erro ao apagar estoque!';
    }
  }

  Future<void> getInventoryDtoList(String token) async {
    Response response = await inventoryRepo.getInventoryList(token);
    if (response.statusCode == 200) {
      inventoryDtoList = response.body
          .map<InventoryDto>(
            (e) => InventoryDto.fromMap(e),
          )
          .toList();
      update();
    } else {}
  }
}
