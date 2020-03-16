import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sqlite/utils/db_helper.dart';
import 'package:sqlite/models/noteModel.dart';
import 'noteDialog.dart';
import 'deleteUI.dart';
import 'package:flutter/services.dart';

Color c;
var map = {
  1: c1,
  2: c2,
  3: c3,
  4: c4,
};
double o1 = 0;
double o2 = 0;
int state = 0;


class note extends StatefulWidget {
  @override
  noteState createState() => noteState();
}

class noteState extends State<note> {
  deleteNote(int index) {
    setState(() {
      notes=dbHelper.getNotes();
      state = 1;
    });
  }

  StaggeredGridView listFunc(List<Note> notes) {
    return StaggeredGridView.countBuilder(
      crossAxisCount: 4,
      itemCount: notes.length,
      itemBuilder: (BuildContext context, int index) => GestureDetector(
        onTap: () {
          if (state == 1) {
            setState(() {
              o1 = 0;
              o2 = 0;
              state =0;
            });
          }
          else if(state==0){
            NoteDialog();
            }
        },

        onLongPress: () {
          if(state==0) {
            HapticFeedback.heavyImpact();
            setState(() {state=1;
              o1 = 0.8;
              o2 = 1;

            });
          }
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: map[notes[index].clrID],
          ),
          child: Stack(
            alignment: Alignment.centerLeft,
            children: <Widget>[
              new Container(
                padding: EdgeInsets.all(12),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    notes[index].noteText,
                    style: TextStyle(fontSize: 18, fontFamily: 'Roboto'),
                  ),
                ),
              ),
              Positioned.fill(
                child: Opacity(
                  opacity: o1,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromRGBO(60, 20, 20, 90),
                    ),
                  ),
                ),
              ),
              Opacity(
                opacity: o2,
                child: Container(
                  alignment: Alignment.center,
                  child: Opacity(
                    opacity: 0.85,
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                      child: IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            print(index);
                            dbHelper.delete(index);
                            deleteNote(index);
                          }),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
      mainAxisSpacing: 10.0,
      crossAxisSpacing: 8.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    if(notes==null)
    refresh();
    return Container(color: Color.fromRGBO(50, 50, 50,1),
      padding: EdgeInsets.only(left: 10, right: 10, bottom: 25, top: 15),
      child: FutureBuilder(
        future: notes,
        builder: (context, snapshot) {
          if (snapshot.hasData) {print("StagList called");
            return listFunc(snapshot.data);
          }

          if (null == snapshot.data || snapshot.data.length == 0) {
            return Text("No Data Found");
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
