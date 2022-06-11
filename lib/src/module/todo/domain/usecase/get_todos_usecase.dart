import 'package:dartz/dartz.dart';

import '../../../../src.dart';

class GetTodosUsecase extends UseCase<List<Todo>, NoParams> {
  GetTodosUsecase(this.repository);

  final TodoRepository repository;

  @override
  Future<Either<Exception, List<Todo>>> call(NoParams params) async {
    return repository.getTodos();
  }
}
