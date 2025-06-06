import 'package:flutter/material.dart';
import '../dto/dto_sala.dart';

class FormSala extends StatefulWidget {
  const FormSala({Key? key}) : super(key: key);

  @override
  State<FormSala> createState() => _FormSalaState();
}

class _FormSalaState extends State<FormSala> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _capacidadeController = TextEditingController();
  final _filasController = TextEditingController();
  final _bikesPorFilaController = TextEditingController();
  bool _ativo = true;

  @override
  void dispose() {
    _nomeController.dispose();
    _capacidadeController.dispose();
    _filasController.dispose();
    _bikesPorFilaController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      // Aqui você pode criar o objeto DTOSala ou fazer outra ação
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Formulário válido!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro de Sala')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe o nome';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _capacidadeController,
                decoration: const InputDecoration(labelText: 'Capacidade Total de Bikes'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe a capacidade total';
                  }
                  final n = int.tryParse(value);
                  if (n == null || n <= 0) {
                    return 'Informe um número válido';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _filasController,
                decoration: const InputDecoration(labelText: 'Número de Filas'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe o número de filas';
                  }
                  final n = int.tryParse(value);
                  if (n == null || n <= 0) {
                    return 'Informe um número válido';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _bikesPorFilaController,
                decoration: const InputDecoration(labelText: 'Número de Bikes por Fila'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe o número de bikes por fila';
                  }
                  final n = int.tryParse(value);
                  if (n == null || n <= 0) {
                    return 'Informe um número válido';
                  }
                  return null;
                },
              ),
              SwitchListTile(
                title: const Text('Ativo'),
                value: _ativo,
                onChanged: (val) {
                  setState(() {
                    _ativo = val;
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submit,
                child: const Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}