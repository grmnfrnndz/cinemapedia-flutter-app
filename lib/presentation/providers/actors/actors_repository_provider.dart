import 'package:cinemapedia/infrastructure/datasources/actordb_datasource_impl.dart';
import 'package:cinemapedia/infrastructure/repositories/actordb_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


// repository inmutable 

final actorRepositoryProvider = Provider((ref) {

  return ActorDbRepositoryImpl(ActorDbDatasourceImpl());

});

