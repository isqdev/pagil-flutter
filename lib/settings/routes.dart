import 'package:flutter/material.dart';
import 'package:pagil_flutter/telas/form_banda_artista.dart';
import 'package:pagil_flutter/telas/form_turma.dart';
import '../telas/form_aluno.dart';
import '../telas/form_categoria_musica.dart';
import '../telas/form_fabricante.dart';
import '../telas/form_manutencao.dart';
import '../telas/form_sala.dart';
import '../telas/tela_dashboard.dart';
import '../telas/form_video_aula.dart';
import '../telas/lista_fabricante.dart';


class AppRoutes {
  static const String dashboard = '/'; // Adicionado para clareza
  static const String alunoForm =
      '/aluno-form'; // Renomeado para consistência com 'form'
  static const String listaAluno =
      '/lista-aluno'; // **NOVA ROTA PARA LISTA DE ALUNOS**
  static const String videoAulaForm =
      '/videoaula-form'; // Renomeado para consistência
  static const String fabricanteForm =
      '/fabricante-form'; // Renomeado para consistência
  static const String listaFabricante = '/lista-fabricante';

  static Map<String, WidgetBuilder> get routes => {
    dashboard: (context) => TelaDashboard(), // Rota raiz do aplicativo
    alunoForm: (context) => FormAluno(),
    listaAluno: (context) => const ListaAluno(), // **Adicione esta linha**
    videoAulaForm: (context) => VideoAulaForm(),
    fabricanteForm: (context) => FabricanteForm(),
    listaFabricante: (context) => const ListaFabricante(),
  };
}
