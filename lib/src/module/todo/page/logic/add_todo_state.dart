part of 'add_todo_cubit.dart';

abstract class AddTodoState extends Equatable {
  const AddTodoState();

  @override
  List<Object> get props => [];
}
class AddTodoInitial extends AddTodoState {}

class AddTodoLoading extends AddTodoState {}

class AddTodoSuccess extends AddTodoState {
  const AddTodoSuccess(this.model);

  final AddToDoModel model;

  @override
  List<Object> get props => [model];
}

class AddTodoError extends AddTodoState {
  const AddTodoError(this.exception);

  final Exception exception;

  @override
  List<Object> get props => [exception];
}
