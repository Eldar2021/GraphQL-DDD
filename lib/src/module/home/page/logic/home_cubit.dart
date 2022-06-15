import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:graphql_ddd/src/core/core.dart';
import 'package:graphql_ddd/src/module/module.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._repo) : super(const HomeState(0));

  final HomeReposiory _repo;

  void change(int val) => emit(HomeState(val));

  Future<List<Character>> getCharactersInPage(int page) async {
    final list = await _repo.getCharacters(page);

    return list.fold(
      (l) => throw _getFailureAndThrowExpection(l),
      (r) => r,
    );
  }

  Future<List<Episode>> getEpisodeInPage(int page) async {
    final list = await _repo.getEpisodes(page);

    return list.fold(
      (l) => throw _getFailureAndThrowExpection(l),
      (r) => r,
    );
  }

  Future<List<Location>> getLocationsInPage(int page) async {
    final list = await _repo.getLocations(page);

    return list.fold(
      (l) => throw _getFailureAndThrowExpection(l),
      (r) => r,
    );
  }

  Exception _getFailureAndThrowExpection(Exception l) {
    if (l is ServerExc) {
      return ServerExc('$l');
    } else if (l is CacheExc) {
      return CacheExc('$l');
    } else {
      return UnknownExc('$l');
    }
  }
}
