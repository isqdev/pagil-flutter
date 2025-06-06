class DTOTurma {
  final String? id;
  final String nome;
  final String? descricao;
  final List<String> diasSemana;
  final String horaInicio;
  final int duracaoMinutos;
  final String salaId;
  final bool ativo;

  DTOTurma({
    this.id,
    required this.nome,
    this.descricao,
    required this.diasSemana,
    required this.horaInicio,
    required this.duracaoMinutos,
    required this.salaId,
    required this.ativo,
  });

  @override
  String toString() {
    return '''\nNome: $nome\nDescrição: ${descricao ?? ''}\nDias da Semana: ${diasSemana.join(", ")}\nHora de Início: $horaInicio\nDuração (min): $duracaoMinutos\nSala: $salaId\nAtivo: ${ativo ? 'Sim' : 'Não'}\n''';
  }
}