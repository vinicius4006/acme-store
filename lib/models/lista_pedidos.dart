import 'dart:convert';

import 'package:acme_store/models/carrinho.dart';
import 'package:acme_store/models/carrinho_item.dart';
import 'package:acme_store/models/pedido.dart';
import 'package:acme_store/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ListaPedidos with ChangeNotifier {
  List<Pedido> _items = [];

  List<Pedido> get items => [..._items];

  int get itemsCount => _items.length;

  final List<CarrinhoItem> _produtosPedido = [];

  List<CarrinhoItem> get produtosPedido => [..._produtosPedido];

  double _somaDosPedidos = 0;
  double get somaDosPedidos => _somaDosPedidos;

  List<ValueNotifier<bool>> indicadores = [];

  Future<void> carregarPedidos() async {
    List<Pedido> items = [];
    _produtosPedido.clear();
    _somaDosPedidos = 0;

    final response =
        await http.get(Uri.parse('${Constants.PEDIDOS_BASE_URL}.json'));
    Map<String, dynamic> data = jsonDecode(response.body) ?? {};
    if (data != {}) {
      data.forEach((pedidoId, pedidoData) {
        items.add(Pedido(
            id: pedidoId,
            total: pedidoData['total'],
            produtos: (pedidoData['produtos'] as List).map((p) {
              var item = CarrinhoItem(
                  id: jsonDecode(p)['id'],
                  nome: jsonDecode(p)['nome'],
                  valorUnitario: jsonDecode(p)['valor_unitario'] * 1.0,
                  produtoId: jsonDecode(p)['produto_id'],
                  quantidade: jsonDecode(p)['quantidade']);
              _filtrarPedidos(item);

              return item;
            }).toList(),
            date: DateTime.parse(pedidoData['date'])));
        _somaDosPedidos = items.last.total + _somaDosPedidos;
      });
    }
    _items = items.reversed.toList();

    notifyListeners();
  }

  void ativarIndicador(int index) {
    if (index != -1) {
      for (var element in indicadores) {
        element.value = false;
      }
      indicadores[index].value = true;
    }
  }

  void _filtrarPedidos(CarrinhoItem item) {
    var lista =
        _produtosPedido.where((pedido) => pedido.nome == item.nome).toList();
    if (lista.isNotEmpty) {
      _produtosPedido.removeWhere((prod) => prod.nome == item.nome);
      _produtosPedido.add(CarrinhoItem(
          id: item.id,
          nome: item.nome,
          valorUnitario: item.valorUnitario,
          produtoId: item.produtoId,
          quantidade: lista.last.quantidade + item.quantidade));
    } else {
      _produtosPedido.add(item);
    }
    indicadores.add(ValueNotifier(false));
  }

  Future<void> addPedido(Carrinho carrinho) async {
    final response = await http.post(
        Uri.parse('${Constants.PEDIDOS_BASE_URL}.json'),
        body: carrinho.toJson());
    final id = jsonDecode(response.body)['name'];

    _items.insert(
        0,
        Pedido(
            id: id,
            total: carrinho.totalAmount,
            produtos: carrinho.items.values.toList(),
            date: carrinho.date));

    notifyListeners();
  }
}
