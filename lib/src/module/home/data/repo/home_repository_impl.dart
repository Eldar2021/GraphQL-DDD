import 'package:dartz/dartz.dart';

import '../../../../src.dart';

class HomeRepoImpl implements HomeReposiory {
  HomeRepoImpl(
    this._localDataSource,
    this._remoteDataSource,
    this._networkInfo,
  );

  final HomeLocalDataSource _localDataSource;
  final HomeRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  @override
  Future<Either<Exception, List<Character>>> getCharacters(int page) async {
    if (await _networkInfo.isConnected()) {
      try {
        final _models = await _remoteDataSource.getCharacters(page);
        await _localDataSource.cacheCharacters(_models, page);
        return Right(_models);
      } catch (e) {
        return Left(ServerExc('$e'));
      }
    } else {
      try {
        final _models = _localDataSource.getLastCharacters(page);
        return Right(_models ?? []);
      } catch (e) {
        return Left(ServerExc('$e'));
      }
    }
  }

  @override
  Future<Either<Exception, List<Episode>>> getEpisodes(int page) async {
    if (await _networkInfo.isConnected()) {
      try {
        final _models = await _remoteDataSource.getEpisodes(page);
        
        await _localDataSource.cacheEpisodes(_models, page);
        return Right(_models);
      } catch (e) {
        return Left(ServerExc('$e'));
      }
    } else {
      try {
        final _models = _localDataSource.getLastEpisodes(page);
        return Right(_models ?? []);
      } catch (e) {
        return Left(ServerExc('$e'));
      }
    }
  }

  @override
  Future<Either<Exception, List<Location>>> getLocations(int page) async {
    if (await _networkInfo.isConnected()) {
      try {
        final _models = await _remoteDataSource.getLocations(page);
        await _localDataSource.cacheLocations(_models, page);
        return Right(_models);
      } catch (e) {
        return Left(ServerExc('$e'));
      }
    } else {
      try {
        final _models = _localDataSource.getLastLocations(page);
        return Right(_models ?? []);
      } catch (e) {
        return Left(ServerExc('$e'));
      }
    }
  }
}
