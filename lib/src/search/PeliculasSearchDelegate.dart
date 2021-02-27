import 'package:flutter/material.dart';

class PeliculasSearchDelegate extends SearchDelegate{

  final peliculas = ['Spiderman', 'monster','little things'];
  final peliculasRecientes = ['monster'];

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
  }

}