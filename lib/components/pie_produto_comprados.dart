import 'dart:math';

import 'package:acme_store/components/indicator.dart';
import 'package:acme_store/models/lista_pedidos.dart';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class PieCompradosQuantidade extends StatefulWidget {
  const PieCompradosQuantidade({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => PieCompradosQuantidadeState();
}

class PieCompradosQuantidadeState extends State {
  List<int> cores = [];
  int _geradorDeCor() {
    int valor = int.parse('0xff'
        '${Random().nextInt(899999) + 100000}');
    cores.add(valor);
    return cores.last;
  }

  @override
  void initState() {
    super.initState();
    context.read<ListaPedidos>().indicadores.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      child: FutureBuilder(
          future: context.read<ListaPedidos>().carregarPedidos(),
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: LoadingAnimationWidget.fourRotatingDots(
                    color: Theme.of(context).colorScheme.primary, size: 200),
              );
            } else if (snapshot.error != null) {
              return const Center(
                child: Text('Ocorreu um erro'),
              );
            } else {
              return Consumer<ListaPedidos>(
                  builder: (context, pedidos, _) => pedidos.items.isEmpty
                      ? const Center(
                          child: Text('Sem pedidos'),
                        )
                      : AspectRatio(
                          aspectRatio: 1.3,
                          child: Card(
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: GridView(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount:
                                            MediaQuery.of(context).size.width >
                                                    700
                                                ? 2
                                                : 1,
                                        childAspectRatio: 3 / 2,
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 10),
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 30),
                                    child: SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height,
                                      width: MediaQuery.of(context).size.width >
                                              700
                                          ? 600
                                          : MediaQuery.of(context).size.width,
                                      child: GridView.builder(
                                          itemCount:
                                              pedidos.produtosPedido.length,
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 2,
                                                  childAspectRatio: 5,
                                                  crossAxisSpacing: 0,
                                                  mainAxisSpacing: 0),
                                          itemBuilder: (context, index) {
                                            return Indicator(
                                              color: Color(cores[index]),
                                              index: index,
                                              text:
                                                  '${pedidos.produtosPedido[index].nome} - ${pedidos.produtosPedido[index].quantidade}',
                                              isSquare: true,
                                            );
                                          }),
                                    ),
                                  ),
                                  AspectRatio(
                                    aspectRatio: 1,
                                    child: PieChart(
                                      PieChartData(
                                          borderData: FlBorderData(
                                            show: false,
                                          ),
                                          pieTouchData: PieTouchData(
                                              enabled: true,
                                              touchCallback: (p0, p1) =>
                                                  pedidos.ativarIndicador(p1
                                                          ?.touchedSection
                                                          ?.touchedSectionIndex ??
                                                      -1)),
                                          sectionsSpace: 0,
                                          centerSpaceRadius:
                                              MediaQuery.of(context)
                                                          .size
                                                          .width >
                                                      700
                                                  ? 120
                                                  : 80,
                                          sections: showingSections(pedidos)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ));
            }
          })),
    );
  }

  List<PieChartSectionData> showingSections(ListaPedidos listaPedidos) {
    return List.generate(listaPedidos.produtosPedido.length, (i) {
      const fontSize = 16.0;
      const radius = 50.0;
      var valor = listaPedidos.produtosPedido[i].quantidade * 1.0;
      debugPrint(
          'Quantidade unica: ${listaPedidos.produtosPedido[i].nome} - ${listaPedidos.produtosPedido[i].quantidade}');
      return PieChartSectionData(
        badgePositionPercentageOffset: i * 1.0,
        color: Color(_geradorDeCor()),
        value: valor,
        title:
            '${((valor / listaPedidos.produtosPedido.length) * 100).toStringAsFixed(0)}%',
        radius: radius,
        titleStyle: const TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Color(0xffffffff)),
      );
    });
  }
}
