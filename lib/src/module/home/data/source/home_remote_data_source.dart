
import 'package:graphql/client.dart';

import '../../../../src.dart';

abstract class HomeRemoteDataSource {
  Future<List<Character>> getCharacters(int page);

  Future<List<Episode>> getEpisodes(int page);

  Future<List<Location>> getLocations(int page);
}

class HomeRemoteDataSourceImpl extends HomeRemoteDataSource with GraphQLMixin {
  HomeRemoteDataSourceImpl(this._client);

  final GraphQLClient _client;

  @override
  Future<List<Character>> getCharacters(int page) async {
    final res = await queryPage(page, GqlQuery.charactersQuery);
    return response(res, Character.fromJson, 'characters', 'results');
  }

  @override
  Future<List<Episode>> getEpisodes(int page) async {
    final res = await queryPage(page, GqlQuery.episodesQuery);
    return response(res, Episode.fromJson, 'episodes', 'results');
  }

  @override
  Future<List<Location>> getLocations(int page) async {
    final res = await queryPage(page, GqlQuery.locationsQuery);
    return response(res, Location.fromJson, 'locations', 'results');
  }

  @override
  GraphQLClient get client => _client;
}
