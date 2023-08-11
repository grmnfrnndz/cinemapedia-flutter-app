import 'package:cinemapedia/infrastructure/datasources/moviedb_datasource_impl.dart';
import 'package:cinemapedia/infrastructure/repositories/moviedb_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


// repository inmutable 
final movieRepositoryProvider = Provider((ref) {

  return MovieDbRepositoryImpl(MovieDbDatasourceImpl());

});




