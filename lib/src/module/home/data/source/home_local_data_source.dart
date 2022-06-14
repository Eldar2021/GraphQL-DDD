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
    try {
      if (_isFirstPage(page)) await put(cachedCharacters, models);
    } catch (e) {
      throw CacheExc('$e');
    }
  }

  @override
  Future<void> cacheEpisodes(List<Episode> models, int page) async {
    try {
      if (_isFirstPage(page)) await put(cachedEpisodes, models);
    } catch (e) {
      throw CacheExc('$e');
    }
  }

  @override
  Future<void> cacheLocations(List<Location> models, int page) async {
    try {
      if (_isFirstPage(page)) await put(cachedLocations, models);
    } catch (e) {
      throw CacheExc('$e');
    }
  }

  @override
  List<Character>? getLastCharacters(int page) {
    try {
      final modelsString = get(cachedCharacters);
      if (_isFirstPage(page) && modelsString != null) {
        return modelType<Character>(modelsString, Character.fromJson);
      } else {
        return null;
      }
    } catch (e) {
      throw CacheExc('$e');
    }
  }

  @override
  List<Episode>? getLastEpisodes(int page) {
    try {
      final modelsString = get(cachedEpisodes);
      if (_isFirstPage(page) && modelsString != null) {
        return modelType<Episode>(modelsString, Episode.fromJson);
      } else {
        return null;
      }
    } catch (e) {
      throw CacheExc('$e');
    }
  }

  @override
  List<Location>? getLastLocations(int page) {
    try {
      final modelsString = get(cachedLocations);
      if (_isFirstPage(page) && modelsString != null) {
        return modelType<Location>(modelsString, Location.fromJson);
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
