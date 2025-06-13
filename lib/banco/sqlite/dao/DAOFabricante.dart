import 'package:sqflite/sqflite.dart';
import '../conexao.dart';
import '../../../dto/dto_fabricante.dart';

class DAOFabricante {
  final String _columnId = 'id';
  final String _columnNome = 'nome';
  final String _columnDescricao = 'descricao';
  final String _columnNomeContatoPrincipal = 'nome_contato_principal';
  final String _columnEmailContato = 'email_contato';
  final String _columnTelefoneContato = 'telefone_contato';
  final String _columnAtivo = 'ativo';

  final String _insertSql = '''
    INSERT INTO Fabricante (
      nome, descricao, nome_contato_principal, email_contato, telefone_contato, ativo
    ) VALUES (?, ?, ?, ?, ?, ?)
  ''';

  final String _updateSql = '''
    UPDATE Fabricante SET
      nome = ?, descricao = ?, nome_contato_principal = ?, email_contato = ?, telefone_contato = ?, ativo = ?
    WHERE id = ?
  ''';

  final String _selectAllSql = 'SELECT * FROM Fabricante';
  final String _selectByIdSql = 'SELECT * FROM Fabricante WHERE id = ?';
  final String _deleteSql = 'DELETE FROM Fabricante WHERE id = ?';

  /// Salva ou altera um DTOFabricante no banco de dados.
  /// Se o DTO tiver um ID, ele será atualizado. Caso contrário, será inserido.
  Future<void> salvar(DTOFabricante dto) async {
    final db = await Conexao.get();
    if (dto.id != null) {
      await db.rawUpdate(_updateSql, [
        dto.nome,
        dto.descricao,
        dto.nomeContatoPrincipal,
        dto.emailContato,
        dto.telefoneContato,
        dto.ativo ? 1 : 0,
        dto.id,
      ]);
    } else {
      await db.rawInsert(_insertSql, [
        dto.nome,
        dto.descricao,
        dto.nomeContatoPrincipal,
        dto.emailContato,
        dto.telefoneContato,
        dto.ativo ? 1 : 0,
      ]);
    }
  }

  /// Consulta todos os fabricantes no banco de dados.
  Future<List<DTOFabricante>> consultarTodos() async {
    final db = await Conexao.get();
    final result = await db.rawQuery(_selectAllSql);
    return result.map((map) => _fromMap(map)).toList();
  }

  /// Consulta um fabricante por ID.
  Future<DTOFabricante?> consultarPorId(int id) async {
    final Database db = await Conexao.get();
    final List<Map<String, dynamic>> maps = await db.rawQuery(_selectByIdSql, [id]);
    if (maps.isNotEmpty) {
      return _fromMap(maps.first);
    }
    return null;
  }

  /// Exclui um fabricante do banco de dados pelo ID.
  Future<void> excluir(int id) async {
    final Database db = await Conexao.get();
    await db.rawDelete(_deleteSql, [id]);
  }

  /// Converte um Map<String, dynamic> (vindo do banco de dados) para um objeto DTOFabricante.
  DTOFabricante _fromMap(Map<String, dynamic> map) {
    return DTOFabricante(
      id: map[_columnId]?.toString(),
      nome: map[_columnNome] ?? '',
      descricao: map[_columnDescricao] ?? '',
      nomeContatoPrincipal: map[_columnNomeContatoPrincipal] ?? '',
      emailContato: map[_columnEmailContato] ?? '',
      telefoneContato: map[_columnTelefoneContato] ?? '',
      ativo: (map[_columnAtivo] == 1 || map[_columnAtivo] == true),
    );
  }
}
