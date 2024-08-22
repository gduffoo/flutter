import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox.expand(
      child: Center(
        child: CircularProgressIndicator.adaptive(
          //adaptativo se adapta al apltaforma ios/android,etc
          strokeWidth: 2,
        ),
      ),
    ); //toma todo el espacio del padre
  }
}
