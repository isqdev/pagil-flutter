final _fabricante = '''
CREATE TABLE Fabricante (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  nome TEXT NOT NULL,
  descricao TEXT,
  nome_contato_principal TEXT,
  email_contato TEXT,
  telefone_contato TEXT,
  ativo INTEGER
)
''';

final criarTabelas = [_fabricante];

final insertFabricantes = [
'''
INSERT INTO Fabricante (nome, descricao, nome_contato_principal, email_contato, telefone_contato, ativo)
VALUES (
  'Peloton',
  'Líder em bicicletas de spinning interativas com aulas online.',
  'Alexandre Costa',
  'contato@onepeloton.com',
  '(21) 98765-4321',
  1
)
''',
'''

INSERT INTO Fabricante (nome, descricao, nome_contato_principal, email_contato, telefone_contato, ativo)
VALUES (
  'NordicTrack',
  'Fabricante de equipamentos de fitness com integração iFit.',
  'Beatriz Souza',
  'suporte@nordictrack.com',
  '(11) 99876-5432',
  1
)

''',
'''
INSERT INTO Fabricante (nome, descricao, nome_contato_principal, email_contato, telefone_contato, ativo)
VALUES (
  'Stryde',
  'Bicicletas de spinning inteligentes com experiência de treino personalizável.',
  'Carlos Pereira',
  'vendas@strydebike.com',
  '(31) 97654-3210',
  1
)

''',
'''
INSERT INTO Fabricante (nome, descricao, nome_contato_principal, email_contato, telefone_contato, ativo)
VALUES (
  'Echelon',
  'Concorrente da Peloton, com bicicletas conectadas e uma vasta biblioteca de aulas.',
  'Mariana Lima',
  'info@echelonfit.com',
  '(41) 96543-2109',
  1
);

''',
'''
INSERT INTO Fabricante (nome, descricao, nome_contato_principal, email_contato, telefone_contato, ativo)
VALUES (
  'Sole Fitness',
  'Equipamentos de fitness para uso doméstico, conhecidos pela durabilidade.',
  'Roberto Mendes',
  'atendimento@solefitness.com',
  '(51) 95432-1098',
  0
)

'''
];
