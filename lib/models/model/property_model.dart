import 'dart:convert';

import 'product_model.dart';

class PropertyModel {
  int? id;
  int idUsuario;
  String matricula;
  String nome;
  String endereco;
  String localizacao;
  double tamanho;
  int quantidadeTrabalhador;
  String uriFoto;
  List<ProductModel>? produtos;

  PropertyModel({
    this.id,
    required this.idUsuario,
    required this.matricula,
    required this.nome,
    required this.endereco,
    required this.localizacao,
    required this.tamanho,
    required this.quantidadeTrabalhador,
    required this.uriFoto,
    this.produtos,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    result.addAll({'idUsuario': idUsuario});
    result.addAll({'matricula': matricula});
    result.addAll({'nome': nome});
    result.addAll({'endereco': endereco});
    result.addAll({'localizacao': localizacao});
    result.addAll({'tamanho': tamanho});
    result.addAll({'quantidadeTrabalhador': quantidadeTrabalhador});
    result.addAll({'uriFoto': uriFoto});
    if (produtos != null) {
      result.addAll({'produtos': produtos!.map((x) => x.toMap()).toList()});
    }

    return result;
  }

  factory PropertyModel.fromMap(Map<String, dynamic> map) {
    return PropertyModel(
      id: map['id']?.toInt(),
      idUsuario: map['idUsuario']?.toInt() ?? 0,
      matricula: map['matricula'] ?? '',
      nome: map['nome'] ?? '',
      endereco: map['endereco'] ?? '',
      localizacao: map['localizacao'] ?? '',
      tamanho: map['tamanho']?.toDouble() ?? 0.0,
      quantidadeTrabalhador: map['quantidadeTrabalhador']?.toInt() ?? 0,
      uriFoto: map['uriFoto'] ?? '',
      produtos: map['produtos'] != null
          ? List<ProductModel>.from(map['produtos']?.map((x) => ProductModel.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PropertyModel.fromJson(String source) => PropertyModel.fromMap(json.decode(source));
}
