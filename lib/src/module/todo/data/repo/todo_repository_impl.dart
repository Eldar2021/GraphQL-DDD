import 'package:dartz/dartz.dart';

import '../../../../src.dart';

class TodoRepoImpl extends TodoRepository with RepoMixin {
  TodoRepoImpl(
    this._networkInfo,
    this._localDataSource,
    this._remoteDataSource,
    this._addTodoRemoteDataSource,
  );

  final NetworkInfo _networkInfo;
  final TodoLocalDataSource _localDataSource;
  final TodoRemoteDataSource _remoteDataSource;
  final AddTodoRemoteDataSource _addTodoRemoteDataSource;

  @override
  Future<Either<Exception, List<Todo>>> getTodos() async {
    return response<Todo>(
      _remoteDataSource.getTodos,
      _localDataSource.cacheTodos,
      _localDataSource.getTodos,
    );
  }

  @override
  Future<Either<Exception, List<User>>> getUsers() async {
    return response<User>(
      _remoteDataSource.getUsers,
      _localDataSource.cacheUsers,
      _localDataSource.getUsers,
    );
  }

  @override
  Future<Either<Exception, AddToDoModel>> addTodo(
    String title,
    bool completed,
  ) async {
    if (await _networkInfo.isConnected()) {
      try {
        final model = await _addTodoRemoteDataSource.addTodoModel(
          title,
          completed,
        );
        return Right(model);
      } catch (e) {
        return Left(ServerExc('$e'));
      }
    } else {
      return Left(NetworkExc(null));
    }
  }

  @override
  NetworkInfo get networkInfo => _networkInfo;
}
