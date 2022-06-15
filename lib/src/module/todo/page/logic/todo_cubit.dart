import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../src.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<Fetchtate> {
  TodoCubit(this._repo) : super(FetchLoading());

  final TodoRepository _repo;

  Future<void> fetchData() async {
    final res = await _repo.getTodos();

    res.fold(
      (l) => emit(FetchError(l)),
      (r) => emit(FetchSuccess<Todo>(r)),
    );
  }
}

class UsersCubit extends Cubit<Fetchtate> {
  UsersCubit(this._repo) : super(FetchLoading());

  final TodoRepository _repo;

  Future<void> fetchData() async {
    final res = await _repo.getUsers();

    res.fold(
      (l) => emit(FetchError(l)),
      (r) => emit(FetchSuccess<User>(r)),
    );
  }
}
