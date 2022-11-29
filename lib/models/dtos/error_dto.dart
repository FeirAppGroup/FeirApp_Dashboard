import 'dart:convert';

class ErrorDTO {
  int status;
  String erro;
  List<String> erros;
  ErrorDTO({
    required this.status,
    required this.erro,
    required this.erros,
  });

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'erro': erro,
      'erros': erros,
    };
  }

  factory ErrorDTO.fromMap(Map<String, dynamic> map) {
    return ErrorDTO(
      status: map['status'] ?? 1,
      erro: map['erro'] ?? '',
      erros: List<String>.from(map['erros']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ErrorDTO.fromJson(String source) =>
      ErrorDTO.fromMap(json.decode(source));
}
