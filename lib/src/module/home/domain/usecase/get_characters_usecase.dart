import 'package:dartz/dartz.dart';

import '../../../../src.dart';

class GetCharactersUsecase extends UseCase<List<Character>, int> {
  GetCharactersUsecase(this.reposiory);

  final HomeReposiory reposiory;

  @override
  Future<Either<Exception, List<Character>>> call(int params) {
    return reposiory.getCharacters(params);
  }
}
