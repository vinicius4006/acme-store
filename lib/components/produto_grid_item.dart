import 'package:acme_store/models/carrinho.dart';
import 'package:acme_store/models/produto.dart';
import 'package:acme_store/utils/app_routes.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class ProdutoGridItem extends StatelessWidget {
  const ProdutoGridItem({super.key});

  @override
  Widget build(BuildContext context) {
    final carrinho = context.read<Carrinho>();
    debugPrint('BuildProdutoGridItem');
    return Consumer<Produto>(builder: (context, produto, child) {
      return Hero(
          tag: produto..id,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: GridTile(
                footer: GridTileBar(
                  backgroundColor: Colors.black87,
                  leading: IconButton(
                      color: Theme.of(context).colorScheme.error,
                      onPressed: () {
                        produto.mudarFavorito();
                      },
                      icon: Icon(produto.isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border)),
                  title: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      MediaQuery.of(context).size.width > 700
                          ? produto.nome
                          : produto.nome.split(' ').join('\n'),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  trailing: IconButton(
                      color: Theme.of(context).errorColor,
                      onPressed: () {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('${produto.nome} no carrinho'),
                          duration: const Duration(seconds: 2),
                          action: SnackBarAction(
                            label: 'DESFAZER',
                            textColor: Colors.white,
                            onPressed: () {
                              debugPrint('${carrinho.items.values}');
                              carrinho.removerUnicoItem(produto.id);
                              debugPrint('${carrinho.items.values}');
                            },
                          ),
                        ));
                        carrinho.addItem(produto);
                      },
                      icon: const Icon(Icons.shopping_cart)),
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, Rotas.DETALHES_PRODUTO,
                        arguments: produto);
                  },
                  child: FadeInImage(
                    placeholder: const AssetImage('assets/images/example.png'),
                    image: NetworkImage(produto.imagemUrl),
                    fit: BoxFit.cover,
                  ),
                )),
          ));
    });
  }
}
