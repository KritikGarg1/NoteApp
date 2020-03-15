import 'package:flutter/material.dart';
import 'package:sqlite/main.dart';
import 'note.dart';
import 'package:sqlite/models/noteModel.dart';
import 'package:sqlite/utils/db_helper.dart';

Color c1 = Color.fromRGBO(240, 175, 190, 1);
Color c2 = Color.fromRGBO(255, 234, 176, 1);
Color c3 = Color.fromRGBO(215, 241, 185, 1);
Color c4 = Color.fromRGBO(169, 190, 240, 1);
Color x = c1;

int colorSel = 1;
String name;
int curUserId;
int color;
Future<List<Note>> notes;
var dbHelper;

refresh() {
  dbHelper = DBHelper();
  notes = dbHelper.getNotes();
}

TextEditingController ctrl = TextEditingController();

class NoteDialog extends StatefulWidget {
  @override
  NoteDialogState createState() => NoteDialogState();
}

class NoteDialogState extends State<NoteDialog> {
  var dbHelper;
  bool isUpdating;

  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
    isUpdating = false;
    refreshList();
  }

  refreshList() {
    setState(() {
      notes = dbHelper.getNotes();
    });
  }

  clearName() {
    ctrl.text = '';
  }

  validateX() {
    if (isUpdating) {
      Note e = Note(curUserId, name, color);
      dbHelper.update(e);
      setState(() {
        isUpdating = false;
      });
    } else {
      Note e = Note(null, name, color);
      dbHelper.save(e);
      print("validated");
    }
    clearName();
    refreshList();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      contentPadding: EdgeInsets.all(30),
      backgroundColor: x,
      title: Row(
        children: <Widget>[
          Text("Note"),

        ],
      ),
      content: Container(
          width: w * 0.7,
          child: TextFormField(
            decoration: InputDecoration.collapsed(hintText: 'Write your note'),
            expands: false,
            maxLines: 15,
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 20),
            controller: ctrl,
            validator: (val) => val.length == 0 ? 'Enter Name' : null,
            onSaved: (val) => name = val,
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
                setState(() {
                  x = c1;
                  colorSel = 1;
                });
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
                setState(() {
                  x = c2;
                  colorSel = 2;
                });
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
                setState(() {
                  x = c3;
                  colorSel = 3;
                });
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
                setState(() {
                  x = c4;
                  colorSel = 4;
                });
              },
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        FlatButton(
          color: Colors.white,
          padding: EdgeInsets.all(5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          child: Text(
            "SAVE",
            style: TextStyle(color: Colors.black87, fontSize: 15),
          ),
          onPressed: () {
            name = ctrl.text;
            color = colorSel;
            print(curUserId);
            print(name);
            print(color);
            Navigator.pop(context);
            validateX();
            ctrl.text = '';
          },
        ),
        SizedBox(
          width: 10,
        ),
      ],
    );
  }
}
