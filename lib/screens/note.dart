import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

int _itemCount=20;
class note extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      crossAxisCount: 4,
      itemCount: _itemCount,
      itemBuilder: (BuildContext context, int index) => new Container(
          color: Colors.green,
          child: new Center(
            child: new CircleAvatar(
              backgroundColor: Colors.white,
              child: new Text('$index'),
            ),
          )),
      staggeredTileBuilder: (int index) =>
      new StaggeredTile.fit(2),
      mainAxisSpacing: 10.0,
      crossAxisSpacing: 8.0,
    );
  }
}
