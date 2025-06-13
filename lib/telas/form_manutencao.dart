import 'package:flutter/material.dart';
import '../dto/dto_manutencao.dart';

class FormTipoManutencao extends StatefulWidget {
  @override
  _FormTipoManutencaoState createState() => _FormTipoManutencaoState();
}

class _FormTipoManutencaoState extends State<FormTipoManutencao> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  bool _ativo = true;

  void _salvar() {
    if (_formKey.currentState!.validate()) {
      final tipoManutencao = TipoManutencaoDTO(
        id: UniqueKey().toString(),
        nome: _nomeController.text,
        descricao: _descricaoController.text.isNotEmpty ? _descricaoController.text : null,
        ativo: _ativo,
      );
      // Aqui você pode usar tipoManutencao para salvar ou enviar os dados
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Sucesso'),
          content: Text(
            'Tipo de Manutenção salvo!\n\n'
            'Nome: ${tipoManutencao.nome}\n'
            'Descrição: ${tipoManutencao.descricao ?? "-"}\n'
            'Ativo: ${tipoManutencao.ativo ? "Sim" : "Não"}'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Future.delayed(const Duration(milliseconds: 400), () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    '/lista-manutencao',
                    (route) => false,
                  );
                });
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
      _formKey.currentState!.reset();
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
        title: Text('Tipo de Manutenção'),
        backgroundColor: Colors.red.shade700, // vermelho
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
                      Icon(Icons.build, color: Colors.red.shade700, size: 48),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: _nomeController,
                        decoration: InputDecoration(
                          labelText: 'Nome*',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          prefixIcon: Icon(Icons.edit),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Informe o nome';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 18),
                      TextFormField(
                        controller: _descricaoController,
                        decoration: InputDecoration(
                          labelText: 'Descrição',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          prefixIcon: Icon(Icons.description),
                        ),
                        maxLines: 3,
                      ),
                      SizedBox(height: 18),
                      SwitchListTile(
                        title: Text('Ativo', style: TextStyle(fontWeight: FontWeight.w600)),
                        value: _ativo,
                        activeColor: Colors.red, // vermelho
                        onChanged: (value) {
                          setState(() {
                            _ativo = value;
                          });
                        },
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        tileColor: Colors.red.withOpacity(0.05),
                      ),
                      SizedBox(height: 28),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton.icon(
                          onPressed: _salvar,
                          icon: Icon(Icons.save_alt, color: Colors.white), // Ícone branco
                          label: Text(
                            'Salvar',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white, // Texto branco
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red.shade700, // vermelho
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
