
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
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _swiperTarjetas(),
            _footer(context)
          ],
        ),
      )
    );
  }


  Widget _footer(BuildContext context){

    return Container(
        width: double.infinity,
        color: Colors.amber,
        child: Column(
          children: [
            Text('Populares', style: Theme.of(context).textTheme.subtitle1),
            FutureBuilder(
              future: peliculasProvider.getPopulares(),
              builder: (BuildContext context, AsyncSnapshot<List> asyncSnapshot){
                asyncSnapshot.data?.forEach((pelicula) =>print(pelicula.title));
                return Container();
                
              },
            )
          ],
        ),
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
