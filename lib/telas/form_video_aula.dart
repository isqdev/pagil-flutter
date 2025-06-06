// lib/views/video_aula_form.dart
import 'package:flutter/material.dart';

// Se você tiver um DTO para VideoAula, importe-o aqui, por exemplo:
// import '../dto/dto_video_aula.dart';

class VideoAulaForm extends StatefulWidget {
  const VideoAulaForm({super.key}); // Mantenha o construtor

  @override
  State<VideoAulaForm> createState() => _VideoAulaFormState();
}

class _VideoAulaFormState extends State<VideoAulaForm> {
  final _formKey =
      GlobalKey<FormState>(); // Adicionado o GlobalKey para validação
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _linkVideoController = TextEditingController();
  bool _ativo = true;

  void _salvar() {
    // Renomeado de _submitForm para _salvar
    if (_formKey.currentState!.validate()) {
      // Exemplo de como você criaria um DTO, se existisse:
      // final videoAula = VideoAulaDTO(
      //   id: _idController.text, // Usando o ID digitado
      //   nome: _nomeController.text,
      //   linkVideo: _linkVideoController.text,
      //   ativo: _ativo,
      // );

      // Mostra um AlertDialog como no FormTipoManutencao
      showDialog(
        context: context,
        builder:
            (_) => AlertDialog(
              title: const Text('Sucesso'),
              content: Text(
                'VideoAula salva!\n\n'
                'ID: ${_idController.text}\n'
                'Nome: ${_nomeController.text}\n'
                'Link do Vídeo: ${_linkVideoController.text}\n'
                'Ativo: ${_ativo ? "Sim" : "Não"}',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
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
    _idController.dispose();
    _nomeController.dispose();
    _linkVideoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('VideoAula'),
        backgroundColor: Colors.indigo.shade700,
        elevation: 6,
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
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
                        Icons.videocam,
                        color: Colors.indigo.shade700,
                        size: 48,
                      ), // Ícone personalizado
                      const SizedBox(height: 16),
                      TextFormField(
                        // Usando TextFormField para validação
                        controller: _idController,
                        decoration: InputDecoration(
                          labelText: 'ID*',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon: const Icon(
                            Icons.numbers,
                          ), // Ícone para ID
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Informe o ID';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 18),
                      TextFormField(
                        // Usando TextFormField para validação
                        controller: _nomeController,
                        decoration: InputDecoration(
                          labelText: 'Nome da VideoAula*',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon: const Icon(Icons.movie), // Ícone de filme
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Informe o nome da VideoAula';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 18),
                      TextFormField(
                        // Usando TextFormField para validação
                        controller: _linkVideoController,
                        decoration: InputDecoration(
                          labelText: 'Link do Vídeo*',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon: const Icon(Icons.link), // Ícone de link
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Informe o link do vídeo';
                          }
                          // Você pode adicionar uma validação de URL mais robusta aqui se quiser
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
