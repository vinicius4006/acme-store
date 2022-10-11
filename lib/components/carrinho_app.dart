import 'package:acme_store/models/carrinho.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CarrinhoApp extends StatelessWidget {
  final Widget child;

  final Color? color;

  const CarrinhoApp({super.key, required this.child, this.color});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        child,
        Positioned(
          right: MediaQuery.of(context).size.width > 700 ? 2 : 8,
          top: MediaQuery.of(context).size.width > 700 ? 2 : 8,
          child: Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: color ?? Theme.of(context).errorColor,
            ),
            constraints: const BoxConstraints(minHeight: 16, minWidth: 16),
            child: Consumer<Carrinho>(
                builder: (context, carrinho, child) => Text(
                      carrinho.itemsCount.toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 10),
                    )),
          ),
        )
      ],
    );
  }
}
