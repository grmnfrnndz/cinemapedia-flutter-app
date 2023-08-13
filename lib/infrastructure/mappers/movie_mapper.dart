import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/movie_moviedb.dart';

class MovieMapper {
  static Movie movieDBToEntity(MovieDB movieDB) => Movie(
      adult: movieDB.adult ?? false,
      backdropPath: (movieDB.backdropPath == '')  
      ? 'no-poster'
      : 'https://image.tmdb.org/t/p/w500${movieDB.backdropPath}'
      ,
      genreIds: movieDB.genreIds.map((e) => e.toString()).toList(),
      id: movieDB.id,
      originalLanguage: movieDB.originalLanguage,
      originalTitle: movieDB.originalTitle,
      overview: movieDB.overview,
      popularity: movieDB.popularity,
      posterPath: (movieDB.posterPath == '')  
      ? 'no-poster'
      : 'https://image.tmdb.org/t/p/w500${movieDB.posterPath}'
      ,
      releaseDate: (movieDB.releaseDate != null) ? movieDB.releaseDate : null,
      title: movieDB.title,
      video: movieDB.video,
      voteAverage: movieDB.voteAverage,
      voteCount: movieDB.voteCount);
}
