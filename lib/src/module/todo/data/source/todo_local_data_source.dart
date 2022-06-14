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

class TodoLocalRepoImpl extends TodoLocalDataSource with HiveMixin {
  TodoLocalRepoImpl(this._box);

  final Box<String> _box;

  @override
  Future<void> cacheTodos(List<Todo> models) async {
    try {
      await put(cachedTodos, models);
    } catch (e) {
      throw CacheExc('$e');
    }
  }

  @override
  Future<void> cacheUsers(List<User> models) async {
    try {
      await put(cachedUsers, models);
    } catch (e) {
      throw CacheExc('$e');
    }
  }

  @override
  List<Todo>? getTodos() {
    final modelString = get(cachedTodos);
    if (modelString != null) {
      return modelType<Todo>(modelString, Todo.fromJson);
    } else {
      return null;
    }
  }

  @override
  List<User>? getUsers() {
    final modelString = get(cachedUsers);
    if (modelString != null) {
      return modelType<User>(modelString, User.fromJson);
    } else {
      return null;
    }
  }

  @override
  Box<String> get box => _box;
}
