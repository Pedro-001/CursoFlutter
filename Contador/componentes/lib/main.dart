import 'package:componentes/src/pages/home_page.dart';
import 'package:flutter/material.dart';

/* import 'package:componentes/src/pages/home_temp.dart';
 */
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ComponentesAPP',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
