import 'package:flutter/material.dart';

class CategoriaMusicaForm extends StatefulWidget {
  const CategoriaMusicaForm({super.key});

  @override
  State<CategoriaMusicaForm> createState() => _CategoriaMusicaFormState();
}

class _CategoriaMusicaFormState extends State<CategoriaMusicaForm> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  bool _ativo = true;

  @override
  void dispose() {
    _nomeController.dispose();
    _descricaoController.dispose();
    super.dispose();
  }

  void _submitForm() {
    // Apenas para demonstração: imprime os valores no console
    print('Nome: ${_nomeController.text}');
    print('Descrição: ${_descricaoController.text}');
    print('Ativo: $_ativo');

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Categoria ${_nomeController.text} Salva!')),
    );

    // Limpa os campos após enviar
    _nomeController.clear();
    _descricaoController.clear();
    setState(() {
      _ativo = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nova Categoria de Música')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _nomeController,
              decoration: const InputDecoration(labelText: 'Nome'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _descricaoController,
              decoration: const InputDecoration(labelText: 'Descrição'),
              maxLines: 3,
            ),
            SwitchListTile(
              title: const Text('Ativo'),
              value: _ativo,
              onChanged: (bool value) {
                setState(() {
                  _ativo = value;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _submitForm, child: const Text('Salvar')),
          ],
        ),
      ),
    );
  }
}
