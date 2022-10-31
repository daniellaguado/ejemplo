import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas/models/models.dart';

class MoviesProvider extends ChangeNotifier {
  final String _baseUrl = 'api.themoviedb.org';
  final String _apyKey = '33558e6dcb08d5ce913784b6714bbd69';
  final String _language = 'es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];
  Map<int, List<Cast>> moviesCast = {};
  int _popularPages = 0;

  MoviesProvider() {
    //instanció la clase
    print('MoviesProvider inicializado');
//Llamar a los metodos
    getOnDisplayMovies();
    getPopularMovies();
  }

  //este aqui es el metodo que me estoy creando para reutilizar los codigos de abajo (peliculas y peliculas populares)
  Future<String> _getJsonData(String endpoint, [int page = 1]) async {
    var url = Uri.https(_baseUrl, '3/movie/now_playing',
        {'api_key': _apyKey, 'language': _language, 'page': '$page'});
    final response = await http.get(url);
    return response.body;
  }

  //Metodo para peliculas
  getOnDisplayMovies() async {
    final jsonData = await _getJsonData('3/movie/now_playing');
    final nowPlayingResponse = NowPlayingResponse.fromJson(jsonData);
    onDisplayMovies = nowPlayingResponse.results;
    notifyListeners(); //es para redibujar widgets si acontece algun cambio de propiedad de la clase o algun cambio que precise se redibujar
  }

  //Metodo para peliculas populares
  getPopularMovies() async {
    _popularPages++;

    final jsonData = await _getJsonData('3/movie/popular', _popularPages);
    final popularResponse = PopularResponse.fromJson(jsonData);

    popularMovies = [...popularMovies, ...popularResponse.results];
    print(popularMovies[0]);
    notifyListeners(); //es para redibujar widgets si acontece algun cambio de propiedad de la clase o algun cambio que precise se redibujar
  }

  getMovieCast(int movieId) async {
    if (moviesCast.containsKey(movieId)) return moviesCast[movieId]!;

    //TODO: revisar el mapa
    print('pidiendo info al servidor de los actores');

    final jsonData = await _getJsonData('3/movie/$movieId/credits');
    final creditsResponse = CreditsResponse.fromJson(jsonData);
    moviesCast[movieId] = creditsResponse.cast;
    return creditsResponse.cast;
  }
}
