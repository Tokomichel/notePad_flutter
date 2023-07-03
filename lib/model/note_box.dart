import 'dart:io';
import 'package:hive/hive.dart';
import 'package:note_pad/model/note.dart';
import 'package:path_provider/path_provider.dart';

class NoteBox {
  static final NoteBox instance = NoteBox();

  static Box? box;

  Future<void> init()
  async {
    Directory dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    Hive.registerAdapter(NoteAdapter());
    NoteBox.box = await Hive.openBox("recipeBox");
    // fin de l'initialisation

    var values = NoteBox.box?.values;

    // if(values == null || values.isEmpty)
    // {
    //    NoteBox.box?.putAll({ for (var e in NoteBox.recipes) e.key() : e });
    // }
  }
}
