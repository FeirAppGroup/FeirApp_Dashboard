import 'dart:convert';

class ProductModel {
  int? id;
  int idPropriedade;
  String nome;
  String categoria;
  String descricao;
  bool organico;
  String urlFoto;
  double valor;
  bool oferta;
  DateTime dataValidade;

  ProductModel({
    this.id,
    required this.idPropriedade,
    required this.nome,
    required this.categoria,
    required this.descricao,
    required this.organico,
    required this.urlFoto,
    required this.valor,
    required this.oferta,
    required this.dataValidade,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    result.addAll({'idPropriedade': idPropriedade});
    result.addAll({'nome': nome});
    result.addAll({'categoria': categoria});
    result.addAll({'descricao': descricao});
    result.addAll({'organico': organico});
    result.addAll({'urlFoto': urlFoto});
    result.addAll({'valor': valor});
    result.addAll({'oferta': oferta});
    result.addAll({'dataValidade': dataValidade.toString()});

    return result;
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id']?.toInt(),
      idPropriedade: map['idPropriedade']?.toInt() ?? 0,
      nome: map['nome'] ?? '',
      categoria: map['categoria'] ?? '',
      descricao: map['descricao'] ?? '',
      organico: map['organico'] ?? false,
      urlFoto: map['urlFoto'] ?? '',
      valor: map['valor']?.toDouble() ?? 0.0,
      oferta: map['oferta'] ?? false,
      dataValidade: DateTime.parse(map['dataValidade']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) => ProductModel.fromMap(json.decode(source));
}
