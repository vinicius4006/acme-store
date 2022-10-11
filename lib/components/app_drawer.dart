import 'package:acme_store/utils/app_routes.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text(
              'Bem vindo a ACME',
              style: TextStyle(fontFamily: 'Montserrat'),
            ),
            automaticallyImplyLeading: false,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.data_saver_off),
            title: const Text(
              'Dashboard',
              style: TextStyle(fontFamily: 'Montserrat'),
            ),
            onTap: () =>
                Navigator.of(context).pushReplacementNamed(Rotas.DASHBOARD),
          ),
          ListTile(
            leading: const Icon(Icons.stream),
            title: const Text(
              'Produtos',
              style: TextStyle(fontFamily: 'Montserrat'),
            ),
            onTap: () =>
                Navigator.of(context).pushReplacementNamed(Rotas.PRODUTOS),
          ),
          ListTile(
            leading: const Icon(Icons.shopping_bag),
            title: const Text(
              'Pedidos',
              style: TextStyle(fontFamily: 'Montserrat'),
            ),
            onTap: () =>
                Navigator.of(context).pushReplacementNamed(Rotas.PEDIDOS),
          )
        ],
      ),
    );
  }
}
