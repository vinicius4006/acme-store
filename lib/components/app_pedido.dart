import 'package:acme_store/models/pedido.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PedidoApp extends StatefulWidget {
  final Pedido pedido;
  const PedidoApp({super.key, required this.pedido});

  @override
  State<PedidoApp> createState() => _PedidoAppState();
}

class _PedidoAppState extends State<PedidoApp> {
  bool _expanded = false;
  @override
  Widget build(BuildContext context) {
    final itemsAltura = (widget.pedido.produtos.length * 24.0 * 2) + 10;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: _expanded ? itemsAltura + 80 : 80,
      child: Card(
        child: Column(
          children: [
            ListTile(
              title:
                  Text('R\$ ${widget.pedido.total.toStringAsFixed(2)} reais'),
              subtitle:
                  Text(DateFormat('dd/MM/yyyy').format(widget.pedido.date)),
              trailing: IconButton(
                  onPressed: () {
                    setState(() => _expanded = !_expanded);
                  },
                  icon: const Icon(Icons.expand_circle_down_outlined)),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: _expanded ? itemsAltura : 0,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              child: ListView(
                children: widget.pedido.produtos.map((produto) {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            produto.nome,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '${produto.quantidade}x ${produto.valorUnitario.toStringAsFixed(2)} reais',
                            style: const TextStyle(
                                fontSize: 18, color: Colors.grey),
                          ),
                        ],
                      ),
                      const Divider(
                        color: Colors.black,
                        height: 20,
                      )
                    ],
                  );
                }).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
