import 'package:flutter/material.dart';

class FavoritesView extends StatelessWidget {
  static const name = 'favorite-screen';
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite view"),
      ),
      body: const Center(
        child: Text("Favorites"),
      ),
    );
  }
}
