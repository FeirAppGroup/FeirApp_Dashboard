import 'package:dashboard_feirapp/models/model/product_model.dart';
import 'package:get/get.dart';

import 'package:dashboard_feirapp/data/repository/product_repo.dart';

class ProductController extends GetxController {
  final ProductRepo productRepo;

  ProductController({
    required this.productRepo,
  });

  List<ProductModel> _productsList = [];

  List<ProductModel> get productsList => _productsList;

  set productsList(List<ProductModel> productList) {
    _productsList = productList;
  }

  Future<void> getProductsList(String token) async {
    Response response = await productRepo.getProductsList(token);
    if (response.statusCode == 200) {
      _productsList = response.body
          .map<ProductModel>(
            (e) => ProductModel.fromMap(e),
          )
          .toList();
      update();
    } else {}
  }

  Future<ProductModel> getInfoProduct(int idProduct, String token) async {
    Response response = await productRepo.getInfoProduct(idProduct, token);
    if (response.statusCode == 200) {
      return ProductModel.fromMap(response.body);
    } else {
      return throw Exception('Erro ao buscar produto.');
    }
  }

  Future<String> registerNewProduct(ProductModel product) async {
    Response response = await productRepo.registerNewProduct(product.toJson());
    print(product.toJson());
    if (response.statusCode == 200) {
      return 'Produto cadastrado com sucesso!';
    } else {
      return 'Erro ao cadastrar produto!';
    }
  }

  Future<String> updateInfoProduct(int idProduct, String token, ProductModel product) async {
    Response response = await productRepo.updateInfoProduct(idProduct, token, product.toJson());
    print(product.toJson());
    if (response.statusCode == 200) {
      return 'Produto atualizado com sucesso!';
    } else {
      return 'Erro ao atualizar produto!';
    }
  }

  Future<String> deleteProduct(int idProduct, String token) async {
    Response response = await productRepo.deleteProduct(idProduct, token);
    if (response.statusCode == 200) {
      return 'Produto apagado com sucesso!';
    } else {
      return 'Erro ao apagar produto!';
    }
  }
}
