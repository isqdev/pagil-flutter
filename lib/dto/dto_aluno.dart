class DTOAluno {
  final String? id;
  final String nome;
  final String email;
  final String dataNascimento;
  final String genero;
  final String telefoneContato;
  final String? perfilInstagram;
  final String? perfilFacebook;
  final String? perfilTiktok;
  final bool ativo;

  DTOAluno({
    this.id,
    required this.nome,
    required this.email,
    required this.dataNascimento,
    required this.genero,
    required this.telefoneContato,
    this.perfilInstagram,
    this.perfilFacebook,
    this.perfilTiktok,
    required this.ativo,
  });

  @override
  String toString() {
    return '''
Nome: $nome
E-mail: $email
Data de Nascimento: $dataNascimento
Gênero: $genero
Telefone: $telefoneContato
Instagram: ${perfilInstagram ?? ''}
Facebook: ${perfilFacebook ?? ''}
TikTok: ${perfilTiktok ?? ''}
Ativo: $ativo
''';
  }
}