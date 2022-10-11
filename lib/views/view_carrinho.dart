import 'dart:async';

import 'package:acme_store/components/carrinho_widget.dart';
import 'package:acme_store/models/carrinho.dart';
import 'package:acme_store/models/carrinho_item.dart';
import 'package:acme_store/models/lista_pedidos.dart';
import 'package:acme_store/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class ViewCarrinho extends StatelessWidget {
  const ViewCarrinho({super.key});

  @override
  Widget build(BuildContext context) {
    final carrinho = context.watch<Carrinho>();
    final items = carrinho.items.values.toList();
    final listaPedidos = context.read<ListaPedidos>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width > 700
                  ? 500
                  : MediaQuery.of(context).size.width,
              child: Card(
                margin: const EdgeInsets.all(25),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total',
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Text(
                        '${carrinho.totalAmount.toStringAsFixed(2)} reais',
                        style:
                            const TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      const Spacer(),
                      TextButton(
                          style: TextButton.styleFrom(
                              textStyle: TextStyle(
                                  color: Theme.of(context).primaryColor)),
                          onPressed: () {
                            if (carrinho.itemsCount == 0) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Carrinho vazio')));
                            } else {
                              listaPedidos.addPedido(carrinho);
                              var exibirJson = carrinho.carrinhoRecente();
                              var produtosCarrinho =
                                  exibirJson['produtos'] as List<CarrinhoItem>;
                              showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: ((context) => AlertDialog(
                                        title: const Text('Enviando Pedido'),
                                        content: SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.5,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: LoadingAnimationWidget
                                                    .inkDrop(
                                                        color: Colors.black,
                                                        size: 100),
                                              ),
                                              Expanded(
                                                child: SingleChildScrollView(
                                                  child: Column(
                                                    children: List<
                                                            Widget>.generate(
                                                        produtosCarrinho.length,
                                                        (index) => Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: FittedBox(
                                                                fit: BoxFit
                                                                    .scaleDown,
                                                                child: Text(
                                                                  '${produtosCarrinho[index].nome} - ${produtosCarrinho[index].quantidade}x',
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          20),
                                                                ),
                                                              ),
                                                            )),
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                  'Total: ${exibirJson['total']}',
                                                  style: const TextStyle(
                                                      fontSize: 20)),
                                              const SizedBox(
                                                height: 100,
                                              ),
                                            ],
                                          ),
                                        ),
                                      )));

                              Timer(const Duration(seconds: 3), () {
                                carrinho.limpar();
                                Navigator.of(context)
                                    .pushReplacementNamed(Rotas.PEDIDOS);
                              });
                            }
                          },
                          child: const Text(
                            'COMPRAR',
                            style: TextStyle(color: Colors.black),
                          ))
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width > 700
                    ? 500
                    : MediaQuery.of(context).size.width,
                child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) => CarrinhoItemWidget(
                          carrinhoItem: items[index],
                        )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
