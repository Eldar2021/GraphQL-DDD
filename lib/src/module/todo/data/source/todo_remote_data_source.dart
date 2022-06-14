import 'package:graphql_flutter/graphql_flutter.dart';

import '../../../../src.dart';

abstract class TodoRemoteDataSource {
  Future<List<Todo>> getTodos();

  Future<List<User>> getUsers();
}

class TodoRemoteImpl extends TodoRemoteDataSource with GraphQLMixin {
  TodoRemoteImpl(this._client);

  final GraphQLClient _client;

  @override
  Future<List<Todo>> getTodos() async {
    final res = await query(getTodoQuery);
    return response(res, Todo.fromJson, 'todos', 'data');
  }

  @override
  Future<List<User>> getUsers() async {
    final res = await query(getUsersQuery);
    return response(res, User.fromJson, 'users', 'data');
  }

  @override
  GraphQLClient get client => _client;
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
