import 'package:acme_store/models/lista_pedidos.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Indicator extends StatelessWidget {
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final int index;
  final Color textColor;

  const Indicator({
    Key? key,
    required this.color,
    required this.text,
    required this.isSquare,
    required this.index,
    this.size = 16,
    this.textColor = const Color.fromARGB(255, 132, 130, 130),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        ValueListenableBuilder(
          valueListenable: context.read<ListaPedidos>().indicadores[index],
          builder: (context, indicador, child) => SizedBox(
            width: 120,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                text,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: indicador ? Colors.black : textColor),
              ),
            ),
          ),
        )
      ],
    );
  }
}
