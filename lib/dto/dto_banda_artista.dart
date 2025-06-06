class DTOBandaArtista {
  final String? id;
  final String nome;
  final String? descricaoCurta;
  final String? linkRelacionado;
  final String? urlFotoPerfil;
  final bool ativo;

  DTOBandaArtista({
    this.id,
    required this.nome,
    this.descricaoCurta,
    this.linkRelacionado,
    this.urlFotoPerfil,
    this.ativo = true,
  });

  @override
  String toString() {
    return 'ID: $id\n'
        'Nome: $nome\n'
        'Descrição Curta: ${descricaoCurta ?? "-"}\n'
        'Link Relacionado: ${linkRelacionado ?? "-"}\n'
        'URL Foto Perfil: ${urlFotoPerfil ?? "-"}\n'
        'Ativo: ${ativo ? "Sim" : "Não"}';
  }
}