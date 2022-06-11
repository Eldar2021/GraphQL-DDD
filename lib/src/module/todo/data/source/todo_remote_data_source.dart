import 'package:flutter/foundation.dart';
import 'package:graphql_ddd/src/module/module.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

abstract class TodoRemoteDataSource {
  Future<List<Todo>> getTodos();

  Future<List<User>> getUsers();
}

class TodoRemoteImpl implements TodoRemoteDataSource {
  TodoRemoteImpl(this._client);

  final GraphQLClient _client;

  @override
  Future<List<Todo>> getTodos() async {
    final res = await _query(getTodoQuery);
    return _response(res, Todo.fromJson, 'todos');
  }

  @override
  Future<List<User>> getUsers() async {
    final res = await _query(getUsersQuery);
    return _response(res, User.fromJson, 'users');
  }

  Future<List<T>> _response<T>(
    QueryResult<Object?> res,
    T Function(Map<String, dynamic>) fromJson,
    String named,
  ) async {
    try {
      if (res.data != null) {
        // ignore: avoid_dynamic_calls
        final list = res.data?[named]['data'] as List<Object?>;

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

  Future<QueryResult> _query(String path) async {
    return _client.query(
      QueryOptions(
        document: gql(path),
      ),
    );
  }
}

// ignore: leading_newlines_in_multiline_strings
const String getUsersQuery = '''query{
  users{
    data{
      id
      name
    }
  }
}''';

// ignore: leading_newlines_in_multiline_strings
const String getTodoQuery = '''query{
  todos{
    data{
      id
      title
      completed
      user{
        id
        name
      }
    }
  }
}''';
