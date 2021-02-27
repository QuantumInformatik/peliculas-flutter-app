
import 'package:flutter/material.dart';
import 'package:peliculas/src/providers/PeliculasProviders.dart';
import 'package:peliculas/src/search/PeliculasSearchDelegate.dart';
import 'package:peliculas/src/widgets/CardSwiperWidget.dart';
import 'package:peliculas/src/widgets/MovieHorizontal.dart';

class HomePage extends StatelessWidget {

  final peliculasProvider = new PeliculasProvider();


  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    print("home page w: "+(_screenSize.width).toString());
    print("home page h: "+(_screenSize.height).toString());

    peliculasProvider.getPopulares();

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Peliculas en cines'),
        backgroundColor: Colors.indigoAccent,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){
              showSearch(context: context, delegate: PeliculasSearchDelegate(),
              );
            },
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.tealAccent) ,
        height: _screenSize.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Flexible(
                flex: 2,
                child:_swiperTarjetas()
            ),
            Flexible(
              flex: 1,
                child: _footer(context)
            ),
          ],

        ),
      )
    );
  }


  Widget _footer(BuildContext context){

    return Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                decoration: BoxDecoration(color: Colors.indigo) ,
                padding: EdgeInsets.only(left: 20.0),
              child: Text('Populares', style: Theme.of(context).textTheme.subtitle1)
            ),
            SizedBox(height: 5.0,
              child: Container(
                decoration: BoxDecoration(color: Colors.indigo) ,
              ),
            ),
            StreamBuilder(
              stream: peliculasProvider.popularesStrem,
              builder: (BuildContext context, AsyncSnapshot<List> asyncSnapshot){
                if(asyncSnapshot.hasData){
                  return MovieHorizontal(peliculas: asyncSnapshot.data, siguientePagina: peliculasProvider.getPopulares,);
                }
                return Center(
                  child: CircularProgressIndicator(),
                );

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
