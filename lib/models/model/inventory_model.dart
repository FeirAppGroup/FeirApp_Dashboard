import 'dart:convert';

class InventoryModel {
  int? id;
  int idProduto;
  int quantidade;

  InventoryModel({
    this.id,
    required this.idProduto,
    required this.quantidade,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    result.addAll({'idProduto': idProduto});
    result.addAll({'quantidade': quantidade});

    return result;
  }

  factory InventoryModel.fromMap(Map<String, dynamic> map) {
    return InventoryModel(
      id: map['id']?.toInt(),
      idProduto: map['idProduto']?.toInt() ?? 0,
      quantidade: map['quantidade']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory InventoryModel.fromJson(String source) => InventoryModel.fromMap(json.decode(source));
}
