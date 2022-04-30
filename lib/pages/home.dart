import 'package:exa_task/models/nota.dart';
import 'package:exa_task/services/note.service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:exa_task/utils/toast.util.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late List<Note> notes = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    listNotes();
  }

  @override
  void dispose() {
    closeDB();
    super.dispose();
  }

  Future listNotes() async {
    setState(() => isLoading = true);
    notes = await list();
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff353334),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Navigator.pushNamed(context, '/new-note').then((value) async {
          if (value == true) {
            listNotes();
            showSuccessToast(context);
          }
        }),
        child: const Icon(
          CupertinoIcons.add,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, right: 20),
        child: Center(
          child: isLoading
              ? const CircularProgressIndicator()
              : notes.isEmpty
                  ? SizedBox(
                      child: Image.asset(
                        'images/note.png',
                        height: 100,
                        width: 100,
                      ),
                    )
                  : buildNotes(),
        ),
      ),
    );
  }

  static const pattern = [
    StairedGridTile(0.5, 2),
    StairedGridTile(0.47, 1.5),
    StairedGridTile(1.0, 3.5),
  ];

  Widget buildNotes() => GridView.custom(
        scrollDirection: Axis.vertical,
        gridDelegate: SliverStairedGridDelegate(
          mainAxisSpacing: 24,
          crossAxisSpacing: 48,
          startCrossAxisDirectionReversed: true,
          pattern: pattern,
        ),
        childrenDelegate: SliverChildBuilderDelegate(
          (context, index) {
            final tile = pattern[index % pattern.length];
            return Container(
              color: Colors.amber,
              width: (tile.aspectRatio * 100),
              height: 100,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      notes[index].title +
                          ' #' +
                          notes[index].number.toString(),
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(notes[index].description),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Text(
                          notes[index]
                              .deadline
                              .toIso8601String()
                              .substring(0, 10),
                        ),
                        const Spacer(),
                        Text(
                          notes[index].priority,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            '/new-note',
                            arguments: notes[index],
                          ).then((res) {
                            if (res == true) {
                              listNotes();
                              showEditToast(context);
                            }
                          });
                        },
                        icon: const Icon(Icons.edit_outlined),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline),
                        onPressed: () {
                          delete(notes[index].id!);
                          listNotes();
                          showDeleteToast(context);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
          childCount: notes.length,
        ),
      );
}
