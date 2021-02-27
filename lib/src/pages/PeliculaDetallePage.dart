import 'package:flutter/material.dart';
import 'package:peliculas/src/models/Actor.dart';
import 'package:peliculas/src/models/Pelicula.dart';
import 'package:peliculas/src/providers/PeliculasProviders.dart';

class PeliculaDetallePage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final Pelicula pelicula = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _crearAppBar(pelicula),
          //esto para abao es simplmenete para poder hacer el efecto del deslisado hacia arriba
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(height: 10.0,),
                _posterTitulo(context, pelicula),
                _descripcion(pelicula),
                _descripcion(pelicula),
                _descripcion(pelicula),
                _descripcion(pelicula),
                _descripcion(pelicula),
                _descripcion(pelicula),
                _descripcion(pelicula),
                _descripcion(pelicula),
                _descripcion(pelicula),
                _descripcion(pelicula),
                _descripcion(pelicula),
                _descripcion(pelicula),
                _descripcion(pelicula),
                _descripcion(pelicula),
                _descripcion(pelicula),
                _crearCasting(pelicula)
              ]
            ),
          ),

        ],
      )
    );
  }

  Widget  _crearCasting(Pelicula pelicula){
    final peliculaProvider = new PeliculasProvider();

    return FutureBuilder(
      future: peliculaProvider.getCast(pelicula.id.toString()),
      builder: (context, AsyncSnapshot<List> asyncSnapshot){
        if(asyncSnapshot.hasData){
          return _crearActoresPageView(asyncSnapshot.data);
        }else{
          return Center(child: CircularProgressIndicator(),);
        }

      },
    );

  }

  Widget _crearActoresPageView(List<Actor> actores){

    return SizedBox(
      height: 200.0,
      child: PageView.builder(
        pageSnapping: false,
        controller: PageController(
          viewportFraction: 0.3,
          initialPage: 1
        ),
        itemCount: actores.length,
        itemBuilder: (context, i){
          return _actorTarjeta(actores[i]);
        },
      ),
    );

  }

  Widget _actorTarjeta(Actor actor){

    final tarjetaActor =  Container(
      margin: EdgeInsets.only(right: 15.0),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              image: NetworkImage(actor.getProfilePathImg()),
              placeholder: AssetImage('assets/img/no-image.jpg'),
              fit: BoxFit.cover,
              height: 130.0,
            ),
          ),
          SizedBox(height: 5.0,),
          Center(
            child: Text(
              actor.name,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );

    return tarjetaActor;

  }


  Widget _descripcion(Pelicula pelicula){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
      child: Text(pelicula.overview, textAlign: TextAlign.justify,),

    );
  }

  Widget  _posterTitulo(BuildContext context, Pelicula pelicula){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image(
              image: NetworkImage(pelicula.getPosterImg()),
              height: 150.0,
            ),
          ),
          SizedBox(width: 20.0,),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(pelicula.title, style: Theme.of(context).textTheme.headline6, overflow: TextOverflow.ellipsis,),
                Text(pelicula.originalTitle, style: Theme.of(context).textTheme.bodyText2,  overflow: TextOverflow.ellipsis,),
                Row(
                  children: [
                    Icon(Icons.star_border),
                    Text(pelicula.voteAverage.toString(), style:Theme.of(context).textTheme.bodyText1)
                  ],

                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _crearAppBar(Pelicula pelicula){

    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          pelicula.title,
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
        background: FadeInImage(
          image: NetworkImage(pelicula.getBackGroundImg()),
          placeholder: AssetImage('assets/img/no-image.jpg'),
          fadeInDuration: Duration(milliseconds: 150),
          fit: BoxFit.cover,
        ),
      ),
    );

  }




}
