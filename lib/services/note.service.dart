import 'package:exa_task/db/db.dart';
import 'package:exa_task/models/nota.dart';

const String tableNotes = 'note';

Future<int> create(Note note) async {
  final db = await NoteDatabase.instance.database;
  try {
    final id = await db.insert(tableNotes, note.toJson());
    // return note.copy(id: id);
    return 1;
  } catch (e) {
    return 0;
  }
}

Future<Note> getNote(int id) async {
  final db = await NoteDatabase.instance.database;
  final maps = await db.rawQuery(
    '''
      select *
      from note
      where _id = ?
      ''',
    [id],
  );

  if (maps.isNotEmpty) {
    return Note.fromJson(maps.first);
  } else {
    throw Exception('Note with given ID not found');
  }
}

Future<List<Note>> list() async {
  final db = await NoteDatabase.instance.database;
  final data = await db.rawQuery(
    '''
      select *
      from note
      order by deadline asc
      ''',
  );

  return data.map((e) => Note.fromJson(e)).toList();
}

Future<int> update(Note note) async {
  final db = await NoteDatabase.instance.database;
  try {
    return await db.update(
      tableNotes,
      note.toJson(),
      where: '${NoteFields.id} = ?',
      whereArgs: [note.id],
    );
  } catch (e) {
    return -1;
  }
}

Future<int> delete(int id) async {
  final db = await NoteDatabase.instance.database;
  return await db.delete(
    tableNotes,
    where: '${NoteFields.id} = ?',
    whereArgs: [id],
  );
}

Future closeDB() async {
  final db = await NoteDatabase.instance.database;
  db.close();
}
