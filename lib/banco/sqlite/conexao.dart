import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'script.dart';

class Conexao {
  static Database? _database;

  static Future<Database> get() async {
    if (_database != null) return _database!;

    try {
      if (Platform.isAndroid || Platform.isIOS) {
        final path = join(await getDatabasesPath(), 'database.db');
        await deleteDatabase(path);
        _database = await openDatabase(
          path,
          version: 1,
          onCreate: (db, version) async {
            for (var sql in criarTabelas) {
              await db.execute(sql);
            }
            for (var sql in insertFabricantes) {
              await db.execute(sql);
            }
          },
        );
      } else {
        sqfliteFfiInit();
        final databaseFactory = databaseFactoryFfiWeb;
        _database = await databaseFactory.openDatabase(
          inMemoryDatabasePath,
          options: OpenDatabaseOptions(
            version: 1,
            onCreate: (db, version) async {
              for (var sql in criarTabelas) {
                await db.execute(sql);
              }
              for (var sql in insertFabricantes) {
                await db.execute(sql);
              }
            },
          ),
        );
      }
      return _database!;
    } catch (e) {
      throw Exception('Erro ao abrir o banco de dados: $e');
    }
  }
}