import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/models/models.dart';

class MoviesProvider extends ChangeNotifier {
  String _apiKey = '196e6250c8b6831992e8bea115d77612';
  String _baseUrl = 'api.themoviedb.org';
  String _language = 'es-Es';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];
  Map<int, List<Cast>> movieCast = {};

  int popularPage = 0;

  MoviesProvider() {
    this.getOnDisplayMovies();
    this.getPopularMovies();
  }

  Future<String> _getJsonData(String endPoint, [int page = 1]) async {
    var url = Uri.https(this._baseUrl, endPoint,
        {'api_key': _apiKey, 'language': _language, 'page': '$page'});

    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url);
    return response.body;
  }

  getOnDisplayMovies() async {
    final jsonData = await this._getJsonData('3/movie/now_playing', 1);

    final nowPlayingResponse = NowPlayingResponse.fromJson(jsonData);

    onDisplayMovies = nowPlayingResponse.results;
    notifyListeners();
  }

  getPopularMovies() async {
    popularPage++;
    final jsonData = await this._getJsonData('3/movie/popular', popularPage);
    final popularResponse = PopularResponse.fromJson(jsonData);
    popularMovies = [...popularMovies, ...popularResponse.results];
    notifyListeners();
  }

  Future<List<Cast>> getMovieCast(int movieID) async {
    if (movieCast.containsKey(movieID)) return movieCast[movieID]!;

    final jsonData = await this._getJsonData('3/movie/$movieID/credits');
    final creditsResponse = CreditsResponse.fromJson(jsonData);

    movieCast[movieID] = creditsResponse.cast;
    return creditsResponse.cast;
  }
}
