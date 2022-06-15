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
  Future<void> cacheTodos(List<Todo> models) async => _put(cachedTodos, models);

  @override
  Future<void> cacheUsers(List<User> models) async => _put(cachedUsers, models);

  Future<void> _put(String key, List<Model> _models) async {
    try {
      await put(key, _models);
    } catch (e) {
      throw CacheExc('$e');
    }
  }

  @override
  List<Todo>? getTodos() => _getData<Todo>(cachedTodos, Todo.fromJson);

  @override
  List<User>? getUsers() => _getData<User>(cachedUsers, User.fromJson);

  List<T>? _getData<T>(
    String key,
    T Function(Map<String, dynamic> body) fromJson,
  ) {
    final modelString = get(key);
    if (modelString != null) {
      return modelType<T>(modelString, fromJson);
    } else {
      return null;
    }
  }

  @override
  Box<String> get box => _box;
}
