part of 'counter_cubit.dart';

class CounterState extends Equatable {
  final int counter;
  final int transactioncount;

  const CounterState({
    this.counter = 0,
    this.transactioncount = 0,
  });

  copyWith({
    int? counter,
    int? transactioncount,
  }) =>
      CounterState(
          counter: counter ?? this.counter,
          transactioncount: transactioncount ?? this.transactioncount);

  @override
  List<Object> get props => [counter];
}
