import 'package:flutter/rendering.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../../../src.dart';

abstract class HomeRemoteDataSource {
  Future<List<Character>> getCharacters(int page);

  Future<List<Episode>> getEpisodes(int page);

  Future<List<Location>> getLocations(int page);
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  HomeRemoteDataSourceImpl(this._client);

  final GraphQLClient _client;

  @override
  Future<List<Character>> getCharacters(int page) async {
    final res = await _query(page, GqlQuery.charactersQuery);

    return _response(res, Character.fromJson, 'characters');
  }

  @override
  Future<List<Episode>> getEpisodes(int page) async {
    final res = await _query(page, GqlQuery.episodesQuery);
    return _response(res, Episode.fromJson, 'episodes');
  }

  @override
  Future<List<Location>> getLocations(int page) async {
    final res = await _query(page, GqlQuery.locationsQuery);
    return _response(res, Location.fromJson, 'locations');
  }

  Future<List<T>> _response<T>(
    QueryResult<Object?> res,
    T Function(Map<String, dynamic>) fromJson,
    String named,
  ) async {
    try {
      if (res.data != null) {
        // ignore: avoid_dynamic_calls
        final list = res.data?[named]['results'] as List<Object?>;
        final modelList = list
            .map<T>(
              (e) => fromJson(e! as Map<String, dynamic>),
            )
            .toList();

        return modelList;
      } else {
        return [];
      }
    } catch (e) {
      debugPrint('$e');
      return [];
    }
  }

  Future<QueryResult> _query(int page, String path) async {
    return _client.query(
      QueryOptions(
        document: gql(path),
        variables: <String, dynamic>{'page': page},
      ),
    );
  }
}
