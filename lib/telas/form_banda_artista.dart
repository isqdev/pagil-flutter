import 'package:flutter/material.dart';
import '../dto/dto_banda_artista.dart';

class BandaArtistaForm extends StatefulWidget {
  final void Function(Map<String, dynamic> data) onSubmit;

  const BandaArtistaForm({Key? key, required this.onSubmit}) : super(key: key);

  @override
  State<BandaArtistaForm> createState() => _BandaArtistaFormState();
}

class _BandaArtistaFormState extends State<BandaArtistaForm> {
  final _formKey = GlobalKey<FormState>();
  final _idController = TextEditingController();
  final _nomeController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _linkRelacionadoController = TextEditingController();
  final _urlFotoPerfilController = TextEditingController();
  bool _ativo = true;

  @override
  void dispose() {
    _idController.dispose();
    _nomeController.dispose();
    _descricaoController.dispose();
    _linkRelacionadoController.dispose();
    _urlFotoPerfilController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      final dto = DTOBandaArtista(
        id: _idController.text.isNotEmpty ? _idController.text : null,
        nome: _nomeController.text,
        descricaoCurta: _descricaoController.text.isNotEmpty ? _descricaoController.text : null,
        linkRelacionado: _linkRelacionadoController.text.isNotEmpty ? _linkRelacionadoController.text : null,
        urlFotoPerfil: _urlFotoPerfilController.text.isNotEmpty ? _urlFotoPerfilController.text : null,
        ativo: _ativo,
      );
      widget.onSubmit({
        'id': dto.id,
        'nome': dto.nome,
        'descricao_curta': dto.descricaoCurta,
        'link_relacionado': dto.linkRelacionado,
        'url_foto_perfil': dto.urlFotoPerfil,
        'ativo': dto.ativo,
      });
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Dados da Banda/Artista'),
          content: SingleChildScrollView(
            child: Text(dto.toString()),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Fechar'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Banda/Artista'),
        backgroundColor: Colors.pink.shade400,
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
                      Icon(Icons.music_note, color: Colors.pink.shade400, size: 48),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _idController,
                        decoration: InputDecoration(
                          labelText: 'ID',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          prefixIcon: const Icon(Icons.confirmation_number),
                        ),
                      ),
                      const SizedBox(height: 18),
                      TextFormField(
                        controller: _nomeController,
                        decoration: InputDecoration(
                          labelText: 'Nome *',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          prefixIcon: const Icon(Icons.person),
                        ),
                        validator: (value) => (value == null || value.isEmpty) ? 'Nome é obrigatório' : null,
                      ),
                      const SizedBox(height: 18),
                      TextFormField(
                        controller: _descricaoController,
                        decoration: InputDecoration(
                          labelText: 'Descrição Curta',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          prefixIcon: const Icon(Icons.description),
                        ),
                        maxLines: 2,
                      ),
                      const SizedBox(height: 18),
                      TextFormField(
                        controller: _linkRelacionadoController,
                        decoration: InputDecoration(
                          labelText: 'Link Relacionado (URL)',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          prefixIcon: const Icon(Icons.link),
                        ),
                        keyboardType: TextInputType.url,
                      ),
                      const SizedBox(height: 18),
                      TextFormField(
                        controller: _urlFotoPerfilController,
                        decoration: InputDecoration(
                          labelText: 'URL Foto Perfil',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          prefixIcon: const Icon(Icons.image),
                        ),
                        keyboardType: TextInputType.url,
                      ),
                      const SizedBox(height: 18),
                      SwitchListTile(
                        title: const Text('Ativo', style: TextStyle(fontWeight: FontWeight.w600)),
                        value: _ativo,
                        activeColor: Colors.pink,
                        onChanged: (v) => setState(() => _ativo = v),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        tileColor: Colors.pink.withOpacity(0.05),
                      ),
                      const SizedBox(height: 28),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton.icon(
                          onPressed: _submit,
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
                            backgroundColor: Colors.pink.shade400,
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