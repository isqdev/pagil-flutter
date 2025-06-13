// lib/views/categoria_musica_form.dart
import 'package:flutter/material.dart';

// Se você tiver um DTO para CategoriaMusica, importe-o aqui, por exemplo:
// import '../dto/dto_categoria_musica.dart';

class CategoriaMusicaForm extends StatefulWidget {
  const CategoriaMusicaForm({super.key}); // Mantenha o construtor

  @override
  State<CategoriaMusicaForm> createState() => _CategoriaMusicaFormState();
}

class _CategoriaMusicaFormState extends State<CategoriaMusicaForm> {
  final _formKey =
      GlobalKey<FormState>(); // Adicionado o GlobalKey para validação
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  bool _ativo = true;

  void _salvar() {
    // Renomeado de _submitForm para _salvar
    if (_formKey.currentState!.validate()) {
      // Exemplo de como você criaria um DTO, se existisse:
      // final categoriaMusica = CategoriaMusicaDTO(
      //   id: UniqueKey().toString(), // Gerando um ID temporário
      //   nome: _nomeController.text,
      //   descricao: _descricaoController.text.isNotEmpty ? _descricaoController.text : null,
      //   ativo: _ativo,
      // );

      // Mostra um AlertDialog como no FormTipoManutencao
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Sucesso'),
          content: Text(
            'Categoria de Música salva!\n\n'
            'Nome:  ${_nomeController.text}\n'
            'Descrição: ${_descricaoController.text}\n'
            'Ativo: ${_ativo ? "Sim" : "Não"}'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Future.delayed(const Duration(milliseconds: 400), () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    '/lista-categoria-musica',
                    (route) => false,
                  );
                });
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );

      // Limpa os campos após salvar
      _formKey.currentState!.reset(); // Reseta o formulário
      setState(() {
        _ativo = true;
      });
    }
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _descricaoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categoria de Música'),
        backgroundColor: Colors.indigo.shade700,
        elevation: 6,
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(25)),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE3E6F3), Color(0xFFF8F8FF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey, // Associado o GlobalKey ao Form
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.queue_music,
                        color: Colors.indigo.shade700,
                        size: 48,
                      ), // Ícone personalizado
                      const SizedBox(height: 16),
                      TextFormField(
                        // Usando TextFormField para validação
                        controller: _nomeController,
                        decoration: InputDecoration(
                          labelText: 'Nome*',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon: const Icon(
                            Icons.music_note,
                          ), // Ícone de nota musical
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Informe o nome da categoria';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 18),
                      TextFormField(
                        // Usando TextFormField para validação
                        controller: _descricaoController,
                        decoration: InputDecoration(
                          labelText: 'Descrição',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon: const Icon(Icons.description),
                        ),
                        maxLines: 3,
                        validator: (value) {
                          // Se quiser tornar a descrição obrigatória, descomente o bloco abaixo
                          // if (value == null || value.isEmpty) {
                          //   return 'Informe a descrição da categoria';
                          // }
                          return null;
                        },
                      ),
                      const SizedBox(height: 18),
                      SwitchListTile(
                        title: const Text(
                          'Ativo',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        value: _ativo,
                        activeColor: Colors.indigo,
                        onChanged: (value) {
                          setState(() {
                            _ativo = value;
                          });
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        tileColor: Colors.indigo.withOpacity(0.05),
                      ),
                      const SizedBox(height: 28),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton.icon(
                          onPressed: _salvar,
                          icon: const Icon(Icons.save_alt, color: Colors.white),
                          label: const Text(
                            'Salvar',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.indigo.shade700,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
