import 'dart:convert';

import 'package:acme_store/models/produto_base.dart';

class CarrinhoItem extends ProdutoBase {
  final String produtoId;
  final int quantidade;

  CarrinhoItem({
    required super.id,
    required super.nome,
    required super.valorUnitario,
    required this.produtoId,
    required this.quantidade,
  });

  String toJson() {
    final Map<String, dynamic> dados = <String, dynamic>{};
    dados['id'] = id;
    dados['produto_id'] = produtoId;
    dados['nome'] = nome;
    dados['quantidade'] = quantidade;
    dados['valor_unitario'] = valorUnitario;

    return jsonEncode(dados);
  }
}
