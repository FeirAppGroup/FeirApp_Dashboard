import 'dart:convert';

class UserEditDto {
  int? id;
  String nome;
  String telefone;
  String? _email;

  String? get email => _email;

  set email(String? email) {
    _email = email;
  }

  String cep;
  String? _cpf;

  String? get cpf => _cpf;

  set cpf(String? cpf) {
    _cpf = cpf;
  }

  String cnpj;
  String? _dap;

  String? get dap => _dap;

  set dap(String? dap) {
    _dap = dap;
  }

  int tipo;

  UserEditDto({
    this.id,
    required this.nome,
    required this.telefone,
    required this.cep,
    required this.cnpj,
    required this.tipo,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    result.addAll({'nome': nome});
    result.addAll({'telefone': telefone});
    if (_email != null) {
      result.addAll({'_email': _email});
    }
    result.addAll({'cep': cep});
    if (_cpf != null) {
      result.addAll({'_cpf': _cpf});
    }
    result.addAll({'cnpj': cnpj});
    if (_dap != null) {
      result.addAll({'_dap': _dap});
    }
    result.addAll({'tipo': tipo});

    return result;
  }

  factory UserEditDto.fromMap(Map<String, dynamic> map) {
    return UserEditDto(
      id: map['id']?.toInt(),
      nome: map['nome'] ?? '',
      telefone: map['telefone'] ?? '',
      cep: map['cep'] ?? '',
      cnpj: map['cnpj'] ?? '',
      tipo: map['tipo']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserEditDto.fromJson(String source) => UserEditDto.fromMap(json.decode(source));
}
