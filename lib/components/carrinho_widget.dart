import 'package:acme_store/models/carrinho.dart';
import 'package:acme_store/models/carrinho_item.dart';
import 'package:acme_store/models/produto.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CarrinhoItemWidget extends StatelessWidget {
  final CarrinhoItem carrinhoItem;
  const CarrinhoItemWidget({super.key, required this.carrinhoItem});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
        background: Container(
          color: Theme.of(context).errorColor,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 20),
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
          child: const Icon(
            Icons.delete,
            color: Colors.white,
            size: 40,
          ),
        ),
        secondaryBackground: Container(
          color: Theme.of(context).colorScheme.primary,
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20),
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 40,
          ),
        ),
        confirmDismiss: (direction) {
          if (direction == DismissDirection.startToEnd) {
            if (carrinhoItem.quantidade == 1) {
              return showDialog<bool>(
                  context: context,
                  builder: (ctx) {
                    return AlertDialog(
                      title: const Text('Tem certeza?'),
                      content: Text(
                          'Quer remover a ${carrinhoItem.nome} do carrinho?'),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context, false);
                            },
                            child: const Text('Não')),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context, true);
                            },
                            child: const Text('Sim'))
                      ],
                    );
                  });
            } else {
              context.read<Carrinho>().removerUnicoItem(carrinhoItem.produtoId);
              return Future.value(false);
            }
          } else {
            context.read<Carrinho>().addItem(Produto(
                id: carrinhoItem.produtoId,
                nome: carrinhoItem.nome,
                valorUnitario: carrinhoItem.valorUnitario,
                descricao: '',
                imagemUrl: ''));
            return Future.value(false);
          }
        },
        onDismissed: (direction) {
          if (direction == DismissDirection.endToStart) {
            context.read<Carrinho>().removerItem(carrinhoItem.produtoId);
          }
        },
        key: ValueKey(carrinhoItem.produtoId),
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.black87,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: FittedBox(
                    child: Text(
                      carrinhoItem.valorUnitario.toStringAsFixed(2),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              title: Text(carrinhoItem.nome),
              subtitle: Text(
                  'Total: ${(carrinhoItem.quantidade * carrinhoItem.valorUnitario).toStringAsFixed(2)} reais'),
              trailing: Text('${carrinhoItem.quantidade}x'),
            ),
          ),
        ));
  }
}
