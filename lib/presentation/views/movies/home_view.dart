import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/presentation/providers/providers.dart';




class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});


  @override
  ConsumerState<HomeView> createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {

  @override
  void initState() {
    super.initState();

    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
  }


  @override
  void dispose() {


    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    

    final initialLoading = ref.watch(initialLoadingProvider);
    if (initialLoading) return const FullScreenLoader();


    final slideShowMovies = ref.watch(moviesSlideshowProvider);
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);
    final upcomingMovies = ref.watch(upcomingMoviesProvider);

    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            titlePadding: EdgeInsets.only(bottom: 0),
            title: CustomAppBar(),
          ),
        ),
    
        SliverList(delegate: SliverChildBuilderDelegate(
          (context, index) {
            return Column(
              children: [
                // const CustomAppBar(),
          
                MoviesSlideShow(movies: slideShowMovies),
          
                //* cinema
                MoviesHorizontalListview(movies: nowPlayingMovies, 
                title: 'On Cinemea', 
                subTitle: 'Fraday 11',
                loadNextPage: () => ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(),
                ),
                //* popular
                MoviesHorizontalListview(movies: popularMovies, 
                title: 'Populares', 
                subTitle: 'Fraday 11',
                loadNextPage: () => ref.read(popularMoviesProvider.notifier).loadNextPage(),
                ),
                // * Top Rated
                MoviesHorizontalListview(movies: topRatedMovies, 
                title: 'Top Rated', 
                subTitle: 'Fraday 11',
                loadNextPage: () => ref.read(topRatedMoviesProvider.notifier).loadNextPage(),
                ),
                // * Upcoming
                MoviesHorizontalListview(movies: upcomingMovies, 
                title: 'Top Rated', 
                subTitle: 'Fraday 11',
                loadNextPage: () => ref.read(upcomingMoviesProvider.notifier).loadNextPage(),
                ),
    
                const SizedBox(height: 50,),
    
    
    
                // Expanded(
                //   child: ListView.builder(
                //       itemCount: nowPlayingMovies.length,
                //       itemBuilder: (BuildContext context, int index) {
                //   final movie = nowPlayingMovies[index];
                //   return ListTile(
                //     title: Text(movie.title),
                //   );
                //       },
                //     ),
                // )
              ],
            );
          },
          childCount: 1
        ))
    
    
      ]
      
      
    );
  }
}