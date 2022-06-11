part of 'todo_cubit.dart';

abstract class Fetchtate extends Equatable {
  const Fetchtate();

  @override
  List<Object> get props => [];
}

class FetchLoading extends Fetchtate {}

class FetchSuccess<T> extends Fetchtate {
  const FetchSuccess(this.list);

  final List<T> list;

  @override
  List<Object> get props => [list];
}

class FetchError extends Fetchtate {
  const FetchError(this.exception);

  final Exception exception;

  @override
  List<Object> get props => [exception];
}
