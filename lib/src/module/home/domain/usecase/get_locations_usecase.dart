import 'package:dartz/dartz.dart';

import '../../../../src.dart';

class GetLocationsUsecase extends UseCase<List<Location>, int> {
  GetLocationsUsecase(this.reposiory);

  final HomeReposiory reposiory;

  @override
  Future<Either<Exception, List<Location>>> call(int params) {
    return reposiory.getLocations(params);
  }
}
