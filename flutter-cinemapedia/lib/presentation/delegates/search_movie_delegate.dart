import 'package:cinemapedia/config/helper/human_formats.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';

typedef SearchMoviesCallBack = Future<List<Movie>> Function(String query);

class SearchMovieDelegate extends SearchDelegate<Movie?> {
  final SearchMoviesCallBack searchMovies;
  final List<Movie> initialMovies;

  SearchMovieDelegate({
    required this.searchMovies,
    required this.initialMovies,
  });

  @override
  String? get searchFieldLabel => "Buscar Peli";

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          onPressed: () {
            query = "";
          },
          icon: const Icon(Icons.clear),
        ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
      //initialData: initialMovies,
      future: searchMovies(query),
      builder: (context, snapshot) {
        final movies = snapshot.data ?? [];

        return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              return _MovieItem(
                movie: movie,
                onMovieSelected: close,
              );
            });
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      initialData: initialMovies,
      future: searchMovies(query),
      builder: (context, snapshot) {
        final movies = snapshot.data ?? [];

        return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              return _MovieItem(
                movie: movie,
                onMovieSelected: close,
              );
            });
      },
    );
  }
}

class _MovieItem extends StatelessWidget {
  final Movie movie;
  final Function onMovieSelected;

  const _MovieItem({required this.movie, required this.onMovieSelected});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        onMovieSelected(context, movie);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            //imagen
            SizedBox(
              width: size.width * 0.2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(movie.posterPath),
              ),
            ),
            //descripcion
            SizedBox(
              width: size.width * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(movie.title, style: textStyle.titleMedium),
                  (movie.overview.length > 200)
                      ? Text('${movie.overview.substring(0, 200)}...')
                      : Text(movie.overview),
                  Row(
                    children: [
                      const Icon(
                        Icons.star_half_rounded,
                        color: Colors.yellow,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        HumanFormat.number(movie.voteAverage, 1),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
