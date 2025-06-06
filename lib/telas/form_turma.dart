import 'package:flutter/material.dart';
import '../dto/dto_turma.dart';

class FormTurma extends StatefulWidget {
  const FormTurma({super.key});

  @override
  State<FormTurma> createState() => _FormTurmaState();
}

class _FormTurmaState extends State<FormTurma> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _horaInicioController = TextEditingController();
  final _duracaoController = TextEditingController();
  String? _salaId;
  bool _ativo = true;
  final List<String> _diasSemana = [];

  final List<String> _dias = [
    'Segunda', 'Terça', 'Quarta', 'Quinta', 'Sexta', 'Sábado', 'Domingo'
  ];

  // Exemplo de salas (substitua por busca real se necessário)
  final List<Map<String, String>> _salas = [
    {'id': '1', 'nome': 'Sala 1'},
    {'id': '2', 'nome': 'Sala 2'},
    {'id': '3', 'nome': 'Sala 3'},
  ];

  void _salvar() {
    if (_formKey.currentState!.validate() && _salaId != null && _diasSemana.isNotEmpty) {
      final turma = DTOTurma(
        nome: _nomeController.text.trim(),
        descricao: _descricaoController.text.trim().isEmpty ? null : _descricaoController.text.trim(),
        diasSemana: List.from(_diasSemana),
        horaInicio: _horaInicioController.text.trim(),
        duracaoMinutos: int.parse(_duracaoController.text.trim()),
        salaId: _salaId!,
        ativo: _ativo,
      );
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Turma Salva!'),
          content: Text(turma.toString()),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      _formKey.currentState!.reset();
      setState(() {
        _ativo = true;
        _diasSemana.clear();
        _salaId = null;
      });
    }
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _descricaoController.dispose();
    _horaInicioController.dispose();
    _duracaoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Turma'),
        backgroundColor: Colors.yellow.shade700,
        elevation: 6,
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFF9C4), Color(0xFFFFFDE7)],
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
                      Icon(Icons.class_outlined, color: Colors.yellow.shade700, size: 48),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _nomeController,
                        decoration: InputDecoration(
                          labelText: 'Nome*',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          prefixIcon: const Icon(Icons.edit),
                        ),
                        validator: (v) => v == null || v.trim().isEmpty ? 'Informe o nome' : null,
                      ),
                      const SizedBox(height: 18),
                      TextFormField(
                        controller: _descricaoController,
                        decoration: InputDecoration(
                          labelText: 'Descrição',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          prefixIcon: const Icon(Icons.description),
                        ),
                        maxLines: 2,
                      ),
                      const SizedBox(height: 18),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Dias da Semana*', style: TextStyle(fontWeight: FontWeight.w600)),
                      ),
                      Wrap(
                        spacing: 8,
                        children: _dias.map((dia) => FilterChip(
                          label: Text(dia),
                          selected: _diasSemana.contains(dia),
                          selectedColor: Colors.yellow.shade200,
                          onSelected: (selected) {
                            setState(() {
                              if (selected) {
                                _diasSemana.add(dia);
                              } else {
                                _diasSemana.remove(dia);
                              }
                            });
                          },
                        )).toList(),
                      ),
                      if (_diasSemana.isEmpty)
                        const Padding(
                          padding: EdgeInsets.only(top: 6),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Selecione pelo menos um dia.', style: TextStyle(color: Colors.red, fontSize: 12)),
                          ),
                        ),
                      const SizedBox(height: 18),
                      TextFormField(
                        controller: _horaInicioController,
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: 'Hora de Início* (ex: 08:00)',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          prefixIcon: const Icon(Icons.access_time),
                        ),
                        onTap: () async {
                          final TimeOfDay? picked = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (picked != null) {
                            _horaInicioController.text = picked.format(context);
                          }
                        },
                        validator: (v) {
                          if (v == null || v.trim().isEmpty) return 'Informe a hora de início';
                          final regex = RegExp(r'^(\d{2}):(\d{2})');
                          if (!regex.hasMatch(v.trim())) return 'Formato deve ser HH:MM';
                          return null;
                        },
                      ),
                      const SizedBox(height: 18),
                      TextFormField(
                        controller: _duracaoController,
                        decoration: InputDecoration(
                          labelText: 'Duração (minutos)*',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          prefixIcon: const Icon(Icons.timer),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (v) {
                          if (v == null || v.trim().isEmpty) return 'Informe a duração';
                          if (int.tryParse(v.trim()) == null) return 'Apenas números';
                          return null;
                        },
                      ),
                      const SizedBox(height: 18),
                      DropdownButtonFormField<String>(
                        value: _salaId,
                        decoration: InputDecoration(
                          labelText: 'Sala*',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          prefixIcon: const Icon(Icons.meeting_room),
                        ),
                        items: _salas.map((sala) => DropdownMenuItem(
                          value: sala['id'],
                          child: Text(sala['nome']!),
                        )).toList(),
                        onChanged: (value) {
                          setState(() {
                            _salaId = value;
                          });
                        },
                        validator: (v) => v == null ? 'Selecione uma sala' : null,
                      ),
                      const SizedBox(height: 18),
                      SwitchListTile(
                        title: const Text('Ativo', style: TextStyle(fontWeight: FontWeight.w600)),
                        value: _ativo,
                        activeColor: Colors.yellow,
                        onChanged: (value) {
                          setState(() {
                            _ativo = value;
                          });
                        },
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        tileColor: Colors.yellow.withOpacity(0.05),
                      ),
                      const SizedBox(height: 28),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton.icon(
                          onPressed: _salvar,
                          icon: Icon(Icons.save_alt, color: Colors.white),
                          label: Text(
                            'Salvar',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.yellow.shade700,
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