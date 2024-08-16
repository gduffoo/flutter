import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(const CounterState()) {
    /*
    //forma sin factorizar
    on<CounterIncreased>(
      (event, emit) {
        emit(
          state.copywith(
            counter: state.counter + event.value,
            transactioncount: state.transactioncount + 1,
          ),
        );
      },
    );
     //fin counter increased
     
    on<CounterReset>(
      (event, emit) {
        emit(
          state.copywith(
            counter: 0,
          ),
        );
      },
    ); //fin Counter Reset
*/
    //forma factorizada sin argumentos
    //on<CounterIncreased> ( event, emit ) => _onCounterIncreased(event, emit)  ;

    //forma factorizada con argumentos
    //si argumentos son los mismos y en el mismo orden no hay q detallarlos
    on<CounterIncreased>(_onCounterIncreased);
    on<CounterReset>(_onCounterReset);
  }

  void _onCounterIncreased(CounterIncreased event, Emitter<CounterState> emit) {
    emit(
      state.copywith(
        counter: state.counter + event.value,
        transactioncount: state.transactioncount + 1,
      ),
    );
  }

  void _onCounterReset(CounterReset event, Emitter<CounterState> emit) {
    emit(
      state.copywith(
        counter: 0,
      ),
    );
  }

//simplificar llamadas desde el consumer, usa metodos si necesidad de saber el on
  void increasedBy([int value = 0]) {
    add(CounterIncreased(value));
  }

  void resetCounter() {
    add(CounterReset());
  }
}
