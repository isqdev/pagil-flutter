import 'package:flutter/material.dart';
import 'package:pagil_flutter/dto/dto_fabricante.dart';

class FabricanteForm extends StatefulWidget {
  @override
  _FabricanteFormState createState() => _FabricanteFormState();
}

class _FabricanteFormState extends State<FabricanteForm> {
  final _formKey = GlobalKey<FormState>(); // Chave para o formulário

  // Controladores para os campos de texto
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _nomeContatoController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();

  bool _ativo = false; // Definindo se está ativo ou não

  // Função para validar o formulário
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Se for válido, você pode fazer o que quiser com os dados
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Dados enviados!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Formulário de Fabricante')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, // Chave do formulário
          child: ListView(
            children: [
              // Campo Nome
              TextFormField(
                controller: _nomeController,
                decoration: InputDecoration(
                  labelText: 'Nome do Fabricante',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nome é obrigatório';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Campo Descrição
              TextFormField(
                controller: _descricaoController,
                decoration: InputDecoration(
                  labelText: 'Descrição',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Descrição é obrigatória';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Campo Nome do Contato Principal
              TextFormField(
                controller: _nomeContatoController,
                decoration: InputDecoration(
                  labelText: 'Nome Contato Principal',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nome do Contato Principal é obrigatório';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Campo E-mail
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'E-mail de Contato',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'E-mail é obrigatório';
                  }
                  if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                    return 'Digite um e-mail válido';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Campo Telefone
              TextFormField(
                controller: _telefoneController,
                decoration: InputDecoration(
                  labelText: 'Telefone de Contato',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Telefone é obrigatório';
                  }
                  if (!RegExp(r'^\+?[0-9]{7,15}$').hasMatch(value)) {
                    return 'Digite um telefone válido';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Checkbox para Ativo
              Row(
                children: [
                  Text('Ativo: '),
                  Checkbox(
                    value: _ativo,
                    onChanged: (bool? value) {
                      setState(() {
                        _ativo = value!;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 16),

              // Botão de Submit
              ElevatedButton(onPressed: _submitForm, child: Text('Enviar')),
            ],
          ),
        ),
      ),
    );
  }
}
