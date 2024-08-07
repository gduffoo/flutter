import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/credits_response.dart';

class ActorMapper {
  static Actor castToEntity(Cast cast) => Actor(
        id: cast.id,
        name: cast.name,
        profilePath: (cast.profilePath != '')
            ? 'https://image.tmdb.org/t/p/w500${cast.profilePath}'
            : 'https://sd.keepcalms.com/i-w600/keep-calm-poster-not-found.jpg',
        character: cast.character,
      );
}
