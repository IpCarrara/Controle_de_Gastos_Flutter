import 'package:flutter/material.dart';
import 'package:gastos/models/gasto.dart';
import 'package:gastos/widgets/gastos_lista/gasto_item.dart';

class GastosLista extends StatelessWidget {
  const GastosLista({
    super.key,
    required this.gastos,
    required this.onRemoverGastos,
  });

  final List<Gasto> gastos;
  final void Function(Gasto gasto) onRemoverGastos;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: gastos.length,
      itemBuilder: (context, index) => Dismissible(
        key: ValueKey(gastos[index]),
        background: ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 4,
            ),
            child: Container(
              color: const Color.fromARGB(55, 255, 152, 152),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Icon(
                      Icons.delete_sweep_outlined,
                      color: Color.fromARGB(255, 165, 32, 32),
                      size: 30,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Icon(
                      Icons.delete_sweep_outlined,
                      color: Color.fromARGB(255, 165, 32, 32),
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        onDismissed: (direction) {
          onRemoverGastos(gastos[index]);
        },
        child: GastoItem(
          gastos[index],
        ),
      ),
    );
  }
}
