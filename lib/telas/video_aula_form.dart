import 'package:flutter/material.dart';

class VideoAulaForm extends StatefulWidget {
  const VideoAulaForm({super.key});

  @override
  State<VideoAulaForm> createState() => _VideoAulaFormState();
}

class _VideoAulaFormState extends State<VideoAulaForm> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _linkVideoController = TextEditingController();
  bool _ativo = true;

  @override
  void dispose() {
    _idController.dispose();
    _nomeController.dispose();
    _linkVideoController.dispose();
    super.dispose();
  }

  void _submitForm() {
    // Apenas para demonstração: imprime os valores no console
    print('ID: ${_idController.text}');
    print('Nome: ${_nomeController.text}');
    print('Link do Vídeo: ${_linkVideoController.text}');
    print('Ativo: $_ativo');

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('VideoAula "${_nomeController.text}" Salva!')),
    );

    // Limpa os campos após enviar
    _idController.clear();
    _nomeController.clear();
    _linkVideoController.clear();
    setState(() {
      _ativo = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nova VideoAula')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _idController,
              decoration: const InputDecoration(labelText: 'ID'),
              keyboardType:
                  TextInputType.number, // Para permitir apenas números
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _nomeController,
              decoration: const InputDecoration(labelText: 'Nome da VideoAula'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _linkVideoController,
              decoration: const InputDecoration(labelText: 'Link do Vídeo'),
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
