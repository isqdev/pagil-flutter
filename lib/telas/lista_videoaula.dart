import 'package:flutter/material.dart';

final List<Map<String, dynamic>> mockVideoAulas = [
  // Adicione algumas videoaulas mock se desejar
];

class ListaVideoAula extends StatefulWidget {
  const ListaVideoAula({Key? key}) : super(key: key);

  @override
  State<ListaVideoAula> createState() => _ListaVideoAulaState();
}

class _ListaVideoAulaState extends State<ListaVideoAula> {
  late List<Map<String, dynamic>> _videoAulas;

  @override
  void initState() {
    super.initState();
    _videoAulas = List.from(mockVideoAulas);
  }

  void _removerVideoAula(int index) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Excluir VideoAula'),
        content: Text('Deseja realmente excluir a videoaula "${_videoAulas[index]['nome']}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _videoAulas.removeAt(index);
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
        title: const Text('Lista de VideoAulas'),
        backgroundColor: Colors.blue.shade700,
        centerTitle: true,
        elevation: 6,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _videoAulas.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final video = _videoAulas[index];
          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: ListTile(
              leading: Icon(Icons.play_circle_fill, color: Colors.blue.shade700),
              title: Text(video['nome'] ?? '', style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(video['link'] ?? ''),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                tooltip: 'Excluir',
                onPressed: () => _removerVideoAula(index),
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text(video['nome'] ?? ''),
                    content: Text(video.toString()),
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
