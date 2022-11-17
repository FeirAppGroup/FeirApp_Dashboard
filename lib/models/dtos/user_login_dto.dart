import 'dart:convert';

class UserLoginDto {
  int id;
  String email;
  String nome;
  String token;
  UserLoginDto({
    required this.id,
    required this.email,
    required this.nome,
    required this.token,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'nome': nome,
      'token': token,
    };
  }

  factory UserLoginDto.fromMap(Map<String, dynamic> map) {
    return UserLoginDto(
      id: map['id']?.toInt() ?? 0,
      email: map['email'] ?? '',
      nome: map['nome'] ?? '',
      token: map['token'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserLoginDto.fromJson(String source) => UserLoginDto.fromMap(json.decode(source));
}
