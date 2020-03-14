import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlite/models/noteModel.dart';

class DBHelper {
  static Database _db;
  static const String ID = 'id';
  static const String NOTE = 'noteText';
  static const String COLOR = 'clrID';
  static const String TABLE = 'Note';
  static const String DB_NAME = 'note1.db';

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_NAME);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db
        .execute("CREATE TABLE $TABLE ($ID INTEGER PRIMARY KEY, $NOTE TEXT, $COLOR INTEGER)");
  }

  Future<Note> save(Note note) async {
    var dbClient = await db;
    note.id = await dbClient.insert(TABLE, note.toMap());
    return note;
  }

  Future<List<Note>> getNotes() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query(TABLE, columns: [ID,NOTE,COLOR ]);
    List<Note> notes = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        notes.add(Note.fromMap(maps[i]));
      }
    }
    return notes;
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient.delete(TABLE, where: '$ID = ?', whereArgs: [id]);
  }

  Future<int> update(Note note) async {
    var dbClient = await db;
    return await dbClient.update(TABLE, note.toMap(),
        where: '$ID = ?', whereArgs: [note.id]);
  }

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}