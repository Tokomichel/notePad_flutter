import 'package:hive/hive.dart';

part 'note.g.dart';

@HiveType(typeId: 0)
class Note {
  Note(this.title, this.note);

  @HiveField(1)
  late String title;

  @HiveField(2)
  late String note;

    String key() => title.hashCode.toString();
}
