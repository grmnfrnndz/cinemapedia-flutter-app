import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/repositories/locals_storage_repository.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final favoriteMoviesProvider = StateNotifierProvider<FavoriteMoviesNotifier, Map<int, Movie>>((ref) {

  final localStorageRepositoryImpl = ref.watch(localStorageProvider);

  return FavoriteMoviesNotifier(localsStorageRepository: localStorageRepositoryImpl);
});


/*
  {
    1234: Movie,
    1234: Movie,
    1234: Movie,
    1234: Movie,
  }
*/



class FavoriteMoviesNotifier extends StateNotifier<Map<int, Movie>> {
  
  int page = 0;
  // abstract class
  final LocalsStorageRepository localsStorageRepository;
  
  FavoriteMoviesNotifier({required this.localsStorageRepository}): super({});


  Future<List<Movie>> loadNextPage() async {

    final movies = await localsStorageRepository.loadMovies(offset: page * 10); // todo limit
    page++;

    final tempMoviesMap = <int, Movie>{};
    for (final movie in movies) {
      tempMoviesMap[movie.id] = movie;
    }

    state = {...state, ...tempMoviesMap};
    return movies;
  }


  Future<void> toggleFavorite(Movie movie) async {

    await localsStorageRepository.toggleFavorite(movie);
    final bool isMovieInFavorites = state[movie.id] != null;
    
    if (isMovieInFavorites) {
      state.remove(movie.id);
      state = {...state};
    } else {
      state = {...state, movie.id: movie};
    }

  }


}




