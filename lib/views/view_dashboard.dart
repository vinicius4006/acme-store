import 'package:acme_store/components/app_drawer.dart';
import 'package:acme_store/components/carrinho_app.dart';
import 'package:acme_store/components/pie_produto_comprados.dart';
import 'package:acme_store/components/pie_quantidade_valor.dart';
import 'package:acme_store/utils/app_routes.dart';

import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const AppDrawer(),
        appBar: AppBar(
          title: const Text('Análise dos Pedidos'),
          centerTitle: true,
          bottom: TabBar(
              controller: _tabController,
              indicatorColor: Colors.black,
              tabs: const [
                Tab(
                  child: Text(
                    'Quantidade X Comprados',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Colors.black,
                        fontSize: 12),
                  ),
                ),
                Tab(
                  child: Text(
                    'Pedidos X Total',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Colors.black,
                        fontSize: 12),
                  ),
                )
              ]),
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
        body: TabBarView(
          controller: _tabController,
          children: const [PieCompradosQuantidade(), PieQuantidadeValor()],
        ));
  }
}
