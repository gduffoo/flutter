import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helper/human_formats.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MovieHorizontalListView extends StatefulWidget {
  final List<Movie> movies;
  final String? title;
  final String? subTitle;
  final VoidCallback? loadNextPage;

  const MovieHorizontalListView(
      {super.key,
      required this.movies,
      this.title,
      this.subTitle,
      this.loadNextPage});

  @override
  State<MovieHorizontalListView> createState() =>
      _MovieHorizontalListViewState();
}

class _MovieHorizontalListViewState extends State<MovieHorizontalListView> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (widget.loadNextPage == null) return;
      if (scrollController.position.pixels + 200 >=
          scrollController.position.maxScrollExtent) {
        widget.loadNextPage!();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 380,
      child: Column(
        children: [
          if (widget.title != null || widget.subTitle != null)
            _Title(
              title: widget.title,
              subtitle: widget.subTitle,
            ),
          //const _Slide(),
          const SizedBox(
            height: 5,
          ),
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: widget.movies.length,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return FadeInRight(
                  child: _Slide(
                    movie: widget.movies[index],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Movie movie;

  const _Slide({required this.movie});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;

    return Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 8,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 150,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  movie.posterPath,
                  width: 350,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress != null) {
                      return const Padding(
                        padding: EdgeInsets.all(8),
                        child: Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        ),
                      );
                    }
                    return GestureDetector(
                      onTap: () => context.push("/movie/${movie.id}"),
                      child: FadeIn(child: child),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            //titulo

            SizedBox(
              height: 30,
              child: Text(
                movie.title,
                maxLines: 2,
                style: textStyle.titleSmall,
              ),
            ),

            Row(
              children: [
                Icon(
                  Icons.star_half_outlined,
                  color: Colors.yellow.shade800,
                ),
                const SizedBox(
                  width: 3,
                ),
                Text(
                  '${movie.voteAverage}',
                  style: textStyle.bodyMedium
                      ?.copyWith(color: Colors.yellow.shade800),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  HumanFormat.number(movie.popularity),
                  style: textStyle.bodySmall,
                ),
                /* Text(
                  '${movie.popularity}',
                  style: textStyle.bodySmall,
                )*/
              ],
            )
          ],
        ));
  }
}

class _Title extends StatelessWidget {
  final String? title;
  final String? subtitle;
  const _Title({this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge;

    return Container(
        padding: const EdgeInsets.only(top: 15),
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          children: [
            Text(
              title ?? "",
              style: titleStyle,
            ),
            const Spacer(),
            FilledButton.tonal(
              style: const ButtonStyle(visualDensity: VisualDensity.compact),
              onPressed: () {},
              child: Text(subtitle ?? ""),
            )
          ],
        ));
  }
}
