class TipoManutencaoDTO {
  final String id;
  final String nome;
  final String? descricao;
  final bool ativo;

  TipoManutencaoDTO({
    required this.id,
    required this.nome,
    this.descricao,
    this.ativo = true,
  });

  factory TipoManutencaoDTO.fromJson(Map<String, dynamic> json) {
    return TipoManutencaoDTO(
      id: json['id'] as String,
      nome: json['nome'] as String,
      descricao: json['descricao'] as String?,
      ativo: json['ativo'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'descricao': descricao,
      'ativo': ativo,
    };
  }
}