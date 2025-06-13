import 'package:flutter/material.dart';
import '../dto/dto_manutencao.dart';

// Mock de dados de tipos de manutenção
final List<TipoManutencaoDTO> mockManutencoes = [
  TipoManutencaoDTO(
    id: '1',
    nome: 'Preventiva',
    descricao: 'Manutenção realizada para prevenir falhas',
    ativo: true,
  ),
  TipoManutencaoDTO(
    id: '2',
    nome: 'Corretiva',
    descricao: 'Manutenção realizada após falha',
    ativo: false,
  ),
  TipoManutencaoDTO(
    id: '3',
    nome: 'Preditiva',
    descricao: 'Manutenção baseada em monitoramento',
    ativo: true,
  ),
];

class ListaManutencao extends StatefulWidget {
  const ListaManutencao({Key? key}) : super(key: key);

  @override
  State<ListaManutencao> createState() => _ListaManutencaoState();
}

class _ListaManutencaoState extends State<ListaManutencao> {
  late List<TipoManutencaoDTO> _manutencoes;

  @override
  void initState() {
    super.initState();
    _manutencoes = List.from(mockManutencoes);
  }

  void _removerManutencao(int index) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Excluir Tipo de Manutenção'),
        content: Text('Deseja realmente excluir o tipo "${_manutencoes[index].nome}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _manutencoes.removeAt(index);
              });
              Navigator.of(ctx).pop();
            },
            child: const Text('Excluir', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _alterarManutencao(int index) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Alterar Tipo de Manutenção'),
        content: Text('Funcionalidade de alteração para "${_manutencoes[index].nome}" (mock).'),
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
          },
        ),
        title: const Text('Lista de Manutenções'),
        backgroundColor: Colors.red.shade700,
        centerTitle: true,
        elevation: 6,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _manutencoes.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final manut = _manutencoes[index];
          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: ListTile(
              leading: Icon(Icons.build, color: manut.ativo ? Colors.red : Colors.grey),
              title: Text(manut.nome, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(manut.descricao ?? ''),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    tooltip: 'Alterar',
                    onPressed: () => _alterarManutencao(index),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    tooltip: 'Excluir',
                    onPressed: () => _removerManutencao(index),
                  ),
                ],
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text(manut.nome),
                    content: Text(manut.toString()),
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
