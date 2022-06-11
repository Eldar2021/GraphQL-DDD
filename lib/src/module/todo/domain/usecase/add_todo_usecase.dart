import 'package:dartz/dartz.dart';

import '../../../../src.dart';

class AddTodoUsecase extends UseCase<AddToDoModel, AddToDoModel> {
  AddTodoUsecase(this.repository);

  final TodoRepository repository;

  @override
  Future<Either<Exception, AddToDoModel>> call(AddToDoModel params) async {
    return repository.addTodo(params.title, params.completed);
  }
}
