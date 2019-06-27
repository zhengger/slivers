// Tutorial: https://medium.com/flutter/slivers-demystified-6ff68ab0296f
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:faker/faker.dart';

import 'package:flutter/rendering.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        // appBar: MyAppBar();
        body: CollapsingList(),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => math.max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // TODO: implement build
    return new SizedBox.expand(
      child: child,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}

class MyAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CustomScrollView(slivers: <Widget>[
      SliverAppBar(
        title: Text(faker.person.name()),
        backgroundColor: Colors.green,
        expandedHeight: 200.0,
        flexibleSpace: FlexibleSpaceBar(
          background: Image.asset('images/forest.jpg', fit: BoxFit.cover),
        ),
      ),
    ]);
  }
}

class CollapsingList extends StatelessWidget {
  // make a header for each row
  SliverPersistentHeader makeHeader(String headerText) {
    return SliverPersistentHeader(
      // floating: true,
      pinned: true, //? true or false
      delegate: _SliverAppBarDelegate(
          minHeight: 60.0,
          maxHeight: 200.0,
          child: Container(
            color: Colors.lightBlue,
            child: Center(
              child: Text(faker.person.name()),
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CustomScrollView(
      slivers: <Widget>[
        // makeHeader('Header Section 0'),
        SliverAppBar(
          title: Text(faker.food.dish()),
          backgroundColor: Colors.green,
          expandedHeight: 100.0,
          flexibleSpace: FlexibleSpaceBar(
            background: Image.asset('images/forest.png', fit: BoxFit.cover),
          ),
        ),
        makeHeader('Header Section 1'),
        SliverGrid.count(
          children: <Widget>[
            Container(
             color: Colors.red,
             height: 150.0,
            //  alignment: Alignment.topRight,
            //  child: GestureDetector(onTap: (){}, child: Container(color: Colors.black, height: 50,),),
             ),
            Container(color: Colors.purple, height: 150.0),
            Container(color: Colors.green, height: 150.0),
            Container(color: Colors.orange, height: 150.0),
            Container(color: Colors.yellow, height: 150.0),
            Container(color: Colors.pink, height: 150.0),
            Container(color: Colors.cyan, height: 150.0),
            Container(color: Colors.indigo, height: 150.0),
            Container(color: Colors.blue, height: 150.0),
          ],
          crossAxisCount: 3,
        ),
        makeHeader('Header Section 2'),
        SliverFixedExtentList(
          itemExtent: 150.0,
          delegate: SliverChildListDelegate(
            [
              Container(color: Colors.red),
              Container(color: Colors.purple),
              Container(color: Colors.green),
              Container(color: Colors.orange),
              Container(color: Colors.yellow),
            ],
          ),
        ),
        makeHeader('Header Section 3'),
        SliverGrid(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200.0,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            childAspectRatio: 4.0,
          ),
          delegate:
              SliverChildBuilderDelegate((BuildContext context, int index) {
            return Container(
              alignment: Alignment.center,
              color: Colors.teal[100 * (index % 9)],
              child: Text('grid item $index'),
            );
          }, childCount: 20),
        ),
        makeHeader('Header Section 4'),
        SliverList(
          delegate: SliverChildListDelegate(<Widget>[
            Container(color: Colors.pink, height: 150.0),
            Container(color: Colors.cyan, height: 150.0),
            Container(color: Colors.indigo, height: 150.0),
            Container(
              color: Colors.blue, 
              height: 150.0,
              // width: 150,
              // constraints: BoxConstraints(maxWidth: 110, minHeight: 110),
              // alignment: Alignment.topLeft,
              // child: GestureDetector(
              //   child: FlatButton(
              //     color: Colors.yellow,
              //     onPressed: (){},
              //     child: Text(
              //       'Hit Test',
              //       style: TextStyle(fontSize: 30),
              //       textAlign: TextAlign.left,),),
              //   behavior: HitTestBehavior.opaque,
              //   onTap: (){},
              ),
          ],),
        ),
      ],
    );
  }
}
