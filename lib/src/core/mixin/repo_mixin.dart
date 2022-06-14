import 'package:dartz/dartz.dart';

import '../../src.dart';

mixin RepoMixin {
  NetworkInfo get networkInfo;

  Future<Either<Exception, List<R>>> responsePage<R>(
    Future<List<R>> Function(int page) getRemote,
    Future<void> Function(List<R> models, int page) cache,
    List<R>? Function(int page) getLocal,
    int page,
  ) async {
    if (await networkInfo.isConnected()) {
      try {
        final _models = await getRemote(page);
        await cache(_models, page);
        return Right(_models);
      } catch (e) {
        return Left(ServerExc('$e'));
      }
    } else {
      try {
        final _models = getLocal(page);
        return Right(_models ?? []);
      } catch (e) {
        return Left(ServerExc('$e'));
      }
    }
  }

  Future<Either<Exception, List<R>>> response<R>(
    Future<List<R>> Function() getRemote,
    Future<void> Function(List<R> models) cache,
    List<R>? Function() getLocal,
  ) async {
    if (await networkInfo.isConnected()) {
      try {
        final _models = await getRemote();
        await cache(_models);
        return Right(_models);
      } catch (e) {
        return Left(ServerExc('$e'));
      }
    } else {
      try {
        final _models = getLocal();
        return Right(_models ?? []);
      } catch (e) {
        return Left(ServerExc('$e'));
      }
    }
  }
}
