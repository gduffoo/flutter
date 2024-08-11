import 'package:cinemapedia/presentation/screens/widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
//import 'package:cinemapedia/presentation/views/views.dart';

class HomeScreen extends StatelessWidget {
  /// Creamos el nombre de la ruta
  static const String name = 'home-screen';

  // En lugar de recibir el Widget childView, reemplazamos por el shell de navegación,
  // el cual, es un contenedor de las ramas que definimos en el router.
  final StatefulNavigationShell navigationShell;

  const HomeScreen({
    super.key,
    required this.navigationShell,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: CustomBottomNavigation(
        // Pasamos como argumento el shell de navegación
        navigationShell: navigationShell,
      ),
    );
  }
}
