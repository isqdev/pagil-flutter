import 'package:flutter/material.dart';
import '../dto/dto_fabricante.dart';

// Mock de dados de fabricantes de parafuso
final List<DTOFabricante> mockFabricantes = [
  DTOFabricante(
    id: '1',
    nome: 'Parafusos Brasil',
    descricao: 'Fabricante nacional de parafusos industriais',
    nomeContatoPrincipal: 'João Silva',
    emailContato: 'joao@parafusosbr.com',
    telefoneContato: '(11) 99999-1111',
    ativo: true,
  ),
  DTOFabricante(
    id: '2',
    nome: 'Fixadores Premium',
    descricao: 'Especialista em parafusos de alta resistência',
    nomeContatoPrincipal: 'Maria Souza',
    emailContato: 'maria@fixadorespremium.com',
    telefoneContato: '(21) 98888-2222',
    ativo: false,
  ),
  DTOFabricante(
    id: '3',
    nome: 'Metalúrgica União',
    descricao: 'Parafusos e porcas para construção civil',
    nomeContatoPrincipal: 'Carlos Lima',
    emailContato: 'carlos@metalurgicauniao.com',
    telefoneContato: '(31) 97777-3333',
    ativo: true,
  ),
];

class ListaFabricante extends StatefulWidget {
  const ListaFabricante({Key? key}) : super(key: key);

  @override
  State<ListaFabricante> createState() => _ListaFabricanteState();
}

class _ListaFabricanteState extends State<ListaFabricante> {
  late List<DTOFabricante> _fabricantes;

  @override
  void initState() {
    super.initState();
    _fabricantes = List.from(mockFabricantes);
  }

  void _removerFabricante(int index) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Excluir Fabricante'),
        content: Text('Deseja realmente excluir o fabricante "${_fabricantes[index].nome}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _fabricantes.removeAt(index);
              });
              Navigator.of(ctx).pop();
            },
            child: const Text('Excluir', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _alterarFabricante(int index) {
    // Aqui você pode navegar para o formulário de edição ou mostrar um dialog
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Alterar Fabricante'),
        content: Text('Funcionalidade de alteração para "${_fabricantes[index].nome}" (mock).'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Fabricantes'),
        backgroundColor: Colors.orange.shade700,
        centerTitle: true,
        elevation: 6,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _fabricantes.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final fab = _fabricantes[index];
          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: ListTile(
              leading: Icon(Icons.factory, color: fab.ativo ? Colors.orange : Colors.grey),
              title: Text(fab.nome, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(fab.descricao),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    tooltip: 'Alterar',
                    onPressed: () => _alterarFabricante(index),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    tooltip: 'Excluir',
                    onPressed: () => _removerFabricante(index),
                  ),
                ],
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text(fab.nome),
                    content: Text(fab.toString()),
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
