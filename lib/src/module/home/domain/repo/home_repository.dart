import 'package:dartz/dartz.dart';

import '../entity/entity.dart';

abstract class HomeReposiory {
  Future<Either<Exception, List<Character>>> getCharacters(int page);

  Future<Either<Exception, List<Episode>>> getEpisodes(int page);

  Future<Either<Exception, List<Location>>> getLocations(int page);
}
