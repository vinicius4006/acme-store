import 'dart:math';

import 'package:acme_store/components/indicator.dart';
import 'package:acme_store/models/lista_pedidos.dart';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class PieQuantidadeValor extends StatefulWidget {
  const PieQuantidadeValor({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => PieQuantidadeValorState();
}

class PieQuantidadeValorState extends State {
  List<int> cores = [];
  int _geradorDeCor() {
    int valor = int.parse('0xff'
        '${Random().nextInt(899999) + 100000}');
    cores.add(valor);
    return cores.last;
  }

  @override
  void initState() {
    // TODO: implement initState
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
                          child: Text('Sem Pedidos'),
                        )
                      : AspectRatio(
                          aspectRatio: 1.3,
                          child: Card(
                            color: Colors.white,
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
                              children: <Widget>[
                                Container(
                                  margin: const EdgeInsets.only(bottom: 20),
                                  child: SizedBox(
                                    height: MediaQuery.of(context).size.height,
                                    width:
                                        MediaQuery.of(context).size.width > 700
                                            ? 400
                                            : MediaQuery.of(context).size.width,
                                    child: GridView.builder(
                                      padding: const EdgeInsets.all(10),
                                      itemCount: pedidos.itemsCount,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              childAspectRatio: 5,
                                              crossAxisSpacing: 0,
                                              mainAxisSpacing: 0),
                                      itemBuilder: (context, index) =>
                                          Indicator(
                                        index: index,
                                        color: Color(cores[index]),
                                        text:
                                            'Pedido - R\$ ${pedidos.items[index].total.toStringAsFixed(2)}',
                                        isSquare: true,
                                      ),
                                    ),
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
                                            MediaQuery.of(context).size.width >
                                                    700
                                                ? 120
                                                : 80,
                                        sections: showingSections(pedidos)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ));
            }
          })),
    );
  }

  List<PieChartSectionData> showingSections(ListaPedidos listaPedidos) {
    return List.generate(listaPedidos.itemsCount, (i) {
      const fontSize = 16.0;
      const radius = 50.0;
      double valor = listaPedidos.items[i].total;
      return PieChartSectionData(
        color: Color(_geradorDeCor()),
        value: valor,
        title:
            '${((valor / listaPedidos.somaDosPedidos) * 100).toStringAsFixed(0)}%',
        radius: radius,
        titleStyle: const TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Color(0xffffffff)),
      );
    });
  }
}
