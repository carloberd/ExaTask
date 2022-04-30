import 'package:exa_task/pages/home.dart';
import 'package:exa_task/pages/new_note.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      initialRoute: '/',
      // home: const Home(),
      routes: {
        '/': (context) => const Home(),
        '/new-note': (context) => const NewNote(),
        // '/note-details': (context) => NoteDetails()
      },
    );
  }
}
