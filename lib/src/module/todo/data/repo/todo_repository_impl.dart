import 'package:dartz/dartz.dart';

import '../../../../src.dart';

class TodoRepoImpl implements TodoRepository {
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
    if (await _networkInfo.isConnected()) {
      try {
        final _models = await _remoteDataSource.getTodos();

        await _localDataSource.cacheTodos(_models);
        return Right(_models);
      } catch (e) {
        return Left(ServerExc('$e'));
      }
    } else {
      try {
        final _models = _localDataSource.getTodos();
        return Right(_models ?? []);
      } catch (e) {
        return Left(ServerExc('$e'));
      }
    }
  }

  @override
  Future<Either<Exception, List<User>>> getUsers() async {
    if (await _networkInfo.isConnected()) {
      try {
        final _models = await _remoteDataSource.getUsers();
        await _localDataSource.cacheUsers(_models);
        return Right(_models);
      } catch (e) {
        return Left(ServerExc('$e'));
      }
    } else {
      try {
        final _models = _localDataSource.getUsers();
        return Right(_models ?? []);
      } catch (e) {
        return Left(ServerExc('$e'));
      }
    }
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
}
