import 'dart:convert';

class LoginDTO {
  String login;
  String senha;
  LoginDTO({
    required this.login,
    required this.senha,
  });

  Map<String, dynamic> toMap() {
    return {'login': login, 'senha': senha};
  }

  factory LoginDTO.fromMap(Map<String, dynamic> map) {
    return LoginDTO(
      login: map['login'] ?? '',
      senha: map['senha'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginDTO.fromJson(String source) => LoginDTO.fromMap(json.decode(source));
}
