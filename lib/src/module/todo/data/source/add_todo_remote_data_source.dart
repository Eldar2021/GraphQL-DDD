import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../../../src.dart';

class AddTodoRemoteDataSource with GraphQLMixin {
  AddTodoRemoteDataSource(this._client);

  final GraphQLClient _client;

  // ignore: avoid_positional_boolean_parameters
  Future<AddToDoModel> addTodoModel(String title, bool completed) async {
    try {
      final res = await mutation(addTodoMutation(title, completed));
      // ignore: avoid_dynamic_calls
      final json = res.data?['createTodo'] as Map<String, dynamic>;

      return AddToDoModel.fromJson(json);
    } catch (e) {
      debugPrint('$e');
      throw Exception();
    }
  }

  @override
  GraphQLClient get client => _client;
}

// ignore: avoid_positional_boolean_parameters
String addTodoMutation(String title, bool completed) => '''
mutation{
  createTodo(input: {title: "$title", completed: $completed}){
    id
    title
    completed
  }
}''';
