import 'package:flutter/material.dart';

// Supondo que você já tenha a classe DTOAluno criada em outro arquivo
import '../dto/dto_aluno.dart';

class FormAluno extends StatefulWidget {
  const FormAluno({Key? key}) : super(key: key);

  @override
  State<FormAluno> createState() => _FormAlunoState();
}

class _FormAlunoState extends State<FormAluno> {
  final _formKey = GlobalKey<FormState>();

  // Controladores dos campos
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _dataNascController = TextEditingController();
  String? _genero;
  final _telefoneController = TextEditingController();
  final _instagramController = TextEditingController();
  final _facebookController = TextEditingController();
  final _tiktokController = TextEditingController();
  bool _ativo = true;

  final List<String> _generos = [
    'Masculino',
    'Feminino',
    'Outro',
    'Prefiro não informar',
  ];

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _dataNascController.dispose();
    _telefoneController.dispose();
    _instagramController.dispose();
    _facebookController.dispose();
    _tiktokController.dispose();
    super.dispose();
  }

  void _salvar() {
    if (_formKey.currentState!.validate()) {
      final dtoAluno = DTOAluno(
        nome: _nomeController.text.trim(),
        email: _emailController.text.trim(),
        dataNascimento: _dataNascController.text.trim(),
        genero: _genero!,
        telefoneContato: _telefoneController.text.trim(),
        perfilInstagram: _instagramController.text.trim().isEmpty ? null : _instagramController.text.trim(),
        perfilFacebook: _facebookController.text.trim().isEmpty ? null : _facebookController.text.trim(),
        perfilTiktok: _tiktokController.text.trim().isEmpty ? null : _tiktokController.text.trim(),
        ativo: _ativo,
      );

      showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: const Text('Dados do Aluno'),
            content: SingleChildScrollView(
              child: Text(dtoAluno.toString()),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                  Future.delayed(const Duration(milliseconds: 400), () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      '/lista-aluno',
                      (route) => false,
                    );
                  });
                },
                child: const Text('Fechar'),
              ),
            ],
          );
        },
      );
    }
  }

  String? _validaNome(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Informe o nome completo.';
    }
    return null;
  }

  String? _validaEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Informe o e-mail.';
    }
    final emailRegex = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$');
    if (!emailRegex.hasMatch(value.trim())) {
      return 'E-mail inválido.';
    }
    return null;
  }

  String? _validaDataNasc(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Informe a data de nascimento.';
    }
    // Formato esperado: AAAA-MM-DD
    final regex = RegExp(r'^\d{4}-\d{2}-\d{2}$');
    if (!regex.hasMatch(value.trim())) {
      return 'Data deve estar no formato AAAA-MM-DD.';
    }
    // Opcional: checar se é uma data válida.
    return null;
  }

  String? _validaGenero(String? value) {
    if (value == null || value.isEmpty) {
      return 'Selecione o gênero.';
    }
    return null;
  }

  String? _validaTelefone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Informe o telefone de contato.';
    }
    // Exemplo de máscara (99) 99999-9999
    final regex = RegExp(r'^\(\d{2}\) \d{5}-\d{4}$');
    if (!regex.hasMatch(value.trim())) {
      return 'Telefone deve estar no formato (99) 99999-9999.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Aluno'),
        backgroundColor: Colors.green.shade700,
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
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.person, color: Colors.green.shade700, size: 48),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _nomeController,
                        decoration: InputDecoration(
                          labelText: 'Nome completo *',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          prefixIcon: const Icon(Icons.person),
                        ),
                        validator: _validaNome,
                      ),
                      const SizedBox(height: 18),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'E-mail *',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          prefixIcon: const Icon(Icons.email),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: _validaEmail,
                      ),
                      const SizedBox(height: 18),
                      TextFormField(
                        controller: _dataNascController,
                        decoration: InputDecoration(
                          labelText: 'Data de nascimento * (AAAA-MM-DD)',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          prefixIcon: const Icon(Icons.cake),
                        ),
                        keyboardType: TextInputType.datetime,
                        validator: _validaDataNasc,
                      ),
                      const SizedBox(height: 18),
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Gênero *',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          prefixIcon: const Icon(Icons.wc),
                        ),
                        value: _genero,
                        items: _generos.map((g) => DropdownMenuItem(value: g, child: Text(g))).toList(),
                        onChanged: (val) => setState(() => _genero = val),
                        validator: _validaGenero,
                      ),
                      const SizedBox(height: 18),
                      TextFormField(
                        controller: _telefoneController,
                        decoration: InputDecoration(
                          labelText: 'Telefone de contato * (ex: (41) 91234-5678)',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          prefixIcon: const Icon(Icons.phone),
                        ),
                        keyboardType: TextInputType.phone,
                        validator: _validaTelefone,
                      ),
                      const SizedBox(height: 18),
                      TextFormField(
                        controller: _instagramController,
                        decoration: InputDecoration(
                          labelText: 'Perfil Instagram',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          prefixIcon: const Icon(Icons.camera_alt),
                        ),
                      ),
                      const SizedBox(height: 18),
                      TextFormField(
                        controller: _facebookController,
                        decoration: InputDecoration(
                          labelText: 'Perfil Facebook',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          prefixIcon: const Icon(Icons.facebook),
                        ),
                      ),
                      const SizedBox(height: 18),
                      TextFormField(
                        controller: _tiktokController,
                        decoration: InputDecoration(
                          labelText: 'Perfil TikTok',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          prefixIcon: const Icon(Icons.music_note),
                        ),
                      ),
                      const SizedBox(height: 18),
                      SwitchListTile(
                        title: const Text('Ativo', style: TextStyle(fontWeight: FontWeight.w600)),
                        value: _ativo,
                        activeColor: Colors.green, // verde
                        onChanged: (v) => setState(() => _ativo = v),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        tileColor: Colors.green.withOpacity(0.05),
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
                            backgroundColor: Colors.green.shade700, // verde
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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