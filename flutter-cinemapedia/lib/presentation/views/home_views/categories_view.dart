import 'package:flutter/material.dart';

class CategoriesView extends StatelessWidget {
  static const name = 'favorite-screen';
  const CategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Categories view"),
      ),
      body: const Center(
        child: Text("Categorias"),
      ),
    );
  }
}
