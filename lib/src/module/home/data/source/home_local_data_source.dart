import 'package:graphql_ddd/src/core/core.dart';
import 'package:graphql_ddd/src/module/module.dart';
import 'package:hive/hive.dart';

const String cachedCharacters = 'CACHED_CHARACTERS';
const String cachedEpisodes = 'CACHED_EPISODES';
const String cachedLocations = 'CACHED_LOCATIONS';

abstract class HomeLocalDataSource {
  List<Character>? getLastCharacters(int page);

  Future<void> cacheCharacters(List<Character> models, int page);

  List<Episode>? getLastEpisodes(int page);

  Future<void> cacheEpisodes(List<Episode> models, int page);

  List<Location>? getLastLocations(int page);

  Future<void> cacheLocations(List<Location> models, int page);
}

class HomeLocalDataSourceImpl extends HomeLocalDataSource with HiveMixin {
  HomeLocalDataSourceImpl(this._box);

  final Box<String> _box;

  @override
  Future<void> cacheCharacters(List<Character> models, int page) async {
    return _put<Character>(page, cachedCharacters, models);
  }

  @override
  Future<void> cacheEpisodes(List<Episode> models, int page) async {
    return _put<Episode>(page, cachedEpisodes, models);
  }

  @override
  Future<void> cacheLocations(List<Location> models, int page) async {
    return _put<Location>(page, cachedLocations, models);
  }

  Future<void> _put<T>(int page, String key, List<Model> models) async {
    try {
      if (_isFirstPage(page)) await put(key, models);
    } catch (e) {
      throw CacheExc('$e');
    }
  }

  @override
  List<Character>? getLastCharacters(int page) {
    return _getData<Character>(cachedCharacters, page, Character.fromJson);
  }

  @override
  List<Episode>? getLastEpisodes(int page) {
    return _getData<Episode>(cachedEpisodes, page, Episode.fromJson);
  }

  @override
  List<Location>? getLastLocations(int page) {
    return _getData<Location>(cachedLocations, page, Location.fromJson);
  }

  List<T>? _getData<T>(
    String key,
    int page,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    try {
      final modelsString = get(key);
      if (_isFirstPage(page) && modelsString != null) {
        return modelType<T>(modelsString, fromJson);
      } else {
        return null;
      }
    } catch (e) {
      throw CacheExc('$e');
    }
  }

  bool _isFirstPage(int page) => page == 0;

  @override
  Box<String> get box => _box;
}
