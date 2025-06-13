import 'package:flutter/material.dart';
import 'package:pagil_flutter/telas/form_banda_artista.dart';
import 'package:pagil_flutter/telas/form_turma.dart';
import 'package:pagil_flutter/telas/form_aluno.dart';
import 'package:pagil_flutter/telas/form_categoria_musica.dart';
import 'package:pagil_flutter/telas/form_fabricante.dart';
import 'package:pagil_flutter/telas/form_manutencao.dart';
import 'package:pagil_flutter/telas/form_sala.dart';
import 'package:pagil_flutter/telas/tela_dashboard.dart'; // Mantenha se for sua rota '/'
import 'package:pagil_flutter/telas/form_video_aula.dart';
import 'package:pagil_flutter/telas/lista_fabricante.dart';
import 'package:pagil_flutter/telas/lista_aluno.dart'; // Importe a nova tela ListaAluno

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
  static const String salaForm = '/sala-form'; // Renomeado
  static const String manutencaoForm = '/manutencao-form'; // Renomeado
  static const String categoriaMusicaForm =
      '/categoria-musica-form'; // Renomeado
  static const String bandaArtistaForm = '/banda-artista-form'; // Renomeado
  static const String turmaForm = '/turma-form'; // Renomeado

  static Map<String, WidgetBuilder> get routes => {
    dashboard: (context) => TelaDashboard(), // Rota raiz do aplicativo
    alunoForm: (context) => FormAluno(),
    listaAluno: (context) => const ListaAluno(), // **Adicione esta linha**
    videoAulaForm: (context) => VideoAulaForm(),
    fabricanteForm: (context) => FabricanteForm(),
    listaFabricante: (context) => const ListaFabricante(),
    salaForm: (context) => FormSala(),
    manutencaoForm: (context) => FormTipoManutencao(),
    categoriaMusicaForm: (context) => CategoriaMusicaForm(),
    bandaArtistaForm:
        (context) => BandaArtistaForm(
          onSubmit: (value) {
            // TODO: implement onSubmit logic
          },
        ),
    turmaForm: (context) => FormTurma(),
  };
}
