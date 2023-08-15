import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/domain/entities/movie.dart';


final movieInfoProvider = StateNotifierProvider<MovieMapNotifier, Map<String, Movie>>((ref) {
  
  final fetchMovie = ref.watch(movieRepositoryProvider).getMovieById;

  return MovieMapNotifier(
    getMovie: fetchMovie
  );
});


  /*
   {
      '12345': Movie()
   }
   */

typedef GetMovieCallback = Future<Movie>Function(String movieId);


class MovieMapNotifier extends StateNotifier<Map<String, Movie>> {
  

  final GetMovieCallback getMovie;

  // initialize with empty map
  MovieMapNotifier({required this.getMovie}): super({});


  Future<void> loadMovie(String movieId) async {

    if(state[movieId] != null) return;

    final movie = await getMovie(movieId);

    state = {...state, movieId: movie};
  }


}

