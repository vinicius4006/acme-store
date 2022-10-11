import 'dart:convert';
import 'dart:math';

import 'package:acme_store/models/carrinho_item.dart';
import 'package:acme_store/models/produto.dart';
import 'package:flutter/cupertino.dart';

class Carrinho with ChangeNotifier {
  Map<String, CarrinhoItem> _items = {};
  Map<String, CarrinhoItem> get items {
    return {..._items};
  }

  int get itemsCount {
    return _items.length;
  }

  DateTime get date => DateTime.now();

  double get totalAmount {
    double total = 0;

    _items.forEach((key, carrinhoItem) {
      total += carrinhoItem.valorUnitario * carrinhoItem.quantidade;
    });
    return total;
  }

  void addItem(Produto produto) {
    if (_items.containsKey(produto.id)) {
      _items.update(
          produto.id,
          (itemReal) => CarrinhoItem(
              id: itemReal.id,
              nome: itemReal.nome,
              valorUnitario: itemReal.valorUnitario,
              produtoId: itemReal.produtoId,
              quantidade: itemReal.quantidade + 1));
    } else {
      _items.putIfAbsent(
          produto.id,
          () => CarrinhoItem(
              id: Random().nextDouble().toString(),
              nome: produto.nome,
              valorUnitario: produto.valorUnitario,
              produtoId: produto.id,
              quantidade: 1));
    }
    notifyListeners();
  }

  void removerItem(String produtoId) {
    _items.remove(produtoId);
    notifyListeners();
  }

  void removerUnicoItem(String produtoId) {
    if (!_items.containsKey(produtoId)) {
      return;
    }

    if (_items[produtoId]?.quantidade == 1) {
      _items.remove(produtoId);
    } else {
      _items.update(
          produtoId,
          (itemReal) => CarrinhoItem(
              id: itemReal.id,
              nome: itemReal.nome,
              valorUnitario: itemReal.valorUnitario,
              produtoId: itemReal.produtoId,
              quantidade: itemReal.quantidade - 1));
    }
    notifyListeners();
  }

  void limpar() {
    _items = {};
    notifyListeners();
  }

  String toJson() {
    final Map<String, dynamic> dados = <String, dynamic>{};

    dados['total'] = totalAmount;
    dados['date'] = date.toIso8601String();
    dados['produtos'] = _items.values.map((p) => p.toJson()).toList();

    return jsonEncode(dados);
  }

  Map<String, dynamic> carrinhoRecente() {
    final Map<String, dynamic> dados = <String, dynamic>{};
    dados['total'] = totalAmount.toStringAsFixed(2);
    dados['produtos'] = _items.values.map((p) => p).toList();

    return dados;
  }
}
