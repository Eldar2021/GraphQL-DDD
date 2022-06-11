import 'package:dartz/dartz.dart';

import '../../../../src.dart';

class TodoRepoImpl implements TodoRepository {
  TodoRepoImpl(
    this._networkInfo,
    this._localDataSource,
    this._remoteDataSource,
  );

  final NetworkInfo _networkInfo;
  final TodoLocalDataSource _localDataSource;
  final TodoRemoteDataSource _remoteDataSource;

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
}
