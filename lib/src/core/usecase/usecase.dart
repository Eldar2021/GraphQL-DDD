import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

// ignore: one_member_abstracts
abstract class UseCase<Type, Params> {
  Future<Either<Exception, Type>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
