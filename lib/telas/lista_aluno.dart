import 'package:flutter/material.dart';

// Definindo as classes DTO aqui para que o código seja autocontido.
// Em um projeto real, essas classes estariam em arquivos separados (ex: dto.dart, dto_aluno.dart).

abstract class DTO {
  final int? id;
  final String nome;
  DTO({this.id, required this.nome});
}

class DTOAluno extends DTO {
  final String email;
  final String dataNascimento; // Formato AAAA-MM-DD
  final String genero;
  final String telefoneContato;
  final String? perfilInstagram;
  final String? perfilFacebook;
  final String? perfilTiktok;
  final bool ativo;

  DTOAluno({
    super.id,
    required super.nome,
    required this.email,
    required this.dataNascimento,
    required this.genero,
    required this.telefoneContato,
    this.perfilInstagram,
    this.perfilFacebook,
    this.perfilTiktok,
    this.ativo = true,
  });

  // Método para converter DTOAluno para Map (útil para sqflite)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'email': email,
      'dataNascimento': dataNascimento,
      'genero': genero,
      'telefoneContato': telefoneContato,
      'perfilInstagram': perfilInstagram,
      'perfilFacebook': perfilFacebook,
      'perfilTiktok': perfilTiktok,
      'ativo': ativo ? 1 : 0, // SQLite armazena booleanos como 0 ou 1
    };
  }

  // Método para criar DTOAluno a partir de um Map (útil para sqflite)
  factory DTOAluno.fromMap(Map<String, dynamic> map) {
    return DTOAluno(
      id: map['id'],
      nome: map['nome'],
      email: map['email'],
      dataNascimento: map['dataNascimento'],
      genero: map['genero'],
      telefoneContato: map['telefoneContato'],
      perfilInstagram: map['perfilInstagram'],
      perfilFacebook: map['perfilFacebook'],
      perfilTiktok: map['perfilTiktok'],
      ativo: map['ativo'] == 1, // Converte 0/1 de volta para boolean
    );
  }

  @override
  String toString() {
    return 'DTOAluno(id: $id, nome: $nome, email: $email, genero: $genero, ativo: $ativo)';
  }
}

// Mock de lista de DTOAluno (dados contextualizados para alunos de spinning)
// -----------------------------------------------------------------------------
final List<DTOAluno> mockAlunos = [
  DTOAluno(
    id: 1,
    nome: 'Paula Fernandes',
    email: 'paula.fernandes@email.com',
    dataNascimento: '1995-03-15',
    genero: 'Feminino',
    telefoneContato: '(41) 98765-4321',
    perfilInstagram: '@paulaspin',
    ativo: true,
  ),
  DTOAluno(
    id: 2,
    nome: 'Ricardo Souza',
    email: 'ricardo.souza@email.com',
    dataNascimento: '1988-11-22',
    genero: 'Masculino',
    telefoneContato: '(11) 99876-5432',
    perfilFacebook: 'ricardosouzaoficial',
    ativo: true,
  ),
  DTOAluno(
    id: 3,
    nome: 'Mariana Lima',
    email: 'mariana.lima@email.com',
    dataNascimento: '2000-07-01',
    genero: 'Feminino',
    telefoneContato: '(21) 97654-3210',
    perfilTiktok: '@marianaspin',
    ativo: false, // Aluno inativo
  ),
  DTOAluno(
    id: 4,
    nome: 'Gustavo Santos',
    email: 'gustavo.santos@email.com',
    dataNascimento: '1992-09-10',
    genero: 'Masculino',
    telefoneContato: '(31) 96543-2109',
    perfilInstagram: '@gusta_spinning',
    perfilFacebook: 'gustavo.santos.spinning',
    ativo: true,
  ),
  DTOAluno(
    id: 5,
    nome: 'Larissa Costa',
    email: 'larissa.costa@email.com',
    dataNascimento: '1998-04-25',
    genero: 'Feminino',
    telefoneContato: '(51) 95432-1098',
    ativo: true,
  ),
];

// Widget ListaAluno
// -----------------------------------------------------------------------------
class ListaAluno extends StatefulWidget {
  const ListaAluno({Key? key}) : super(key: key);

  @override
  State<ListaAluno> createState() => _ListaAlunoState();
}

class _ListaAlunoState extends State<ListaAluno> {
  // A lista de alunos que será exibida e potencialmente modificada (no mock)
  late List<DTOAluno> _alunos;

  @override
  void initState() {
    super.initState();
    // Cria uma cópia mutável do mock para que possamos remover itens
    _alunos = List.from(mockAlunos);
  }

  // Método para simular o carregamento assíncrono de alunos (como de um DB)
  Future<List<DTOAluno>> _carregarAlunos() async {
    // Atraso artificial para demonstrar o CircularProgressIndicator
    await Future.delayed(const Duration(seconds: 1));
    return _alunos; // Retorna a lista atual de alunos (mock)
  }

  // Método para lidar com a ação de Alterar um aluno
  void _alterarAluno(DTOAluno aluno) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Ação: Alterar Aluno - ${aluno.toString()}'),
        backgroundColor: Colors.orange, // Cor laranja conforme pedido
        duration: const Duration(seconds: 2),
      ),
    );
    // Em um cenário real, você navegaria para uma tela de formulário de edição
    // passando o 'aluno' como argumento para preencher os campos.
  }

  // Método para lidar com a ação de Excluir um aluno
  void _excluirAluno(DTOAluno aluno) {
    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: const Text('Confirmar Exclusão'),
            content: Text('Deseja realmente excluir o aluno "${aluno.nome}"?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(), // Fecha o diálogo
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    // Remove o aluno da lista local do mock
                    _alunos.removeWhere((a) => a.id == aluno.id);
                  });
                  Navigator.of(ctx).pop(); // Fecha o diálogo após a exclusão
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Ação: Aluno "${aluno.nome}" excluído (mock).',
                      ),
                      backgroundColor:
                          Colors.red, // Cor vermelha conforme pedido
                      duration: const Duration(seconds: 2),
                    ),
                  );
                  // Em um cenário real, você chamaria um método do seu DAO/Repository
                  // para excluir o aluno do banco de dados e então atualizaria a UI.
                },
                child: const Text(
                  'Excluir',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Alunos'),
        backgroundColor: Colors.green.shade700, // Tom de verde para Aluno
        centerTitle: true,
        elevation: 6,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
        ),
      ),
      body: FutureBuilder<List<DTOAluno>>(
        future: _carregarAlunos(), // Nosso Future que simula o carregamento
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Mostra um indicador de progresso enquanto carrega
            return const Center(
              child: CircularProgressIndicator(color: Colors.green),
            );
          } else if (snapshot.hasError) {
            // Mostra uma mensagem de erro se algo der errado
            return Center(
              child: Text(
                'Erro ao carregar alunos: ${snapshot.error}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            // Mostra uma mensagem se não houver dados
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.person_off, size: 60, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'Nenhum aluno encontrado.',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            );
          } else {
            // Se os dados foram carregados com sucesso, exibe a lista
            final List<DTOAluno> alunosCarregados = snapshot.data!;
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: alunosCarregados.length,
              separatorBuilder:
                  (_, __) =>
                      const SizedBox(height: 12), // Espaçamento entre os itens
              itemBuilder: (context, index) {
                final aluno = alunosCarregados[index];
                return Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    leading: CircleAvatar(
                      backgroundColor:
                          aluno.ativo ? Colors.green[100] : Colors.grey[300],
                      child: Icon(
                        Icons.person,
                        color:
                            aluno.ativo ? Colors.green[700] : Colors.grey[700],
                      ),
                    ),
                    title: Text(
                      aluno.nome,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Email: ${aluno.email}'),
                        Text('Gênero: ${aluno.genero}'),
                        Text('Tel: ${aluno.telefoneContato}'),
                        if (aluno.perfilInstagram != null &&
                            aluno.perfilInstagram!.isNotEmpty)
                          Text('Instagram: ${aluno.perfilInstagram}'),
                        Text(
                          aluno.ativo ? 'Status: Ativo' : 'Status: Inativo',
                          style: TextStyle(
                            color: aluno.ativo ? Colors.green : Colors.red,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.orange,
                          ), // Ícone de Alterar
                          tooltip: 'Alterar Aluno',
                          onPressed: () => _alterarAluno(aluno),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ), // Ícone de Excluir
                          tooltip: 'Excluir Aluno',
                          onPressed: () => _excluirAluno(aluno),
                        ),
                      ],
                    ),
                    onTap: () {
                      // Opcional: exibe detalhes completos do aluno em um AlertDialog ao tocar no item
                      showDialog(
                        context: context,
                        builder:
                            (ctx) => AlertDialog(
                              title: Text(aluno.nome),
                              content: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text('ID: ${aluno.id ?? 'Não definido'}'),
                                    Text('Email: ${aluno.email}'),
                                    Text('Nascimento: ${aluno.dataNascimento}'),
                                    Text('Gênero: ${aluno.genero}'),
                                    Text('Telefone: ${aluno.telefoneContato}'),
                                    if (aluno.perfilInstagram != null &&
                                        aluno.perfilInstagram!.isNotEmpty)
                                      Text(
                                        'Instagram: ${aluno.perfilInstagram}',
                                      ),
                                    if (aluno.perfilFacebook != null &&
                                        aluno.perfilFacebook!.isNotEmpty)
                                      Text('Facebook: ${aluno.perfilFacebook}'),
                                    if (aluno.perfilTiktok != null &&
                                        aluno.perfilTiktok!.isNotEmpty)
                                      Text('TikTok: ${aluno.perfilTiktok}'),
                                    Text(
                                      'Status: ${aluno.ativo ? 'Ativo' : 'Inativo'}',
                                    ),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.of(ctx).pop(),
                                  child: const Text('Fechar'),
                                ),
                              ],
                            ),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

// Exemplo de como usar este widget no seu main.dart
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Alunos',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const ListaAluno(),
    );
  }
}
