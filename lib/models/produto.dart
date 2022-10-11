import 'dart:math';

import 'package:acme_store/data/limites.dart';
import 'package:acme_store/models/produto_base.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Produto extends ProdutoBase with ChangeNotifier {
  late final String descricao, imagemUrl;
  bool isFavorite = false;

  Produto({
    required super.id,
    required super.nome,
    required super.valorUnitario,
    required this.descricao,
    required this.imagemUrl,
    this.isFavorite = false,
  });

  void _mudarFavorito() {
    isFavorite = !isFavorite;
    notifyListeners();
  }

  void mudarFavorito() {
    _mudarFavorito();
  }

  static String _gerarTextRandomico() {
    late final String texto;
    bool go = true;

    while (go) {
      int inicio = Random().nextInt(textoRandomico.length);
      int fim = Random().nextInt(textoRandomico.length);
      if (fim - inicio >= 20 && fim - inicio <= 500) {
        texto = textoRandomico.substring(inicio, fim);
        go = false;
      }
    }
    return texto;
  }

  static double retornarValorUnitario(String nomeProduto, String desc) {
    double valor = (10 +
        nomeProduto.length * ((500 - desc.length) / (4 - nomeProduto.length)));
    if (valor < 0) {
      valor = valor * -1;
    }
    return valor;
  }

  static Produto fromJson(Map<String, dynamic> json, String nomeProduto) {
    String desc = Produto._gerarTextRandomico();

    return Produto(
        id: json['id'],
        nome: nomeProduto,
        valorUnitario: retornarValorUnitario(nomeProduto, desc),
        descricao: desc,
        imagemUrl: "https://picsum.photos/id/${json['id']}/600/900");
  }
}
