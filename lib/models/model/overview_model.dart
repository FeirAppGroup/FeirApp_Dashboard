import 'dart:convert';

class OverviewModel {
  int totalUsers;
  int totalProductors;
  int orderOpened;
  int orderClosed;

  OverviewModel({
    required this.totalUsers,
    required this.totalProductors,
    required this.orderOpened,
    required this.orderClosed,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'totalUsers': totalUsers});
    result.addAll({'totalProductors': totalProductors});
    result.addAll({'orderOpened': orderOpened});
    result.addAll({'orderClosed': orderClosed});

    return result;
  }

  factory OverviewModel.fromMap(Map<String, dynamic> map) {
    return OverviewModel(
      totalUsers: map['totalUsers']?.toInt() ?? 0,
      totalProductors: map['totalProductors']?.toInt() ?? 0,
      orderOpened: map['orderOpened']?.toInt() ?? 0,
      orderClosed: map['orderClosed']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory OverviewModel.fromJson(String source) => OverviewModel.fromMap(json.decode(source));
}
