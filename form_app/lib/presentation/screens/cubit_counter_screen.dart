import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_app/presentation/blocs/counter_cubit/counter_cubit.dart';

class CubitCounterScreen extends StatelessWidget {
  const CubitCounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterCubit(),
      child: const _CounterCubitScreen(),
    );
  }
}

class _CounterCubitScreen extends StatelessWidget {
  const _CounterCubitScreen();

  @override
  Widget build(BuildContext context) {
    final counterState = context
        .watch<CounterCubit>()
        .state; //todos los objectos del widget pueden ver el counterState

    return Scaffold(
      appBar: AppBar(
        title: Text("Cubit Counter ${counterState.transactioncount}"),
        actions: [
          IconButton(
              onPressed: () {
                context.read<CounterCubit>().reset();
              },
              icon: const Icon(Icons.refresh_outlined))
        ],
      ),
      body: Center(
        child: BlocBuilder<CounterCubit, CounterState>(
          //buildWhen: (previous, current) => current.counter !=previous.counter, //se reconstruye solo si cumple la condicion
          builder: (context, state) {
            //solo el text esta asociado al counter cubir
            return Text('Contador: ${state.counter} ');
          },
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              context.read<CounterCubit>().increseBy(3);
            },
            heroTag: '1',
            child: const Text('+3'),
          ),
          const SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            onPressed: () {
              context.read<CounterCubit>().increseBy(2);
            },
            heroTag: '2',
            child: const Text('+2'),
          ),
          const SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            onPressed: () {
              context.read<CounterCubit>().increseBy(1);
            },
            heroTag: '3',
            child: const Text('+1'),
          ),
        ],
      ),
    );
  }
}
