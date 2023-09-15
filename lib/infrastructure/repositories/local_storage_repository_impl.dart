import 'package:cinemapedia/domain/datasources/locals_storage_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/repositories/locals_storage_repository.dart';



class LocalStorageRepositoryImpl extends LocalsStorageRepository {
  

  final LocalsStorageDatasource datasource;

  LocalStorageRepositoryImpl(this.datasource);


  @override
  Future<bool> isMovieFavorite(int movieId) {
    return datasource.isMovieFavorite(movieId);
  }

  @override
  Future<List<Movie>> loadMovies({int limit = 10, int offset = 0}) {
    return datasource.loadMovies(limit:limit, offset:offset);
  }

  @override
  Future<void> toggleFavorite(Movie movie) {
    return datasource.toggleFavorite(movie);
  }

}