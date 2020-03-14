import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sqlite/utils/db_helper.dart';
import 'package:sqlite/models/noteModel.dart';
import 'noteDialog.dart';

Color c;
var map = {
  1: c1,
  2: c2,
  3: c3,
  4: c4,
};

class note extends StatefulWidget {
  @override
  noteState createState() => noteState();
}

class noteState extends State<note> {
  StaggeredGridView listFunc(List<Note> notes) {
    return StaggeredGridView.countBuilder(
      crossAxisCount: 4,
      itemCount: notes.length,
      itemBuilder: (BuildContext context, int index) => new Container(
          color: map[notes[index].clrID],
          child: Padding(padding:EdgeInsets.all(10), child:Text(notes[index].noteText),
            ),
          ),
      staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
      mainAxisSpacing: 10.0,
      crossAxisSpacing: 8.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: notes,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return listFunc(snapshot.data);
        }

        if (null == snapshot.data || snapshot.data.length == 0) {
          return Text("No Data Found");
        }

        return CircularProgressIndicator();
      },
    );
  }
}
