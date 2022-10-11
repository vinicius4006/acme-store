import 'package:acme_store/models/carrinho.dart';
import 'package:acme_store/models/lista_pedidos.dart';
import 'package:acme_store/models/lista_produtos.dart';
import 'package:acme_store/utils/app_routes.dart';
import 'package:acme_store/views/splash_screen.dart';
import 'package:acme_store/views/view_carrinho.dart';
import 'package:acme_store/views/view_dashboard.dart';
import 'package:acme_store/views/view_detalhes_produto.dart';
import 'package:acme_store/views/view_pedido.dart';
import 'package:acme_store/views/view_produtos.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ListaProdutos(),
        ),
        ChangeNotifierProvider(create: (_) => Carrinho()),
        ChangeNotifierProvider(create: (_) => ListaPedidos())
      ],
      child: MaterialApp(
        title: 'Loja Acme',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            colorScheme: const ColorScheme(
                brightness: Brightness.light,
                primary: Color(0xFFC9CBA3),
                onPrimary: Colors.black, //Color(0xFFFFE1A8),
                secondary: Color(0xFFE26D5C),
                onSecondary: Color(0xFF723D46),
                error: Color.fromARGB(255, 219, 59, 78),
                onError: Color.fromARGB(223, 222, 103, 116),
                background: Color(0xFFFFE1A8),
                onBackground: Color.fromARGB(255, 132, 89, 94),
                surface: Color.fromARGB(255, 245, 195, 102),
                onSurface: Color.fromARGB(255, 171, 150, 112)),
            fontFamily: 'Acme'),
        routes: {
          Rotas.SPLASH_SCREEN: (_) => const SplashScreen(),
          Rotas.PRODUTOS: (_) => const ViewProdutos(),
          Rotas.DETALHES_PRODUTO: (_) => const ViewDetalhesProduto(),
          Rotas.PEDIDOS: (_) => const ViewPedidos(),
          Rotas.CARRINHO: (_) => const ViewCarrinho(),
          Rotas.DASHBOARD: (_) => const Dashboard(),
        },
      ),
    );
  }
}
