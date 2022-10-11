import 'package:acme_store/components/carrinho_app.dart';
import 'package:acme_store/models/carrinho.dart';
import 'package:acme_store/models/produto.dart';
import 'package:acme_store/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewDetalhesProduto extends StatefulWidget {
  const ViewDetalhesProduto({super.key});

  @override
  State<ViewDetalhesProduto> createState() => _ViewDetalhesProdutoState();
}

class _ViewDetalhesProdutoState extends State<ViewDetalhesProduto> {
  @override
  Widget build(BuildContext context) {
    final carrinho = context.read<Carrinho>();
    final Produto produto =
        ModalRoute.of(context)!.settings.arguments as Produto;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.black87, shape: BoxShape.circle),
                  child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ))),
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(produto.nome),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Hero(
                      tag: produto.id,
                      child: Image.network(
                        MediaQuery.of(context).size.width > 700
                            ? produto.imagemUrl
                                .replaceAll('/600/900', '/2000/3000')
                            : produto.imagemUrl,
                        fit: BoxFit.cover,
                      )),
                  const DecoratedBox(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment(0, 0.8),
                              end: Alignment(0, 0),
                              colors: [
                        Color.fromARGB(153, 105, 80, 8),
                        Color.fromRGBO(0, 0, 0, 0)
                      ]))),
                ],
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'R\$ ${produto.valorUnitario.toStringAsFixed(2)} reais',
                    style:
                        const TextStyle(fontSize: 30, fontFamily: 'Montserrat'),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Row(
                    children: [
                      IconButton(
                          color: Theme.of(context).colorScheme.error,
                          onPressed: () {
                            produto.mudarFavorito();
                            setState(() {});
                          },
                          icon: Icon(produto.isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border)),
                      CarrinhoApp(
                          child: IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, Rotas.CARRINHO);
                        },
                        icon: const Icon(Icons.shopping_cart),
                      ))
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(
                  MediaQuery.of(context).size.width > 700 ? 80 : 20),
              child: Text(
                textAlign: TextAlign.center,
                produto.descricao,
                style: const TextStyle(fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: SizedBox(
                  width: 200,
                  height: 50,
                  child: AspectRatio(
                    aspectRatio: 2 / 3,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      )),
                      icon: const Icon(Icons.shopping_basket),
                      label: const Text('ADICIONAR'),
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
                    ),
                  ),
                ),
              ),
            )
          ]))
        ],
      ),
    );
  }
}
