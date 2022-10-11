import 'dart:async';

import 'package:acme_store/components/app_drawer.dart';
import 'package:acme_store/components/carrinho_app.dart';
import 'package:acme_store/components/produtos_grid.dart';
import 'package:acme_store/models/lista_produtos.dart';
import 'package:acme_store/utils/app_routes.dart';
import 'package:flutter/material.dart';
// ignore: unnecessary_import
import 'package:flutter/cupertino.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

// ignore: constant_identifier_names
enum FilterOptions { Favorito, Todos }

class ViewProdutos extends StatefulWidget {
  const ViewProdutos({super.key});

  @override
  State<ViewProdutos> createState() => _ViewProdutosState();
}

class _ViewProdutosState extends State<ViewProdutos> {
  bool _mostrarSomenteFavoritos = false;
  bool _filtroAtivado = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 2), () {
      setState(() => _isLoading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Loja ACME'),
          actions: [
            PopupMenuButton(
              icon: const Icon(Icons.more_vert),
              itemBuilder: (_) => [
                const PopupMenuItem(
                    value: FilterOptions.Favorito,
                    child: Text('Somente Favoritos')),
                const PopupMenuItem(
                    value: FilterOptions.Todos, child: Text('Todos'))
              ],
              onSelected: (FilterOptions opcao) {
                if (opcao == FilterOptions.Favorito) {
                  setState(() => _mostrarSomenteFavoritos = true);
                } else {
                  _filtroAtivado = false;

                  setState(() => _mostrarSomenteFavoritos = false);
                }
              },
            ),
            CarrinhoApp(
                child: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, Rotas.CARRINHO);
              },
              icon: const Icon(Icons.shopping_cart),
            ))
          ],
        ),
        drawer: const AppDrawer(),
        body: _isLoading
            ? Center(
                child: Center(
                  child: LoadingAnimationWidget.fourRotatingDots(
                      color: Theme.of(context).colorScheme.primary, size: 200),
                ),
              )
            : Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller:
                          context.read<ListaProdutos>().textEditingController,
                      onSubmitted: (value) {
                        if (value.isEmpty) {
                          setState(() => _filtroAtivado = false);
                        } else {
                          setState(() => _filtroAtivado = true);
                        }
                      },
                      decoration: const InputDecoration(
                        labelText: 'Pesquisar',
                        suffixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                      child: Center(
                    child: ProdutosGrid(
                        mostrarSomenteFavoritos: _mostrarSomenteFavoritos,
                        filtroAtivado: _filtroAtivado),
                  ))
                ],
              ));
  }
}
