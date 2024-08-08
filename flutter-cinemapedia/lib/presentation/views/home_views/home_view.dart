import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/screens/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();

    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(incomingMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final initialLoading = ref.watch(initialLoadingProvider);

    if (initialLoading) return const FullScreenLoader();

    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final topratedMovies = ref.watch(topRatedMoviesProvider);
    final incomingMovies = ref.watch(incomingMoviesProvider);

    final moviesSlideShow = ref.watch(moviesSlideShowProvider);

    return SingleChildScrollView(
      child: Column(
        children: [
          const CustomAppBar(),
          MoviesSlideShow(
            movies: moviesSlideShow,
          ),
          MovieHorizontalListView(
            movies: nowPlayingMovies,
            title: "En cines",
            subTitle: "fecha de hoy",
            loadNextPage: () {
              ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
            },
          ),
          MovieHorizontalListView(
            movies: popularMovies,
            title: "Popular",
            subTitle: "lo mas visto",
            loadNextPage: () {
              ref.read(popularMoviesProvider.notifier).loadNextPage();
            },
          ),
          MovieHorizontalListView(
            movies: topratedMovies,
            title: "Mas votado",
            subTitle: "mejor puntuacion",
            loadNextPage: () {
              ref.read(topRatedMoviesProvider.notifier).loadNextPage();
            },
          ),
          MovieHorizontalListView(
            movies: incomingMovies,
            title: "Proximamente",
            subTitle: "pronto",
            loadNextPage: () {
              ref.read(incomingMoviesProvider.notifier).loadNextPage();
            },
          ),
        ],
      ),
    );
  }
}
