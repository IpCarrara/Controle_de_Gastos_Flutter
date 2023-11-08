import 'package:flutter/material.dart';

import 'package:gastos/models/gasto.dart';

class NovoGasto extends StatefulWidget {
  const NovoGasto({super.key, required this.onIncluirGastos});

  final Function(Gasto gasto) onIncluirGastos;

  @override
  State<NovoGasto> createState() => _NovoGastoState();
}

class _NovoGastoState extends State<NovoGasto> {
  final _controladorTitulo = TextEditingController();
  final _controladorValor = TextEditingController();
  DateTime? _dataEscolhida;
  Categoria _categoriaSelecionada = Categoria.lazer;

  @override
  void dispose() {
    _controladorTitulo.dispose();
    _controladorValor.dispose();
    super.dispose();
  }

  void _escolherData() async {
    final agora = DateTime.now();
    final primeiraData = DateTime(agora.year - 1, agora.month, agora.day);
    final ultimaData = DateTime(agora.year, agora.month + 2, agora.day);

    final dataSelecionada = await showDatePicker(
      locale: const Locale('pt', 'BR'),
      context: context,
      initialDate: agora,
      firstDate: primeiraData,
      lastDate: ultimaData,
    );
    setState(() {
      _dataEscolhida = dataSelecionada;
    });
  }

  void _salvar() {
    final valorString = _controladorValor.text;
    final valorStringConvertido = valorString.replaceAll(',', '.');
    final valorRegistrado = double.tryParse(valorStringConvertido);

    final valorInvalido = valorRegistrado == null || valorRegistrado <= 0;
    if (_controladorTitulo.text.trim().isEmpty ||
        valorInvalido ||
        _dataEscolhida == null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Entrada Inválida'),
          content: const Text(
              'Entre um valor válido em Categoria, Titulo, Valor e Data.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Fechar'),
            )
          ],
        ),
      );
      return;
    }

    widget.onIncluirGastos(
      Gasto(
        titulo: _controladorTitulo.text,
        valor: valorRegistrado,
        data: _dataEscolhida!,
        categoria: _categoriaSelecionada,
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final tamanhoTeclado = MediaQuery.of(context).viewInsets.bottom;

    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, tamanhoTeclado + 16),
          child: Column(
            children: [
              DropdownButton(
                value: _categoriaSelecionada,
                items: Categoria.values
                    .map(
                      (categoria) => DropdownMenuItem(
                        value: categoria,
                        child: Text(
                          categoria.name.toUpperCase(),
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }
                  setState(
                    () {
                      _categoriaSelecionada = value;
                    },
                  );
                },
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _controladorTitulo,
                maxLength: 50,
                decoration: const InputDecoration(label: Text('Titulo')),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controladorValor,
                      decoration: const InputDecoration(
                        label: Text('Valor'),
                        prefixText: 'R\$ ',
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(_dataEscolhida == null
                            ? 'Escolha a Data'
                            : dataFormato.format(_dataEscolhida!)),
                        IconButton(
                          onPressed: _escolherData,
                          icon: const Icon(Icons.calendar_month),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 35),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancelar'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _salvar,
                    child: const Text('Salvar'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
