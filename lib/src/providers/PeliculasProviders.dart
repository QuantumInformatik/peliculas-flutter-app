import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:peliculas/src/models/Actor.dart';
import 'package:peliculas/src/models/Pelicula.dart';

class PeliculasProvider{
  String _apikey='908f2ba78bec4f9d18ca21d44a56ee41';
  String _url ='api.themoviedb.org';
  String _lenguaje = 'es-ES';
  String _apiVersion ='3';
  int _popularesPage =0;
  bool _cargando = false;
  List<Pelicula> _populares = new List();
  final _popularesStremController = StreamController<List<Pelicula>>.broadcast();

  Function(List<Pelicula>) get popularesSink => _popularesStremController.sink.add;

  Stream<List<Pelicula>> get popularesStrem => _popularesStremController.stream;

  void dispose(){
    _popularesStremController?.close();
  }

  Future<List<Pelicula>> getEnCines() async {
    final url = Uri.https(_url, '$_apiVersion/movie/now_playing',{
      'api_key':_apikey,
      'lenguage':_lenguaje
    });
    return await _procesarRespuesta(url);

  }

  Future<List<Pelicula>> getPopulares() async {
    if(_cargando)return[];
    _cargando = true;
    _popularesPage++;
    

    final url = Uri.https(_url, '$_apiVersion/movie/popular',{
      'api_key':_apikey,
      'lenguage':_lenguaje,
      'page': _popularesPage.toString()
    });
    final respuesta =  await _procesarRespuesta(url);
    _populares.addAll(respuesta);
    popularesSink(_populares);

    _cargando = false;

    return respuesta;


  }


  Future<List<Actor>> getCast(String peliculaId) async {
    final url = Uri.https(_url, '$_apiVersion/movie/$peliculaId/credits',{
      'api_key':_apikey,
      'lenguage':_lenguaje
    });
    final respuesta = await http.get(url);
    final jsonDecodificado = json.decode(respuesta.body);

    final cast = new Cast.fromJsonList(jsonDecodificado['cast']);
    return cast.actores;

  }

  Future<List<Pelicula>> _procesarRespuesta(Uri uri) async {

    final respuesta = await http.get(uri);
    final dataDecodificada = json.decode(respuesta.body);

    final peliculas = new Peliculas.fromJsonList(dataDecodificada['results']);

    return peliculas.items;
  }

  Future<List<Pelicula>> buscarPelicula(String query) async {
    final url = Uri.https(_url, '$_apiVersion/search/movie',{
      'api_key':_apikey,
      'lenguage':_lenguaje,
      'query': query
    });
    return await _procesarRespuesta(url);

  }

}