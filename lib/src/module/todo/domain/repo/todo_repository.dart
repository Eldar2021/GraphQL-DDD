import 'package:dartz/dartz.dart';

import '../domain.dart';

abstract class TodoRepository {
  Future<Either<Exception, List<User>>> getUsers();

  Future<Either<Exception, List<Todo>>> getTodos();

  // ignore: avoid_positional_boolean_parameters
  Future<Either<Exception, AddToDoModel>> addTodo(String title, bool completed);
}
