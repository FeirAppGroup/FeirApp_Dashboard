import 'dart:convert';

class InventoryDto {
  int? id;
  int idProduto;
  int quantidade;
  int nomeProduto;

  InventoryDto({
    this.id,
    required this.idProduto,
    required this.quantidade,
    required this.nomeProduto,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    result.addAll({'idProduto': idProduto});
    result.addAll({'quantidade': quantidade});
    result.addAll({'nomeProduto': nomeProduto});

    return result;
  }

  factory InventoryDto.fromMap(Map<String, dynamic> map) {
    return InventoryDto(
      id: map['id']?.toInt(),
      idProduto: map['idProduto']?.toInt() ?? 0,
      quantidade: map['quantidade']?.toInt() ?? 0,
      nomeProduto: map['nomeProduto']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory InventoryDto.fromJson(String source) => InventoryDto.fromMap(json.decode(source));
}
