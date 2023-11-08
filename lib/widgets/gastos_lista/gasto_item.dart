import 'package:flutter/material.dart';
import 'package:gastos/models/gasto.dart';

import 'package:intl/intl.dart';

class GastoItem extends StatelessWidget {
  const GastoItem(this.gasto, {super.key});

  final Gasto gasto;

  @override
  Widget build(BuildContext context) {
    final numberFormat = NumberFormat.decimalPattern('pt_BR');

    final valorFormatado = numberFormat.format(gasto.valor);
    final partes = valorFormatado.split(',');
    final valorComDoisDecimais = partes.length > 1
        ? '${partes[0]},${partes[1].padRight(2, '0')}'
        : '$valorFormatado,00';

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              gasto.titulo,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Text('R\$ $valorComDoisDecimais'),
                const Spacer(),
                Row(
                  children: [
                    Icon(categoriaItens[gasto.categoria]),
                    const SizedBox(width: 8),
                    Text(gasto.dadoFormatado)
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
