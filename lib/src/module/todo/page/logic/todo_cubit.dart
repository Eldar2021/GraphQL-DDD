import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../src.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<Fetchtate> {
  TodoCubit(this._getTodosUsecase) : super(FetchLoading());

  final GetTodosUsecase _getTodosUsecase;

  Future<void> fetchData() async {
    final res = await _getTodosUsecase(NoParams());

    res.fold(
      (l) => emit(FetchError(l)),
      (r) => emit(FetchSuccess<Todo>(r)),
    );
  }
}

class UsersCubit extends Cubit<Fetchtate> {
  UsersCubit(this._getUsersUsecase) : super(FetchLoading());

  final GetUsersUsecase _getUsersUsecase;

  Future<void> fetchData() async {
    final res = await _getUsersUsecase(NoParams());

    res.fold(
      (l) => emit(FetchError(l)),
      (r) => emit(FetchSuccess<User>(r)),
    );
  }
}
