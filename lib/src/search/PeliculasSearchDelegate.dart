import 'package:flutter/material.dart';
import 'package:peliculas/src/models/Pelicula.dart';
import 'package:peliculas/src/providers/PeliculasProviders.dart';

class PeliculasSearchDelegate extends SearchDelegate{

  final peliculas = ['Spiderman', 'monster','little things'];
  final peliculasRecientes = ['monster'];

  final peliculasProvider = new PeliculasProvider();

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: accionees de nuestro appbar
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: (){
            query = '';
          }
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: icono a la izquierda del appbar
    return IconButton(
        icon:AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ) ,
        onPressed: (){
          close(context, null);
        }
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: crear los resultados que se mostraran
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: sugerencias que aparece cuando la persona escribe
   if(query.isEmpty){
     return Container();
   }
   return FutureBuilder(
     future: peliculasProvider.buscarPelicula(query),
     builder:(BuildContext context, AsyncSnapshot<List<Pelicula>> asyncSnapshot){
       if(asyncSnapshot.hasData){
         final peliculas = asyncSnapshot.data;
         return ListView(
           children:
           peliculas.map((pelicula) {
             pelicula.idUnico = '${pelicula.id}-busqueda';
             return ListTile(
               leading:  Hero(
                 tag: pelicula.idUnico,
                 child:  ClipRRect(
                   borderRadius: BorderRadius.circular(20.0),
                   child: FadeInImage(
                     image: NetworkImage(pelicula.getPosterImg()),
                     placeholder: AssetImage('assets/img/no-image.jpg'),
                     width: 50.0,
                     fit: BoxFit.contain
                   ),
                 ),
               ),
               title: Text(pelicula.title),
               subtitle: Text(pelicula.originalTitle),
               onTap: (){
                 close(context, null);
                 pelicula.idUnico = '';
                 Navigator.pushNamed(context, 'detallePelicula', arguments: pelicula);
               },
             );
           }).toList(),
         );
       }else{
         return Center(
           child: CircularProgressIndicator(),
         );
       }
     },
   );


  }

  /*@override
  Widget buildSuggestions(BuildContext context) {
    // TODO: sugerencias que aparece cuando la persona escribe
    final listaSugerida = (query.isEmpty)
        ?peliculasRecientes
        :peliculas.where((p) => p.toLowerCase().startsWith(query.toLowerCase())).toList();

    return ListView.builder(
        itemCount: listaSugerida.length,
        itemBuilder: (context, i){

          return ListTile(
            leading: Icon(Icons.movie),
            title: Text(listaSugerida[i]),
            onTap: (){

            },
          );


        }
    );
  }*/

}