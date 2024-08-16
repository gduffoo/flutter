part of 'counter_bloc.dart';

class CounterState extends Equatable {
  final int counter;
  final int transactioncount;

  const CounterState({this.counter = 10, this.transactioncount = 0});

  CounterState copywith({int? counter, int? transactioncount}) => CounterState(
      counter: counter ?? this.counter,
      transactioncount: transactioncount ?? this.transactioncount);

  @override
  List<Object> get props => [counter];
}

final class CounterInitial extends CounterState {}
