import 'package:flutter/material.dart';
import 'package:note_pad/update_note.dart';
import 'model/note.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({super.key, required this.note, required this.cle});

  final Note note;
  final dynamic cle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "/update", arguments: Toko(note, cle));
      },
      child: Card(
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
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
      ),
    );
  }
}
