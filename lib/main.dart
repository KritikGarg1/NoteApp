import 'package:flutter/material.dart';
import 'package:sqlite/screens/note.dart';
import 'package:sqlite/screens/noteDialog.dart';

double w;

void main() => runApp(
      MaterialApp(
        home: MyApp(),
      ),
    );

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    note();
    super.initState();
  }

  Color ctheme = Color.fromRGBO(230, 90, 150, 10);

  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    return new MaterialApp(
      theme: ThemeData(
        accentColor: ctheme,
      ),
      home: Scaffold(
        body: note(),
        appBar: AppBar(
          title: Text(
            "Notes",
            textAlign: TextAlign.center,
          ),
          backgroundColor: ctheme,
          centerTitle: true,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          icon: Icon(Icons.create),
          label: Text(
            "Add Note",
            style: TextStyle(fontFamily: 'Roboto'),
          ),
          onPressed: () {
            showDialog(context: context, builder: (_) => NoteDialog());
            print("tapped");
          },
        ),
      ),
    );
  }
}
