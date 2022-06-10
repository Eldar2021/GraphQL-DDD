import 'dart:convert';

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

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  HomeLocalDataSourceImpl(this._box);

  final Box<String> _box;

  @override
  Future<void> cacheCharacters(List<Character> models, int page) async {
    try {
      if (_isFirstPage(page)) {
        await _box.put(
          cachedCharacters,
          json.encode(models.map<dynamic>((e) => e.toJson()).toList()),
        );
      }
    } catch (e) {
      throw CacheExc('$e');
    }
  }

  @override
  Future<void> cacheEpisodes(List<Episode> models, int page) async {
    try {
      if (_isFirstPage(page)) {
        await _box.put(
          cachedEpisodes,
          json.encode(models.map<dynamic>((e) => e.toJson()).toList()),
        );
      }
    } catch (e) {
      throw CacheExc('$e');
    }
  }

  @override
  Future<void> cacheLocations(List<Location> models, int page) async {
    try {
      if (_isFirstPage(page)) {
        await _box.put(
          cachedLocations,
          json.encode(models.map<dynamic>((e) => e.toJson()).toList()),
        );
      }
    } catch (e) {
      throw CacheExc('$e');
    }
  }

  @override
  List<Character>? getLastCharacters(int page) {
    try {
      final modelsString = _box.get(cachedCharacters);

      if (_isFirstPage(page) && modelsString != null) {
        final listModel = json.decode(modelsString) as List;
        return listModel
            .map<Character>(
              (dynamic e) => Character.fromJson(e as Map<String, dynamic>),
            )
            .toList();
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
      final modelsString = _box.get(cachedEpisodes);

      if (_isFirstPage(page) && modelsString != null) {
        final listModel = json.decode(modelsString) as List;
        return listModel
            .map<Episode>(
              (dynamic e) => Episode.fromJson(e as Map<String, dynamic>),
            )
            .toList();
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
      final modelsString = _box.get(cachedLocations);

      if (_isFirstPage(page) && modelsString != null) {
        final listModel = json.decode(modelsString) as List;
        return listModel
            .map<Location>(
              (dynamic e) => Location.fromJson(e as Map<String, dynamic>),
            )
            .toList();
      } else {
        return null;
      }
    } catch (e) {
      throw CacheExc('$e');
    }
  }

  bool _isFirstPage(int page) => page == 0;
}
