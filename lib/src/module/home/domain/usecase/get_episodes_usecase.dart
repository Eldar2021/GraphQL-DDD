import 'package:dartz/dartz.dart';

import '../../../../src.dart';

class GetEpisodesUsecase extends UseCase<List<Episode>, int> {
  GetEpisodesUsecase(this.reposiory);

  final HomeReposiory reposiory;

  @override
  Future<Either<Exception, List<Episode>>> call(int params) {
    return reposiory.getEpisodes(params);
  }
}
