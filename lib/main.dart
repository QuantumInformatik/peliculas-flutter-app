import 'package:flutter/material.dart';
import 'package:peliculas/src/pages/HomePage.dart';
import 'package:peliculas/src/pages/PeliculaDetallePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: '/',
      routes: {
        '/': (BuildContext context )=>HomePage(),
        'detallePelicula':(BuildContext context )=> PeliculaDetallePage()
      },
    );
  }
}