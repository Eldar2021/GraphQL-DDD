import 'dart:convert';

import 'package:hive/hive.dart';

import '../../../../src.dart';

const String cachedTodos = 'CacheTodos';
const String cachedUsers = 'CacheUsers';

abstract class TodoLocalDataSource {
  List<Todo>? getTodos();

  Future<void> cacheTodos(List<Todo> models);

  List<User>? getUsers();

  Future<void> cacheUsers(List<User> models);
}

class TodoLocalRepoImpl implements TodoLocalDataSource {
  TodoLocalRepoImpl(this._box);

  final Box<String> _box;

  @override
  Future<void> cacheTodos(List<Todo> models) async {
    try {
      await _box.put(
        cachedTodos,
        json.encode(models.map((e) => e.toJson()).toList()),
      );
    } catch (e) {
      throw CacheExc('$e');
    }
  }

  @override
  Future<void> cacheUsers(List<User> models) async {
    try {
      await _box.put(
        cachedUsers,
        json.encode(models.map((e) => e.toJson()).toList()),
      );
    } catch (e) {
      throw CacheExc('$e');
    }
  }

  @override
  List<Todo>? getTodos() {
    final modelString = _box.get(cachedTodos);
    if (modelString != null) {
      final listModel = json.decode(modelString) as List;
      return listModel
          .map<Todo>(
            (dynamic e) => Todo.fromJson(e as Map<String, dynamic>),
          )
          .toList();
    } else {
      return null;
    }
  }

  @override
  List<User>? getUsers() {
    final modelString = _box.get(cachedUsers);
    if (modelString != null) {
      final listModel = json.decode(modelString) as List;
      return listModel
          .map<User>(
            (dynamic e) => User.fromJson(e as Map<String, dynamic>),
          )
          .toList();
    } else {
      return null;
    }
  }
}
