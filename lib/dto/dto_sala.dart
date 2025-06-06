class DTOSala {
  final String? id;
  final String nome;
  final int capacidade_total_bikes;
  final int numero_filas;
  final int numero_bikes_por_fila;
  final bool ativo;

  DTOSala({
    this.id,
    required this.nome,
    required this.capacidade_total_bikes,
    required this.numero_filas,
    required this.numero_bikes_por_fila,
    required this.ativo,
  });

  @override
  String toString() {
    return '''
Nome: $nome
Capacidade Total de Bikes: $capacidade_total_bikes
Número de Filas: $numero_filas
Número de Bikes por Fila: $numero_bikes_por_fila
Ativo: $ativo
''';
  }
}