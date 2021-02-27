
import 'package:flutter/material.dart';
import 'package:peliculas/src/models/Pelicula.dart';

class MovieHorizontal extends StatelessWidget {
  final List<Pelicula> peliculas;
  final _pageController = new PageController( initialPage: 1,viewportFraction: 0.3);
  final Function siguientePagina;

  MovieHorizontal({@required this.peliculas, @required this.siguientePagina});


  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener(() {
      if(_pageController.position.pixels>=_pageController.position.maxScrollExtent-300){
        siguientePagina();
      }
    });


    return Container(
      height: _screenSize.height*0.23,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        itemCount: peliculas.length,
        itemBuilder: (context, index){
          return _crearTarjeta(context, peliculas[index]);

        },
      ),
    );
  }

  Widget _crearTarjeta(BuildContext context, Pelicula pelicula){
    pelicula.idUnico = '${pelicula.id}-poster';

    final tarjetaPelicula =  Container(
      margin: EdgeInsets.only(right: 15.0),
      child: Column(
        children: [
          Hero(
            tag: pelicula.idUnico,
            child:  ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                image: NetworkImage(pelicula.getPosterImg()),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                fit: BoxFit.cover,
                height: 130.0,
              ),
            ),
          ),
          SizedBox(height: 5.0,),
          Center(
            child: Text(
              pelicula.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.subtitle1,
            ),
          )
        ],
      ),
    );

    return GestureDetector(
      child: tarjetaPelicula,
      onTap: (){
        Navigator.pushNamed(context, 'detallePelicula', arguments: pelicula);
      },
    );


  }

  @Deprecated('Este metodo fue util, pero consume mucha memoria ram')
  List<Widget> _tarjetas(BuildContext context){
    return peliculas.map((pelicula){
      return Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                image: NetworkImage(pelicula.getPosterImg()),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                fit: BoxFit.cover,
                height: 155.0,
              ),
            ),
            SizedBox(height: 5.0,),
            Center(
              child: Text(
                pelicula.title,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.subtitle1,
              ),
            )
          ],
        ),
      );
    }).toList();
  }

}
