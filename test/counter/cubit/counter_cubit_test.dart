import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_ddd/src/src.dart';


void main() {
  group('CounterCubit', () {
    test('initial state is 0', () {
      expect(CounterCubit().state, equals(0));
    });

    blocTest<CounterCubit, int>(
      'emits [1] when increment is called',
      build: CounterCubit.new,
      act: (cubit) => cubit.increment(),
      expect: () => [equals(1)],
    );

    blocTest<CounterCubit, int>(
      'emits [-1] when decrement is called',
      build: CounterCubit.new,
      act: (cubit) => cubit.decrement(),
      expect: () => [equals(-1)],
    );
  });
}