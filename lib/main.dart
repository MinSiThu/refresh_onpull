import 'dart:math';
import 'dart:async';

import 'package:flutter/material.dart';

main(List<String> args) {
  return runApp(RefreshOnPull());
}

class RefreshOnPull extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Refresh On Pull",
        debugShowCheckedModeBanner: false,
        home: RefreshOnPullPage());
  }
}

class RefreshOnPullPage extends StatefulWidget {
  _RefreshOnPullPageState createState() => _RefreshOnPullPageState();
}

class _RefreshOnPullPageState extends State<RefreshOnPullPage> {
  List _list;
  var random;

  var refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    random = Random();
    refreshList();
  }

  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      _list = List.generate(random.nextInt(20), (i) => "Item $i");
    });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Refresh On Pull"),
          backgroundColor: Colors.deepPurpleAccent,
        ),
        body: RefreshIndicator(
          key: refreshKey,
          onRefresh: refreshList,
          child: ListView.builder(
            itemCount: _list.length,
              itemBuilder: (context, index) =>
                  ListTile(title: Text(_list[index]))),
        ));
  }
}
