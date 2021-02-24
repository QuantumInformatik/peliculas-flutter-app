import 'package:flutter/material.dart';
import 'package:peliculas/src/providers/PeliculasProviders.dart';
import 'package:peliculas/src/widgets/CardSwiperWidget.dart';

class HomePage extends StatelessWidget {

  final peliculasProvider = new PeliculasProvider();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Peliculas en cines'),
        backgroundColor: Colors.indigoAccent,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){},
          )
        ],
      ),
      body: Container(
        child: Column(
          children: [
            _swiperTarjetas()
          ],
        ),
      )
    );
  }

  Widget _swiperTarjetas(){
    return FutureBuilder(
      future: peliculasProvider.getEnCines(),
      builder: (BuildContext context, AsyncSnapshot<List> asyncSnapshot){

        if(asyncSnapshot.hasData){
          return CardSwiper(
            peliculas: asyncSnapshot.data,
          );
        }else{
          return Container(
            height: 400.0,
            child:  Center(child: CircularProgressIndicator(),),
          );
        }

      },
    );

    /*peliculasProvider.getEnCines();
    return CardSwiper(
      peliculas: [1,2,3,4,5],
    );*/


  }




}
