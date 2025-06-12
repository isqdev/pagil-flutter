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
  static const String aluno = '/aluno';
  static const String videoAula = '/videoaula';
  static const String fabricante = '/fabricante';
  static const String sala = '/sala';
  static const String manutencao = '/manutencao';
  static const String categoriaMusica = '/categoria-musica';
  static const String bandaArtista = '/bandaArtista';
  static const String turma = '/turma';
  static const String listaFabricante = '/lista-fabricante';

  static Map<String, WidgetBuilder> get routes => {
    aluno: (context) => FormAluno(),
    videoAula: (context) => VideoAulaForm(),
    fabricante: (context) => FabricanteForm(),
    sala: (context) => FormSala(),
    manutencao: (context) => FormTipoManutencao(),
    categoriaMusica: (context) => CategoriaMusicaForm(),
    bandaArtista: (context) => BandaArtistaForm(onSubmit: (value) {
      // TODO: implement onSubmit logic
    }),
    turma: (context) => FormTurma(),
    listaFabricante: (context) => const ListaFabricante(),
  };
}
