import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_app/presentation/blocs/counter_bloc/counter_bloc.dart';

class BlocCounterScreen extends StatelessWidget {
  const BlocCounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterBloc(),
      child: const BlockCounterView(),
    );
  }
}

class BlockCounterView extends StatelessWidget {
  const BlockCounterView({
    super.key,
  });

  void increasedCounterBy(BuildContext context, [int value = 0]) {
    //si sabes el nombre del evento on
    //context.read<CounterBloc>().add(CounterIncreased(value));

    //usando metodo para facilitar lectura
    context.read<CounterBloc>().increasedBy(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: context.select((CounterBloc bloc) =>
            Text("Bloc Counter ${bloc.state.transactioncount}")),
        actions: [
          IconButton(
              onPressed: () {
                //forma con el metodo ON
                //context.read<CounterBloc>().add(CounterReset());

                //forma con metodo personizado
                context.read<CounterBloc>().resetCounter();
              },
              icon: const Icon(Icons.refresh_outlined))
        ],
      ),
      body: Center(
        child: context.select((CounterBloc counterBloc) =>
            Text('Contador: ${counterBloc.state.counter}')),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => increasedCounterBy(context, 3),
            heroTag: '1',
            child: const Text('+3'),
          ),
          const SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            onPressed: () {
              context.read<CounterBloc>().add(
                  const CounterIncreased(2)); //otra forma si usar la funcion
            },
            heroTag: '2',
            child: const Text('+2'),
          ),
          const SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            onPressed: () => increasedCounterBy(context, 1),
            heroTag: '3',
            child: const Text('+1'),
          ),
        ],
      ),
    );
  }
}
