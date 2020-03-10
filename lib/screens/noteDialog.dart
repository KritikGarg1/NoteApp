import 'package:flutter/material.dart';
import 'main.dart';

Color c1 = Color.fromRGBO(210, 145, 188, 1);
Color c2 = Color.fromRGBO(255, 244, 156, 1);
Color c3 = Color.fromRGBO(205, 241, 175, 1);
Color c4 = Color.fromRGBO(149, 180, 204, 1);
Color x = c1;


class NoteDialog extends StatefulWidget {
  @override
  _NoteDialogState createState() => _NoteDialogState();
}

class _NoteDialogState extends State<NoteDialog> {

  Widget saveButton = FlatButton(
    child: Text("Save"),
    onPressed: () {},
  );

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: x,
      title: Text("Note"),
      content: Container(
          width: w * 0.7,
          child: TextField(
            decoration: InputDecoration.collapsed(hintText: 'Write your note'),
            expands: false,
            maxLines: 15,
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 20),
          )),
      actions: [
    ClipOval(
    child: Material(
    color: c1, // button color
      child: InkWell(
        // inkwell color
        child: Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 3)),
          width: 36,
          height: 36,
        ),
        onTap: () {
          setState(() {x=c1;});
        },
      ),
    ),
    ),
    ClipOval(
      child: Material(
        color: c2, // button color
        child: InkWell(
          // inkwell color
          child: Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 3)),
            width: 36,
            height: 36,
          ),
          onTap: () {
            setState(() {x=c2;});
          },
        ),
      ),
    ),
    ClipOval(
      child: Material(
        color: c3, // button color
        child: InkWell(
          // inkwell color
          child: Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 3)),
            width: 36,
            height: 36,
          ),
          onTap: () {
            setState(() {x=c3;});
          },
        ),
      ),
    ),
    ClipOval(
      child: Material(
        color: c4, // button color
        child: InkWell(
          // inkwell color
          child: Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 3)),
            width: 36,
            height: 36,
          ),
          onTap: () {
            setState(() {x=c4;});
          },
        ),
      ),
    ),
        saveButton,
      ],
    );
  }
}
