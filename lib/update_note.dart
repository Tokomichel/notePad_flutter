import 'package:flutter/material.dart';
import 'package:note_pad/model/note.dart';

import 'model/note_box.dart';

class Toko {
  Note note;
  dynamic key;

  Toko(this.note, this.key);
}

class UpdateNoteScreen extends StatefulWidget {
  const UpdateNoteScreen({super.key, required this.toko});

  final Toko toko;

  @override
  // ignore: no_logic_in_create_state
  State<UpdateNoteScreen> createState() => _UpdateNoteScreenState(toko);
}

class _UpdateNoteScreenState extends State<UpdateNoteScreen> {
  final formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _noteContentController = TextEditingController();

  Toko toko;

  _UpdateNoteScreenState(this.toko);

  @override
  void dispose() {
    _titleController.dispose();
    _noteContentController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _titleController.text = toko.note.title;
      _noteContentController.text = toko.note.note;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        appBar: AppBar(
          elevation: 2,
          title: const Text("Create a new note"),
          actions: [
            IconButton(
                onPressed: () {
                  //bouton de sauvegarde
                  if (formKey.currentState!.validate()) {
                    //print("Maintenant c'est box: ${NoteBox.box} et ${formKey.currentState!.validate()}");
                    var note = Note(
                        _titleController.text, _noteContentController.text);
                    NoteBox.box!.put(note.key(), note);
                    Navigator.pop(context);
                  }
                },
                icon: const Icon(Icons.save)),
            IconButton(
                // Bouton de suppression
                onPressed: () {
                  NoteBox.box?.delete(toko.key);
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.delete))
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: "Title",
                ),
                validator: (value) {
                  if (value == null) {
                    return "please enter a title for this note";
                  }

                  return null;
                },
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextFormField(
                  controller: _noteContentController,
                  keyboardType: TextInputType.multiline,
                  maxLines: 10,
                  decoration: const InputDecoration(labelText: "note content"),
                  validator: (value) {
                    if (value == null) {
                      return "Please enter content for this note";
                    }

                    return null;
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
