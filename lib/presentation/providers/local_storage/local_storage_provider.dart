import 'package:cinemapedia/infrastructure/datasources/isar_datasource_impl.dart';
import 'package:cinemapedia/infrastructure/repositories/local_storage_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localStorageProvider = Provider((ref) {

  return LocalStorageRepositoryImpl(IsarDatasourceImpl());

});