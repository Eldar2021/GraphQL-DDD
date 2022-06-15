import 'package:flutter/material.dart';
import 'package:graphql/client.dart';

mixin GraphQLMixin {
  GraphQLClient get client;

  Future<QueryResult> query(String path) async {
    return client.query(
      QueryOptions(
        document: gql(path),
      ),
    );
  }

  Future<List<T>> response<T>(
    QueryResult<Object?> res,
    T Function(Map<String, dynamic>) fromJson,
    String path,
    String path2,
  ) async {
    try {
      if (res.data != null) {
        // ignore: avoid_dynamic_calls
        final list = res.data?[path][path2] as List<Object?>;

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

  Future<QueryResult> queryPage(int page, String path) async {
    return client.query(
      QueryOptions(
        document: gql(path),
        variables: <String, dynamic>{'page': page},
      ),
    );
  }

  Future<QueryResult> mutation(String path) async {
    return client.mutate(
      MutationOptions(document: gql(path)),
    );
  }
}
