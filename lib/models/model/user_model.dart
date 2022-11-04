import 'dart:convert';

import 'package:dashboard_feirapp/models/enum/type_user_enum.dart';

class UserModel {
  int? id;
  String nome;
  String telefone;
  String email;
  String cep;
  String senha;
  String cpf;
  String cnpj;
  String dap;
  int tipo;

  UserModel({
    this.id,
    required this.nome,
    required this.telefone,
    required this.email,
    required this.cep,
    required this.senha,
    required this.cpf,
    required this.cnpj,
    required this.dap,
    required this.tipo,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    result.addAll({'nome': nome});
    result.addAll({'telefone': telefone});
    result.addAll({'email': email});
    result.addAll({'cep': cep});
    result.addAll({'senha': senha});
    result.addAll({'cpf': cpf});
    result.addAll({'cnpj': cnpj});
    result.addAll({'dap': dap});
    result.addAll({'tipoUsuario': tipo});

    return result;
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    int val = map['tipo'];
    return UserModel(
      id: map['id']?.toInt(),
      nome: map['nome'] ?? '',
      telefone: map['telefone'] ?? '',
      email: map['email'] ?? '',
      cep: map['cep'] ?? '',
      senha: map['senha'] ?? '',
      cpf: map['cpf'] ?? '',
      cnpj: map['cnpj'] ?? '',
      dap: map['dap'] ?? '',
      tipo: map['tipo']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));
}
