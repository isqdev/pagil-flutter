import 'package:flutter/material.dart';
import '../dto/dto_sala.dart';

final List<DTOSala> mockSalas = [
  // Adicione algumas salas mock se desejar
];

class ListaSala extends StatefulWidget {
  const ListaSala({Key? key}) : super(key: key);

  @override
  State<ListaSala> createState() => _ListaSalaState();
}

class _ListaSalaState extends State<ListaSala> {
  late List<DTOSala> _salas;

  @override
  void initState() {
    super.initState();
    _salas = List.from(mockSalas);
  }

  void _removerSala(int index) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Excluir Sala'),
        content: Text('Deseja realmente excluir a sala "${_salas[index].nome}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _salas.removeAt(index);
              });
              Navigator.of(ctx).pop();
            },
            child: const Text('Excluir', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
          },
        ),
        title: const Text('Lista de Salas'),
        backgroundColor: Colors.purple.shade700,
        centerTitle: true,
        elevation: 6,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _salas.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final sala = _salas[index];
          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: ListTile(
              leading: Icon(Icons.meeting_room, color: sala.ativo ? Colors.purple : Colors.grey),
              title: Text(sala.nome, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('Capacidade: ${sala.capacidade_total_bikes}'),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                tooltip: 'Excluir',
                onPressed: () => _removerSala(index),
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text(sala.nome),
                    content: Text(sala.toString()),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(ctx).pop(),
                        child: const Text('Fechar'),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
