import 'package:acme_store/components/app_drawer.dart';
import 'package:acme_store/components/app_pedido.dart';
import 'package:acme_store/components/carrinho_app.dart';
import 'package:acme_store/models/lista_pedidos.dart';
import 'package:acme_store/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class ViewPedidos extends StatelessWidget {
  const ViewPedidos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Pedidos'),
        actions: [
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
      body: Center(
        child: FutureBuilder(
            future: context.read<ListaPedidos>().carregarPedidos(),
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: LoadingAnimationWidget.fourRotatingDots(
                      color: Theme.of(context).colorScheme.primary, size: 200),
                );
              } else if (snapshot.error != null) {
                return const Center(
                  child: Text('Ocorreu um erro'),
                );
              } else {
                return Consumer<ListaPedidos>(
                    builder: (context, pedidos, _) => pedidos.items.isEmpty
                        ? const Center(
                            child: Text('Sem Pedidos'),
                          )
                        : Container(
                            margin: EdgeInsets.only(top: 15),
                            width: MediaQuery.of(context).size.width > 700
                                ? 500
                                : MediaQuery.of(context).size.width,
                            child: ListView.builder(
                                itemCount: pedidos.itemsCount,
                                itemBuilder: (context, index) => Column(
                                      children: [
                                        PedidoApp(pedido: pedidos.items[index]),
                                      ],
                                    )),
                          ));
              }
            })),
      ),
    );
  }
}
