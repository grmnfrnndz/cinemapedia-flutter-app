import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';

final searchQueryPovider = StateProvider<String>((ref) => '');

// final searchQueryPovider = Provider((ref) => '');


final searchMoviesProvider = StateNotifierProvider<SearchMoviesNotifier, List<Movie>>((ref) {

  final movieProvider = ref.read(movieRepositoryProvider);

  return SearchMoviesNotifier(
    ref: ref,
    searchMovies: movieProvider.searchMovies
  );

});


typedef SearchMoviesCallback = Future<List<Movie>>Function(String query);


class SearchMoviesNotifier extends StateNotifier<List<Movie>> {
  
  final SearchMoviesCallback searchMovies;
  final Ref ref;

  SearchMoviesNotifier({required this.searchMovies, required this.ref}): super([]);

  Future<List<Movie>> searchMoviesByQuery(String query) async {

    ref.read(searchQueryPovider.notifier).update((state) => query);

    final movies = await searchMovies(query);
    
    state = movies;

    return movies;
  }

}
