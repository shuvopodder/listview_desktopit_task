import 'package:flutter/material.dart';
import 'package:listview_desktopit_task/ListView.dart';
import 'package:provider/provider.dart';

import 'getData.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_)=>getData())
  ],child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ListViewPage()
    );
  }
}

