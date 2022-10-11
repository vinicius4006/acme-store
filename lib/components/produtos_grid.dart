import 'package:acme_store/components/produto_grid_item.dart';
import 'package:acme_store/models/lista_produtos.dart';
import 'package:acme_store/models/produto.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class ProdutosGrid extends StatelessWidget {
  final bool mostrarSomenteFavoritos;
  final bool filtroAtivado;
  const ProdutosGrid(
      {super.key,
      required this.mostrarSomenteFavoritos,
      required this.filtroAtivado});

  @override
  Widget build(BuildContext context) {
    late final List<Produto> produtosCarregados;

    if (mostrarSomenteFavoritos) {
      var produtosCarregadosCopy =
          context.select((ListaProdutos lista) => lista.favoriteItems);
      if (filtroAtivado) {
        produtosCarregados = produtosCarregadosCopy
            .where((prod) => prod.nome.toLowerCase().contains(context
                .read<ListaProdutos>()
                .textEditingController
                .text
                .toLowerCase()))
            .toList();
      } else {
        produtosCarregados = produtosCarregadosCopy;
      }
    } else if (filtroAtivado) {
      produtosCarregados =
          context.select((ListaProdutos lista) => lista.itemsFiltrados);
    } else {
      produtosCarregados = context.select((ListaProdutos lista) => lista.items);
    }

    return produtosCarregados.isEmpty
        ? const Center(
            child: Text('Sem produtos'),
          )
        : GridView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: produtosCarregados.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: MediaQuery.of(context).size.width > 700 ? 5 : 2,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10),
            itemBuilder: (context, index) => ChangeNotifierProvider.value(
                  value: produtosCarregados[index],
                  child: const ProdutoGridItem(),
                ));
  }
}
