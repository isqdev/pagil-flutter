import 'package:flutter/material.dart';
import '../dto/dto_aluno.dart';

final List<DTOAluno> mockAlunos = [
  // Adicione alguns alunos mock se desejar
];

class ListaAluno extends StatefulWidget {
  const ListaAluno({Key? key}) : super(key: key);

  @override
  State<ListaAluno> createState() => _ListaAlunoState();
}

class _ListaAlunoState extends State<ListaAluno> {
  late List<DTOAluno> _alunos;

  @override
  void initState() {
    super.initState();
    _alunos = List.from(mockAlunos);
  }

  void _removerAluno(int index) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Excluir Aluno'),
        content: Text('Deseja realmente excluir o aluno "${_alunos[index].nome}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _alunos.removeAt(index);
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
        title: const Text('Lista de Alunos'),
        backgroundColor: Colors.green.shade700,
        centerTitle: true,
        elevation: 6,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _alunos.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final aluno = _alunos[index];
          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: ListTile(
              leading: Icon(Icons.person, color: aluno.ativo ? Colors.green : Colors.grey),
              title: Text(aluno.nome, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(aluno.email),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                tooltip: 'Excluir',
                onPressed: () => _removerAluno(index),
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text(aluno.nome),
                    content: Text(aluno.toString()),
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
