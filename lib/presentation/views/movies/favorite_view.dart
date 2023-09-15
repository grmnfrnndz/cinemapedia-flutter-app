import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// init


class FavoritesView extends ConsumerStatefulWidget {
  const FavoritesView({super.key});

  @override
  ConsumerState<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends ConsumerState<FavoritesView> {


  bool isLastPage = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    loadNextPage();

  }


  @override
  void dispose() {


    super.dispose();
  }


  void loadNextPage() async {

    if(isLoading || isLastPage) return;
    isLoading = true;

    final movies = await ref.read(favoriteMoviesProvider.notifier).loadNextPage();
    isLoading = false;

    if (movies.isEmpty) {
      isLastPage = true;
    } 

  }


  @override
  Widget build(BuildContext context) {
    

    final favoriteMovies = ref.watch(favoriteMoviesProvider).values.toList();

    if (favoriteMovies.isEmpty) {

      final colors = Theme.of(context).colorScheme;

      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.favorite_border_sharp, size: 60, color: colors.primary,),
            Text('Not Movie Found', style: TextStyle(fontSize: 20, color: colors.primary),),
            const Text('Not Favorites Found', style: TextStyle(fontSize: 15, color: Colors.black45),),

            const SizedBox(height: 10,),

            FilledButton(onPressed: () => context.go('/home/0'), child: const Text('Start'))
          ],
        ),
      );

    }

    return Scaffold(body: MovieMasonry(movies: favoriteMovies, loadNextPage: loadNextPage,));
  }
}

