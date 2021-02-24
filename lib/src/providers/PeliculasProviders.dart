import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:peliculas/src/models/Pelicula.dart';

class PeliculasProvider{
  String _apikey='908f2ba78bec4f9d18ca21d44a56ee41';
  String _url ='api.themoviedb.org';
  String _lenguaje = 'es-ES';
  String _apiVersion ='3';

  Future<List<Pelicula>> getEnCines() async {
    final url = Uri.https(_url, '$_apiVersion/movie/now_playing',{
      'api_key':_apikey,
      'lenguage':_lenguaje
    });
    return await _procesarRespuesta(url);

  }

  Future<List<Pelicula>> getPopulares() async {
    final url = Uri.https(_url, '$_apiVersion/movie/popular',{
      'api_key':_apikey,
      'lenguage':_lenguaje
    });
    return await _procesarRespuesta(url);


  }

  Future<List<Pelicula>> _procesarRespuesta(Uri uri) async {
    print(uri);

    final respuesta = await http.get(uri);
    final dataDecodificada = json.decode(respuesta.body);

    final peliculas = new Peliculas.fromJsonList(dataDecodificada['results']);

    return peliculas.items;
  }

}