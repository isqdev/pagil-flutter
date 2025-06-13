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

  void _salvar() {
    if (_formKey.currentState!.validate()) {
      final sala = DTOSala(
        nome: _nomeController.text,
        capacidade_total_bikes: int.parse(_capacidadeController.text),
        numero_filas: int.parse(_filasController.text),
        numero_bikes_por_fila: int.parse(_bikesPorFilaController.text),
        ativo: _ativo,
      );
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Sucesso'),
          content: Text(
            'Sala salva!\n\n'
            'Nome: sala.nome\n'
            'Capacidade Total: sala.capacidade_total_bikes\n'
            'Nmero de Filas: sala.numero_filas\n'
            'Bikes por Fila: sala.numero_bikes_por_fila\n'
            'Ativo: sala.ativo ? "Sim" : "No"}',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Future.delayed(const Duration(milliseconds: 400), () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    '/lista-sala',
                    (route) => false,
                  );
                });
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
      _formKey.currentState!.reset();
      setState(() {
        _ativo = true;
      });
    }
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _capacidadeController.dispose();
    _filasController.dispose();
    _bikesPorFilaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Sala'),
        backgroundColor: Colors.purple.shade700,
        elevation: 6,
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF3E6F3), Color(0xFFF8F8FF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.meeting_room, color: Colors.purple.shade700, size: 48),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _nomeController,
                        decoration: InputDecoration(
                          labelText: 'Nome*',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          prefixIcon: const Icon(Icons.edit),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Informe o nome';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 18),
                      TextFormField(
                        controller: _capacidadeController,
                        decoration: InputDecoration(
                          labelText: 'Capacidade Total de Bikes*',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          prefixIcon: const Icon(Icons.directions_bike),
                        ),
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
                      const SizedBox(height: 18),
                      TextFormField(
                        controller: _filasController,
                        decoration: InputDecoration(
                          labelText: 'Número de Filas*',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          prefixIcon: const Icon(Icons.view_column),
                        ),
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
                      const SizedBox(height: 18),
                      TextFormField(
                        controller: _bikesPorFilaController,
                        decoration: InputDecoration(
                          labelText: 'Número de Bikes por Fila*',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          prefixIcon: const Icon(Icons.format_list_numbered),
                        ),
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
                      const SizedBox(height: 18),
                      SwitchListTile(
                        title: const Text('Ativo', style: TextStyle(fontWeight: FontWeight.w600)),
                        value: _ativo,
                        activeColor: Colors.purple,
                        onChanged: (value) {
                          setState(() {
                            _ativo = value;
                          });
                        },
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        tileColor: Colors.purple.withOpacity(0.05),
                      ),
                      const SizedBox(height: 28),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton.icon(
                          onPressed: _salvar,
                          icon: const Icon(Icons.save_alt, color: Colors.white),
                          label: const Text(
                            'Salvar',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple.shade700,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            elevation: 4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}