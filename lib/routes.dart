import 'package:flutter/material.dart';
import 'telas/form_aluno.dart';
import './telas/form_categoria_musica.dart';
import './telas/form_fabricante.dart';
import './telas/form_manutencao.dart';
import './telas/form_sala.dart';
import './telas/tela_dashboard.dart';

class AppRoutes {
  static const String aluno = '/aluno';
  static const String videoAula = '/videoaula';
  static const String fabricante = '/fabricante';
  static const String sala = '/sala';
  static const String manutencao = '/manutencao';
  static const String categoriaMusica = '/categoria-musica';

  static Map<String, WidgetBuilder> get routes => {
    aluno: (context) => FormAluno(),
    //videoAula: (context) => VideoAulaPage(),
    //fabricante: (context) => FabricantePage(),
    //sala: (context) => SalaPage(),
    manutencao: (context) => FormTipoManutencao(),
    categoriaMusica: (context) => CategoriaMusicaForm(),
  };
        aluno: (context) => FormAluno(),
        //videoAula: (context) => VideoAulaPage(),
        //fabricante: (context) => FabricantePage(),
        sala: (context) => FormSala(),
        manutencao: (context) => FormTipoManutencao(),
        //categoriaMusica: (context) => CategoriaMusicaPage(),
      };
}
