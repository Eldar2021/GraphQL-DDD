import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../src.dart';

part 'add_todo_state.dart';

class AddTodoCubit extends Cubit<AddTodoState> {
  AddTodoCubit(this._usecase) : super(AddTodoInitial());

  final AddTodoUsecase _usecase;

  // ignore: avoid_positional_boolean_parameters
  Future<void> addTodo(String title, bool completed) async {
    emit(AddTodoLoading());
    final res = await _usecase(AddToDoModel(title, completed));
    res.fold((l) => emit(AddTodoError(l)), (r) => emit(AddTodoSuccess(r)));
  }
}
