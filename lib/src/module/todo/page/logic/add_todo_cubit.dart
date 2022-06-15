import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../src.dart';

part 'add_todo_state.dart';

class AddTodoCubit extends Cubit<AddTodoState> {
  AddTodoCubit(this._repo) : super(AddTodoInitial());

  final TodoRepository _repo;

  // ignore: avoid_positional_boolean_parameters
  Future<void> addTodo(String title, bool completed) async {
    emit(AddTodoLoading());
    final res = await _repo.addTodo(title, completed);
    res.fold((l) => emit(AddTodoError(l)), (r) => emit(AddTodoSuccess(r)));
  }
}
