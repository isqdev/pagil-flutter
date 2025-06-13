import 'package:flutter/material.dart';
import '../dto/dto_banda_artista.dart';

final List<DTOBandaArtista> mockBandas = [
  // Adicione algumas bandas/artistas mock se desejar
];

class ListaBandaArtista extends StatefulWidget {
  const ListaBandaArtista({Key? key}) : super(key: key);

  @override
  State<ListaBandaArtista> createState() => _ListaBandaArtistaState();
}

class _ListaBandaArtistaState extends State<ListaBandaArtista> {
  late List<DTOBandaArtista> _bandas;

  @override
  void initState() {
    super.initState();
    _bandas = List.from(mockBandas);
  }

  void _removerBanda(int index) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Excluir Banda/Artista'),
        content: Text('Deseja realmente excluir "${_bandas[index].nome}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _bandas.removeAt(index);
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
        title: const Text('Lista de Bandas/Artistas'),
        backgroundColor: Colors.pink.shade400,
        centerTitle: true,
        elevation: 6,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _bandas.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final banda = _bandas[index];
          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: ListTile(
              leading: Icon(Icons.speaker_group_outlined, color: banda.ativo ? Colors.pink : Colors.grey),
              title: Text(banda.nome, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(banda.descricaoCurta ?? ''),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                tooltip: 'Excluir',
                onPressed: () => _removerBanda(index),
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text(banda.nome),
                    content: Text(banda.toString()),
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
