class DTOFabricante {
  final String? id;
  final String nome;
  final String descricao;
  final String nomeContatoPrincipal;
  final String emailContato;
  final String telefoneContato;
  final bool ativo;

  DTOFabricante({
    this.id,
    required this.nome,
    required this.descricao,
    required this.nomeContatoPrincipal,
    required this.emailContato,
    required this.telefoneContato,
    required this.ativo,
  });

  @override
  String toString() {
    return '''
Nome: $nome
Descrição: $descricao
Contato Principal: $nomeContatoPrincipal
E-mail de Contato: $emailContato
Telefone de Contato: $telefoneContato
Ativo: ${ativo ? 'Sim' : 'Não'}
''';
  }
}
