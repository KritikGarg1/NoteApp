import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sqlite/utils/db_helper.dart';
import 'package:sqlite/models/noteModel.dart';
import 'noteDialog.dart';
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';

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
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: map[notes[index].clrID],
        ),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            notes[index].noteText,
            style: TextStyle(fontSize: 18, fontFamily: 'Roboto'),
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
    refresh();
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, bottom: 25, top: 15),
      child: FutureBuilder(
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
      ),
    );
  }
}
