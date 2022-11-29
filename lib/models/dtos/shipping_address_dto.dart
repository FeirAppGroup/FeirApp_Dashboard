import 'dart:convert';

class ShippingAddressDto {
  String name;
  String street;
  String number;
  String district;
  bool isSelect;
  ShippingAddressDto({
    required this.name,
    required this.street,
    required this.number,
    required this.district,
    required this.isSelect,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'street': street,
      'number': number,
      'district': district,
      'isSelect': isSelect,
    };
  }

  factory ShippingAddressDto.fromMap(Map<String, dynamic> map) {
    return ShippingAddressDto(
      name: map['name'] ?? '',
      street: map['street'] ?? '',
      number: map['number'] ?? '',
      district: map['district'] ?? '',
      isSelect: map['isSelect'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory ShippingAddressDto.fromJson(String source) =>
      ShippingAddressDto.fromMap(json.decode(source));
}
