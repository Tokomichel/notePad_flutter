import 'package:flutter/material.dart';
import 'package:note_pad/new_note.dart';

import 'model/note.dart';
import 'model/note_box.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:io';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NoteBox.instance.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      onGenerateRoute: (settings) => RouteGenerator.generateRoute(settings),
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}

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
                  return  NoteCard(note: note,);
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

class NoteCard extends StatelessWidget {
  const NoteCard({super.key, required this.note});

  final Note note;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      elevation: 10,
      shape: const BeveledRectangleBorder(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note.title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.start,
            ),
            Text(
              note.note,
              maxLines: 2,
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}

class RouteGenerator {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/create':
        return MaterialPageRoute(
            builder: (context) => const CreateNoteScreen());

      case '/':
        return MaterialPageRoute(
            builder: (context) => const MyHomePage(title: "Note pad app"));
    }
    return null;
  }
}
