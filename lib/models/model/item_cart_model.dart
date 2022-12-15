import 'dart:convert';

import 'package:dashboard_feirapp/models/model/product_model.dart';

class ItemCartModel {
  int? id;
  int idProduto;
  double valorItem;
  double quantidadePeso;
  int pedidoId;
  ProductModel produto;
  ItemCartModel({
    this.id,
    required this.idProduto,
    required this.valorItem,
    required this.quantidadePeso,
    required this.pedidoId,
    required this.produto,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'idProduto': idProduto,
      'valorItem': valorItem,
      'quantidadePeso': quantidadePeso,
      'pedidoId': pedidoId,
      'produto': produto.toMap(),
    };
  }

  factory ItemCartModel.fromMap(Map<String, dynamic> map) {
    return ItemCartModel(
      id: map['id']?.toInt() ?? 0,
      idProduto: map['idProduto']?.toInt() ?? 0,
      valorItem: map['valorItem']?.toDouble() ?? 0.0,
      quantidadePeso: map['quantidadePeso']?.toDouble() ?? 0.0,
      pedidoId: map['pedidoId']?.toInt() ?? 0,
      produto: ProductModel.fromMap(map['produto']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemCartModel.fromJson(String source) => ItemCartModel.fromMap(json.decode(source));
}
