import 'package:flutter/material.dart';
import 'package:graphql_ddd/src/module/module.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class AddTodoRemoteDataSource {
  AddTodoRemoteDataSource(this._client);

  final GraphQLClient _client;

  // ignore: avoid_positional_boolean_parameters
  Future<AddToDoModel> addTodoModel(String title, bool completed) async {
    try {
      final res = await _client.mutate(
        MutationOptions(
          document: gql(addTodoMutation(title, completed)),
        ),
      );
      // ignore: avoid_dynamic_calls
      final json = res.data?['createTodo'] as Map<String, dynamic>;

      return AddToDoModel.fromJson(json);
    } catch (e) {
      debugPrint('$e');
      throw Exception();
    }
  }
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
