import 'package:graduation_project_movies/models/movies_list_repsonse.dart';
import 'package:hive/hive.dart';

class HistoryManager {
  static const String _historyBoxName = 'historyBox';
  static late Box _box;
  static Future<void> init()async{
    _box = await Hive.openBox(_historyBoxName);
  }
  static List<Movies> getMovies(){
    final List storedMovies = _box.values.toList();
    return storedMovies.map((json) => Movies.fromJson(json)).toList();
  }
  static Future<void> saveMovie(Movies movie)async{
    final movies = getMovies();
    if (movies.any((m) => m.id == movie.id)) return;
    await _box.add(movie.toJson());
  }
}