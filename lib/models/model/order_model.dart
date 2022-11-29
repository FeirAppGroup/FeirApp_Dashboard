import 'dart:convert';

import 'package:dashboard_feirapp/models/model/item_cart_model.dart';

import '../enum/forma_pagamento_enum.dart';
import '../enum/status_pedido_enum.dart';

class OrderModel {
  int? id;
  int idUsuario;
  String observacao;
  double valorTotal;
  DateTime? dataPedidoInicio;
  DateTime? dataPedidoAtualizado;
  StatusPedido? status;
  FormaPagamento formaPagamento;
  String enderecoEntrega;
  List<ItemCartModel> itemPedidos;

  OrderModel({
    this.id,
    required this.idUsuario,
    required this.observacao,
    required this.valorTotal,
    this.dataPedidoInicio,
    this.dataPedidoAtualizado,
    this.status,
    required this.formaPagamento,
    required this.enderecoEntrega,
    required this.itemPedidos,
  });

  Map<String, dynamic> toMap() {
    return {
      'idUsuario': idUsuario,
      'observacao': observacao,
      'valorTotal': valorTotal.toStringAsFixed(2),
      'formaPagamento': formaPagamento.index,
      'enderecoEntrega': enderecoEntrega,
      'itemPedidos': itemPedidos.map((x) => x.toMap()).toList(),
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    int valStatus = map['status'];
    int valFormaPgto = map['formaPagamento'];
    return OrderModel(
      id: map['id']?.toInt() ?? 0,
      idUsuario: map['idUsuario']?.toInt() ?? 0,
      observacao: map['observacao'] ?? '',
      valorTotal: map['valorTotal']?.toDouble() ?? 0.0,
      dataPedidoInicio: DateTime.parse(map['dataPedidoInicio']),
      dataPedidoAtualizado: DateTime.parse(map['dataPedidoAtualizado']),
      status: StatusPedido.values[valStatus],
      formaPagamento: FormaPagamento.values[valFormaPgto],
      enderecoEntrega: map['enderecoEntrega'] ?? '',
      itemPedidos: List<ItemCartModel>.from(
        map['itemPedidos']?.map(
          (e) => ItemCartModel.fromMap(e),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) => OrderModel.fromMap(json.decode(source));
}
