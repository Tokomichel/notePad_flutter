import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import 'model/note_box.dart';
import 'note_card.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ValueListenableBuilder(
          valueListenable: NoteBox.box!.listenable(),
          builder: (context, items, _) {
            List<String>? keys = items.keys.cast<String>().toList();
            return ListView.builder(
                itemCount: keys.length,
                itemBuilder: ((context, index) {
                  final note = items.get(keys[index]);
                  return NoteCard(
                    note: note,
                    cle: keys[index]
                  );
                }));
          }),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // ignore: avoid_print
          print(" On part creer");
          Navigator.pushNamed(context, '/create');
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}