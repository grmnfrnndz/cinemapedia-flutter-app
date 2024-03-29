import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieScreen extends ConsumerStatefulWidget {

  static const name = 'movie_screen';

  final String movieId;

  const MovieScreen({super.key, required this.movieId});

  @override
  ConsumerState<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends ConsumerState<MovieScreen> {

  @override
  void initState() {
    super.initState();

    ref.read(movieInfoProvider.notifier).loadMovie(widget.movieId);
    ref.read(actorsInfoProvider.notifier).loadCast(widget.movieId);

  }

  @override
  void dispose() {
    

    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    final Movie? movie = ref.watch(movieInfoProvider)[widget.movieId];

    if (movie == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator(strokeWidth: 2,)));
    }


    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          _CumstomSliverAppBar(movie: movie),

          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: 1,
              (context, index) => _MovieDetails(movie: movie)
            )
          ),

        ],
      ),
    );
  }
}


class _CumstomSliverAppBar extends StatelessWidget {

  final Movie movie;

  const _CumstomSliverAppBar({ required this.movie});

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.6,
      foregroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        // title: Text(movie.title,
        //   style: const TextStyle(fontSize: 15),
        //   textAlign: TextAlign.start,
          
        // ),
        titlePadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        background: Stack(
          children: [
            SizedBox.expand(
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if(loadingProgress != null) return const SizedBox();

                  return FadeIn(child: child);
                },
              )
            ),

            const SizedBox.expand(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.6, 1],
                    colors: [Colors.transparent, Colors.black87]
                  )
                ),
              ),
            ),

            const SizedBox.expand(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    stops: [0.0, 0.3],
                    colors: [Colors.black87, Colors.transparent]
                  )
                ),
              ),
            ),

          ],
        ),        
        // centerTitle: true,
      ),
    );
  }
}



class _MovieDetails extends StatelessWidget {

  final Movie movie;

  const _MovieDetails({required this.movie});

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final textStyle = Theme.of(context).textTheme;



    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Padding(
          padding: EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  movie.posterPath,
                  width: size.width * 0.3,
                ),
              ),

              const SizedBox(width: 10,),

              SizedBox(
                width: (size.width - 40) * 0.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(movie.title, style: textStyle.titleLarge, textAlign: TextAlign.start,),
                    Text(movie.overview)
                  ]
                ),
              ),
            ],
          ),
          ),

          // genres

          Padding(
                padding: const EdgeInsets.all(8),
                child: Wrap(
                  children: [
                    ...movie.genreIds.map((e) => Container(
                      margin: EdgeInsets.only(right: 10),
                      child: Chip(
                        label: Text(e),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      ),
                    ))
                  ],
                )
              ),

          _ActorsByMovie(movieId: movie.id.toString()),

          const SizedBox(height: 50),

      ],
    );
  }
}


class _ActorsByMovie extends ConsumerWidget {

  final String movieId;

  const _ActorsByMovie({required this.movieId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final actorByMovie = ref.watch(actorsInfoProvider)[movieId];

    if (actorByMovie == null ) {
      return const Scaffold(body: Center(child: CircularProgressIndicator(strokeWidth: 2,)));
    }


    return SizedBox(
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: actorByMovie.length,
        itemBuilder: (context, index) {
          final actor = actorByMovie[index];

          return Container(
            padding: const EdgeInsets.all(8),
            width: 135,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeInRight(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      actor.profilePath,
                      height: 180,
                      width: 135,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                
                const SizedBox(height: 5,),

                Text(actor.name, maxLines: 2,),
                Text(actor.character ?? '', maxLines: 2, style: TextStyle(fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis),)
              ],
            ),
          );
        },
        ),
    );
  }
}