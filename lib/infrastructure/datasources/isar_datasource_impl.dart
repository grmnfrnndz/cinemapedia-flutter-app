
import 'package:path_provider/path_provider.dart';
import 'package:isar/isar.dart';

import 'package:cinemapedia/domain/datasources/locals_storage_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';

class IsarDatasourceImpl extends LocalsStorageDatasource {
  
  late Future<Isar> db;

  IsarDatasourceImpl() {
    db = openDb();
  }


  Future<Isar> openDb() async {
    final dir = await getApplicationDocumentsDirectory();

    if(Isar.instanceNames.isEmpty) {
      return await Isar.open(
        [MovieSchema],
        inspector: true,
        directory: dir.path,
      );
    }

    return Future.value(Isar.getInstance());
  }

  @override
  Future<bool> isMovieFavorite(int movieId) async {
    final isar = await db;
    final Movie? isFavoriteMovie = await isar.movies
    .filter()
    .idEqualTo(movieId)
    .findFirst();
    return isFavoriteMovie != null;
  }

  @override
  Future<void> toggleFavorite(Movie movie) async {
    final isar = await db;

    final favoriteMovie = await isar.movies
    .filter()
    .idEqualTo(movie.id)
    .findFirst();

    if (favoriteMovie != null) {
      // delete
       isar.writeTxnSync(() => isar.movies.deleteSync(favoriteMovie.isarId!));
       return;
    }

    // insert
    isar.writeTxnSync(() => isar.movies.putSync(movie));

  }


  @override
  Future<List<Movie>> loadMovies({int limit = 10, int offset = 0}) async {
    final isar = await db;

    return  await isar.movies
    .where()
    .offset(offset)
    .limit(limit)
    .findAll();
  }
}