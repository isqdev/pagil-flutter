import 'package:flutter/material.dart';
// import '../dto/dto_categoria_musica.dart';

final List<Map<String, dynamic>> mockCategorias = [
  // Adicione algumas categorias mock se desejar
];

class ListaCategoriaMusica extends StatefulWidget {
  const ListaCategoriaMusica({Key? key}) : super(key: key);

  @override
  State<ListaCategoriaMusica> createState() => _ListaCategoriaMusicaState();
}

class _ListaCategoriaMusicaState extends State<ListaCategoriaMusica> {
  late List<Map<String, dynamic>> _categorias;

  @override
  void initState() {
    super.initState();
    _categorias = List.from(mockCategorias);
  }

  void _removerCategoria(int index) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Excluir Categoria'),
        content: Text('Deseja realmente excluir a categoria "${_categorias[index]['nome']}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _categorias.removeAt(index);
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
        title: const Text('Lista de Categorias de Música'),
        backgroundColor: Colors.teal,
        centerTitle: true,
        elevation: 6,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _categorias.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final cat = _categorias[index];
          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: ListTile(
              leading: Icon(Icons.music_note, color: Colors.teal.shade700),
              title: Text(cat['nome'] ?? '', style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(cat['descricao'] ?? ''),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                tooltip: 'Excluir',
                onPressed: () => _removerCategoria(index),
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text(cat['nome'] ?? ''),
                    content: Text(cat.toString()),
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
