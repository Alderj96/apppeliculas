import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:peliculasapp/models/movie.dart';
import 'package:peliculasapp/models/now_playing_response.dart';
import 'package:peliculasapp/models/popular_response.dart';

class MoviesProvider extends ChangeNotifier {

  final String _apiKey = dotenv.env['APIKEY']!;
  final String _baseUrl = dotenv.env['BASEURL']!;
  final String _language = dotenv.env['LANGUAGE']!;

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];

  MoviesProvider() {
    getOnDisplayMovies();
    getPopularMovies();
  }

  getOnDisplayMovies() async {
    final url = Uri.https(_baseUrl, '/3/movie/now_playing', {
      'api_key': _apiKey,
      'language': _language,
      'page': '1'
    });

    final response = await http.get(url);
    final nowPlayingResponse = NowPlayingResponse.fromJson(response.body);

    onDisplayMovies = nowPlayingResponse.results;
    notifyListeners();
  }

  getPopularMovies() async {
    final url = Uri.https(_baseUrl, '/3/movie/popular', {
      'api_key': _apiKey,
      'language': _language,
      'page': '1'
    });

    final response = await http.get(url);
    final popularResponse = PopularResponse.fromJson(response.body);

    popularMovies.addAll(popularResponse.results);
    notifyListeners();
  }
}