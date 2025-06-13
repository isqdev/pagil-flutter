import 'package:flutter/material.dart';
import 'package:pagil_flutter/banco/sqlite/dao/DAOFabricante.dart';
import 'package:pagil_flutter/dto/dto_fabricante.dart';

class ListaFabricante extends StatefulWidget {
  const ListaFabricante({super.key});

  @override
  State<ListaFabricante> createState() => _ListaFabricanteState();
}

class _ListaFabricanteState extends State<ListaFabricante> {
  var dao = DAOFabricante();
  late Future<List<DTOFabricante>> _futureFabricantes;

  @override
  void initState() {
    super.initState();
    _futureFabricantes = _carregarDados(); 
  }

  Future<List<DTOFabricante>> _carregarDados() async {
    return await dao.consultarTodos();
  }

  void _recarregar() {
    setState(() {
      _futureFabricantes = _carregarDados();
    });
  }

  void _alterar(BuildContext context, DTOFabricante dto) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Alterar: \\${dto.nome}')),
    );
  }

  void _excluir(BuildContext context, DTOFabricante dto) async {
    if (dto.id != null) {
      await dao.excluir(int.parse(dto.id!));
      _recarregar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Excluído: \\${dto.nome}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Fabricantes'),
        backgroundColor: Colors.orange.shade700,
        centerTitle: true,
      ),
      body: FutureBuilder<List<DTOFabricante>>(
        future: _futureFabricantes,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          final lista = snapshot.data ?? [];

          if (lista.isEmpty) {
            return const Center(child: Text('Nenhum fabricante encontrado.'));
          }

          return ListView.builder(
            itemCount: lista.length,
            itemBuilder: (context, index) {
              final fabricante = lista[index];

              return ListTile(
                title: Text(fabricante.nome),
                subtitle: Text(fabricante.descricao),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.orange),
                      onPressed: () => _alterar(context, fabricante),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _excluir(context, fabricante),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.of(context).pushNamed('/fabricante');
          if (result == true) {
            _recarregar();
          }
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.orange.shade700,
        tooltip: 'Novo Fabricante',
      ),
    );
  }
}