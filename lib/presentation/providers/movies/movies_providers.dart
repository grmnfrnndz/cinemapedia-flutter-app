import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final nowPlayingMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {

  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getNowPlaying;

  return MoviesNotifier(
    // ref to function - firm -> Future<List<Movie>> Function({int page});
    fetchMoreMovies: fetchMoreMovies
  );
});


// defined type function expected
typedef MovieCallBack = Future<List<Movie>> Function({int page});


// class to control state of my provider
// control class notifier with state stream List<Movie>
class MoviesNotifier extends StateNotifier<List<Movie>> {

  int currentPage = 0;
  MovieCallBack fetchMoreMovies;

  MoviesNotifier({required this.fetchMoreMovies}): super([]);

  Future<void> loadNextPage() async {
    currentPage++;

    // modify state
    final List<Movie> movies = await fetchMoreMovies(page: currentPage); 
    // always return new state
    // when state change notify all widgets
    state = [...movies];

  }


}



