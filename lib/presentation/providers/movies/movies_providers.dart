import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final nowPlayingMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  // ref to function
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getNowPlaying;

  return MoviesNotifier(
    // ref to function - firm -> Future<List<Movie>> Function({int page});
    fetchMoreMovies: fetchMoreMovies
  );
});

final popularMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  // ref to function
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getPopular;

  return MoviesNotifier(
    // ref to function - firm -> Future<List<Movie>> Function({int page});
    fetchMoreMovies: fetchMoreMovies
  );
});

final topRatedMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  // ref to function
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getTopRated;

  return MoviesNotifier(
    // ref to function - firm -> Future<List<Movie>> Function({int page});
    fetchMoreMovies: fetchMoreMovies
  );
});

final upcomingMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  // ref to function
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getUpcoming;

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
  bool isLoading = false;
  MovieCallBack fetchMoreMovies;

  MoviesNotifier({required this.fetchMoreMovies}): super([]);

  Future<void> loadNextPage() async {
    if (isLoading) return;

    isLoading = true;
    currentPage++;

    // modify state
    final List<Movie> movies = await fetchMoreMovies(page: currentPage); 
    // always return new state
    // when state change notify all widgets
    state = [...state, ...movies];

    await Future.delayed(const Duration(milliseconds: 400));

    isLoading = false;
  }


}



