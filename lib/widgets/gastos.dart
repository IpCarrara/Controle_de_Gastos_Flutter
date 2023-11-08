import 'package:flutter/material.dart';
import 'package:gastos/widgets/gastos_lista/gastos_lista.dart';
import 'package:gastos/models/gasto.dart';
import 'package:gastos/widgets/gradico/chart.dart';
import 'package:gastos/widgets/novo_gasto.dart';

class Gastos extends StatefulWidget {
  const Gastos({super.key});

  @override
  State<Gastos> createState() => _GastosState();
}

class _GastosState extends State<Gastos> {
  final List<Gasto> _gastosRegistrados = [
    Gasto(
      titulo: 'Donuts',
      valor: 12.00,
      data: DateTime.now(),
      categoria: Categoria.comida,
    ),
    Gasto(
      titulo: 'Internet',
      valor: 99.00,
      data: DateTime.now(),
      categoria: Categoria.casa,
    ),
    Gasto(
      titulo: 'Bar',
      valor: 45.67,
      data: DateTime.now(),
      categoria: Categoria.lazer,
    ),
    Gasto(
      titulo: 'Passagem China',
      valor: 4500.67,
      data: DateTime.now(),
      categoria: Categoria.viagem,
    ),
  ];

  void _abrirTelaIncluirGasto() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NovoGasto(onIncluirGastos: _incluirGastos),
    );
  }

  void _incluirGastos(Gasto gasto) {
    setState(() {
      _gastosRegistrados.add(gasto);
    });
  }

  void _removerGastos(Gasto gasto) {
    final gastoIndex = _gastosRegistrados.indexOf(gasto);
    setState(() {
      _gastosRegistrados.remove(gasto);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Gasto removido.'),
        action: SnackBarAction(
          label: 'Desfazer',
          onPressed: () {
            setState(() {
              _gastosRegistrados.insert(gastoIndex, gasto);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget gastosExibidos = const Center(
      child: Text('Você ainda não tem nenhum gasto.'),
    );

    if (_gastosRegistrados.isNotEmpty) {
      gastosExibidos = GastosLista(
        gastos: _gastosRegistrados,
        onRemoverGastos: _removerGastos,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Controle de Gastos'),
        actions: [
          IconButton(
            onPressed: _abrirTelaIncluirGasto,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(children: [
        Chart(gasto: _gastosRegistrados),
        Expanded(
          child: gastosExibidos,
        ),
      ]),
    );
  }
}
