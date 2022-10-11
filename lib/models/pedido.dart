import 'dart:convert';

import 'package:acme_store/models/carrinho_item.dart';

class Pedido {
  final String id;
  final double total;
  final List<CarrinhoItem> produtos;
  final DateTime date;

  Pedido({
    required this.id,
    required this.total,
    required this.produtos,
    required this.date,
  });

  String tojson() {
    final Map<String, dynamic> dados = <String, dynamic>{};

    dados['total'] = total;
    dados['produtos'] = produtos.map((p) => p.toJson()).toList();
    dados['date'] = date.toIso8601String();

    return jsonEncode(dados);
  }
}
