import 'package:flutter/material.dart';
import 'package:note_pad/new_note.dart';
import 'package:note_pad/update_note.dart';
import 'home_page.dart';
import 'model/note_box.dart';


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




class RouteGenerator {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/create':
        return MaterialPageRoute(
            builder: (context) => const CreateNoteScreen());

      case '/':
        return MaterialPageRoute(
            builder: (context) => const MyHomePage(title: "Note pad app"));

      case '/update':
        return MaterialPageRoute(
            builder: (context) =>
                UpdateNoteScreen(toko: settings.arguments as Toko));
    }
    return null;
  }
}
