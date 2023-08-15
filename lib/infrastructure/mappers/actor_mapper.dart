import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/infrastructure/models/models.dart';

class ActorMapper {
  static Actor castToEntity(Cast cast) => 
    Actor(
      id: cast.id.toString(), 
      name: cast.name, 
      profilePath: (cast.profilePath != null) 
      ? 'https://image.tmdb.org/t/p/w500${cast.profilePath}'
      : 'no-path',
      character: cast.character
  );
}
