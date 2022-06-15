import 'package:dartz/dartz.dart';

import '../../../../src.dart';

abstract class HomeReposiory {
  Future<Either<Exception, List<Character>>> getCharacters(int page);

  Future<Either<Exception, List<Episode>>> getEpisodes(int page);

  Future<Either<Exception, List<Location>>> getLocations(int page);
}

class HomeRepoImpl extends HomeReposiory with RepoMixin {
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
    return responsePage<Character>(
      _remoteDataSource.getCharacters,
      _localDataSource.cacheCharacters,
      _localDataSource.getLastCharacters,
      page,
    );
  }

  @override
  Future<Either<Exception, List<Episode>>> getEpisodes(int page) async {
    return responsePage<Episode>(
      _remoteDataSource.getEpisodes,
      _localDataSource.cacheEpisodes,
      _localDataSource.getLastEpisodes,
      page,
    );
  }

  @override
  Future<Either<Exception, List<Location>>> getLocations(int page) async {
    return responsePage<Location>(
      _remoteDataSource.getLocations,
      _localDataSource.cacheLocations,
      _localDataSource.getLastLocations,
      page,
    );
  }

  @override
  NetworkInfo get networkInfo => _networkInfo;
}
