import 'dart:convert';
import 'dart:math';

import 'package:acme_store/data/limites.dart';
import 'package:acme_store/models/produto.dart';
import 'package:acme_store/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ListaProdutos with ChangeNotifier {
  final List<Produto> _items = [];
  final TextEditingController textEditingController = TextEditingController();

  List<Produto> get items => [..._items];
  List<Produto> get favoriteItems =>
      [..._items].where((produto) => produto.isFavorite).toList();

  List<Produto> get itemsFiltrados => [..._items]
      .where((produto) => produto.nome
          .toLowerCase()
          .contains(textEditingController.text.toLowerCase()))
      .toList();

  int get itemsCount => _items.length;

  Future<void> carregarProdutos() async {
    _items.clear();

    final response = await http.get(Uri.parse(Constants.imagemRandom('30')));
    var data = jsonDecode(response.body) ?? {};
    if (data != {}) {
      for (var produtoData in data) {
        int count = Random().nextInt(adjetivosPermitidos.length);
        int countExtra = 0;
        if (!verbosPermitidos.asMap().containsKey(count)) {
          countExtra = count;
          count = verbosPermitidos.length - 1;
        }
        _items.add(Produto.fromJson(produtoData,
            '${verbosPermitidos[count]} ${adjetivosPermitidos[countExtra == 0 ? count : countExtra]}'));
        verbosPermitidos.removeAt(count);
        adjetivosPermitidos.removeAt(countExtra == 0 ? count : countExtra);
      }
    }
    notifyListeners();
  }
}
