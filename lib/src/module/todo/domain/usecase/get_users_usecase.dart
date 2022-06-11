import 'package:dartz/dartz.dart';

import '../../../../src.dart';

class GetUsersUsecase extends UseCase<List<User>, NoParams> {
  GetUsersUsecase(this.repository);

  final TodoRepository repository;

  @override
  Future<Either<Exception, List<User>>> call(NoParams params) async {
    return repository.getUsers();
  }
}
