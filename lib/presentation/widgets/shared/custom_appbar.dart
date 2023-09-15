import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/delegates/delegates.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';


class CustomAppBar extends ConsumerWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final colors = Theme.of(context).colorScheme;
    final titleStyleMedium = Theme.of(context).textTheme.titleMedium;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Icon(Icons.movie_outlined, color: colors.primary),
              const SizedBox(width: 5,),
              Text('CINEMAPEDIA', style: titleStyleMedium),
              const Spacer(),
              IconButton(onPressed: () {
                // sean reference to function
                final searchMovies = ref.read(searchMoviesProvider);
                final queryProvider = ref.read(searchQueryPovider);


                showSearch<Movie?>(
                  query: queryProvider,
                  context: context, 
                  delegate: SearchMovieDelegate(
                    initialMovies: searchMovies,
                    searchMovies: ref.read(searchMoviesProvider.notifier).searchMoviesByQuery
                  )
                ).then((movie) {

                  if (movie == null) return;

                  context.push('/home/0/movie/${movie.id}');

                });

              }, icon: const Icon(Icons.search))
            ],
          ),
        ),
      )
    );
  }
}