part of 'home_cubit.dart';

class HomeState extends Equatable {
  const HomeState(this.val);

  final int val;

  @override
  List<Object> get props => [val];
}
