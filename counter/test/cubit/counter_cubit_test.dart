import 'package:bloc_test/bloc_test.dart';
import 'package:counter/cubit/counter_cubit.dart';

void main() {
  blocTest(
    'the cubit shoul emit a CounterState(counterValue:1, wasIncremented: true, when cubit.increment function is called',
    build: () => CounterCubit(),
    act: (cubit) => cubit.increment(),
    expect: () => [CounterState(counterValue: 1, wasIncremented: true)],
  );

  blocTest(
    'the cubit shoul emit a CounterState(counterValue:-1, wasIncremented: false, when cubit.decrement function is called',
    build: () => CounterCubit(),
    act: (cubit) => cubit.decrement(),
    expect: () => [CounterState(counterValue: -1, wasIncremented: false)],
  );
}