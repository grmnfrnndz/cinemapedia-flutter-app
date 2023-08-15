import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';




final actorsInfoProvider = StateNotifierProvider<CastMapNotifier, Map<String, List<Actor>>>((ref) {
  
  final fetchActors = ref.watch(actorRepositoryProvider).getActorByMovie;

  return CastMapNotifier(
    getCast: fetchActors
  );
});


  /*
   {
      '12345': Cast()[]
   }
   */

typedef GetCastCallback = Future<List<Actor>>Function(String movieId);


class CastMapNotifier extends StateNotifier<Map<String, List<Actor>>> {
  

  final GetCastCallback getCast;

  // initialize with empty map
  CastMapNotifier({required this.getCast}): super({});


  Future<void> loadCast(String movieId) async {

    if(state[movieId] != null) return;

    final casts = await getCast(movieId);

    state = {...state, movieId: casts};
  }


}

