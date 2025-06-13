import 'package:flutter/material.dart';
import '../dto/dto_turma.dart';

final List<DTOTurma> mockTurmas = [
  // Adicione algumas turmas mock se desejar
];

class ListaTurma extends StatefulWidget {
  const ListaTurma({Key? key}) : super(key: key);

  @override
  State<ListaTurma> createState() => _ListaTurmaState();
}

class _ListaTurmaState extends State<ListaTurma> {
  late List<DTOTurma> _turmas;

  @override
  void initState() {
    super.initState();
    _turmas = List.from(mockTurmas);
  }

  void _removerTurma(int index) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Excluir Turma'),
        content: Text('Deseja realmente excluir a turma "${_turmas[index].nome}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _turmas.removeAt(index);
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
        title: const Text('Lista de Turmas'),
        backgroundColor: Colors.yellow.shade700,
        centerTitle: true,
        elevation: 6,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _turmas.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final turma = _turmas[index];
          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: ListTile(
              leading: Icon(Icons.class_, color: turma.ativo ? Colors.yellow.shade700 : Colors.grey),
              title: Text(turma.nome, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(turma.descricao ?? ''),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                tooltip: 'Excluir',
                onPressed: () => _removerTurma(index),
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text(turma.nome),
                    content: Text(turma.toString()),
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
