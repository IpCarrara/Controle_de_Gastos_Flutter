import 'package:flutter/material.dart';

import 'package:gastos/widgets/gradico/chart_bar.dart';
import 'package:gastos/models/gasto.dart';

class Chart extends StatelessWidget {
  const Chart({super.key, required this.gasto});

  final List<Gasto> gasto;

  List<GraficoGastos> get buckets {
    return [
      GraficoGastos.forCategoria(gasto, Categoria.comida),
      GraficoGastos.forCategoria(gasto, Categoria.lazer),
      GraficoGastos.forCategoria(gasto, Categoria.viagem),
      GraficoGastos.forCategoria(gasto, Categoria.casa),
    ];
  }

  double get maxTotalExpense {
    double maxTotalExpense = 0;

    for (final bucket in buckets) {
      if (bucket.totalGastos > maxTotalExpense) {
        maxTotalExpense = bucket.totalGastos;
      }
    }

    return maxTotalExpense;
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 8,
      ),
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.3),
            Theme.of(context).colorScheme.primary.withOpacity(0.0)
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (final bucket in buckets) // alternative to map()
                  ChartBar(
                    fill: bucket.totalGastos == 0
                        ? 0
                        : bucket.totalGastos / maxTotalExpense,
                  )
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: buckets
                .map(
                  (bucket) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Icon(
                        categoriaItens[bucket.categoria],
                        color: isDarkMode
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.7),
                      ),
                    ),
                  ),
                )
                .toList(),
          )
        ],
      ),
    );
  }
}
