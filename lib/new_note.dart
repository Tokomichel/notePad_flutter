import 'package:flutter/material.dart';
import 'package:note_pad/model/note.dart';

import 'model/note_box.dart';

class CreateNoteScreen extends StatefulWidget {
  const CreateNoteScreen({super.key});

  @override
  State<CreateNoteScreen> createState() => _CreateNoteScreenState();
}

class _CreateNoteScreenState extends State<CreateNoteScreen> {
  final formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _noteContentController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _noteContentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: const Text("Create a new note"),
        actions: [
          IconButton(
              onPressed: () {
                if(formKey.currentState!.validate())
                {   
                var note =
                    Note(_titleController.text, _noteContentController.text);

                NoteBox.box!.put(note.key(), note);
                Navigator.pop(context);
                }
              },
              icon: const Icon(Icons.save))
        ],
      ),
      body: Form(
        key: formKey,
        child: Column(
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
