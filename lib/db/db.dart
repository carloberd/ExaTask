import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class NoteDatabase {
  static final NoteDatabase instance = NoteDatabase._init();

  static Database? _database;

  NoteDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('note.db');
    return _database!;
  }

  Future<Database> _initDB(String filepath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filepath);
    //path ==> /Users/carloberd/Library/Containers/com.example.exaTask/Data/Documents/note.db
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      create table note (
        _id integer primary key autoincrement,
        title text not null,
        number integer not null,
        description text not null,
        priority text not null,
        deadline text
      )
      ''');
  }
}
