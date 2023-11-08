import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'package:intl/intl.dart';

final dataFormato = DateFormat('dd/MM/yyyy');

const uuid = Uuid();

enum Categoria { comida, viagem, lazer, casa }

const categoriaItens = {
  Categoria.comida: Icons.local_restaurant,
  Categoria.viagem: Icons.flight,
  Categoria.lazer: Icons.theater_comedy,
  Categoria.casa: Icons.home,
};

class Gasto {
  Gasto({
    required this.titulo,
    required this.valor,
    required this.data,
    required this.categoria,
  }) : id = uuid.v4();

  final String id;
  final String titulo;
  final double valor;
  final DateTime data;
  final Categoria categoria;

  String get dadoFormatado {
    return dataFormato.format(data);
  }
}

class GraficoGastos {
  const GraficoGastos({required this.categoria, required this.gasto});
  final Categoria categoria;
  final List<Gasto> gasto;

  GraficoGastos.forCategoria(List<Gasto> todosOsGastos, this.categoria)
      : gasto = todosOsGastos
            .where((gasto) => gasto.categoria == categoria)
            .toList();

  double get totalGastos {
    double sum = 0;

    for (final gastos in gasto) {
      sum = sum + gastos.valor;
    }
    return sum;
  }
}
