
import 'dart:io';

import 'package:QRnathan/models/scan_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbProviders{


  static Database _database;
  static final db = DbProviders._();
  DbProviders._();


  Future<Database> get getdatabase async {

    if (_database != null) {
      return _database;
    }

    _database = await initDatabase();

    return _database;

  }


  Future <Database> initDatabase()async {

    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    final path = join(documentsDirectory.path,"ScansDb.db");

    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version)  async{
        db.execute('''
        CREATE TABLE Scans (
          id INTEGER PRIMARY KEY,
          tipo TEXT,
          valor TEXT
        )
        ''');

      }

    );

  }


  Future<int> nuevoScan(ScanModel scan)async{

    final db = await getdatabase;

    final respuesta = await db.insert('Scans', scan.toMap());

    return respuesta;


  }

  Future<ScanModel>obtenerScanID(int id) async{

    final db = await getdatabase;

    final respuesta = await db.query("Scans", where: "id=?", whereArgs: [id]);

    return respuesta.isNotEmpty
          ?ScanModel.fromJsonMap(respuesta.first)
          :[];
  }

  Future <List<ScanModel>> obtenerTodosScanss() async{

    final db = await getdatabase;

    final respuesta = await db.query("Scans");

    return respuesta.isNotEmpty
            ? respuesta.map((v) => ScanModel.fromJsonMap(v)).toList()
            :[];

  }



  

  
  Future <int> borrarById(int id) async {
    final db = await getdatabase;
    final respuesta = await db.delete("Scans", where: "id = ?", whereArgs: [id]);

    return respuesta;

  }

  Future <int> borrarByValor(String valor) async {
    final db = await getdatabase;
    final respuesta = await db.delete("Scans", where: "valor = ?", whereArgs: [valor]);

    return respuesta;

  }

  Future <int> borrarTodoScans() async {
    final db = await getdatabase;
    final respuesta = await db.delete("Scans");

    return respuesta;
  }

}