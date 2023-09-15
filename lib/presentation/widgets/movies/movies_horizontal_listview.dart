import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/helpers.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class MoviesHorizontalListview extends StatefulWidget {

  final List<Movie> movies;
  final String? title;
  final String? subTitle;
  final VoidCallback? loadNextPage; 

  const MoviesHorizontalListview({super.key, required this.movies, this.title, this.subTitle, this.loadNextPage});

  @override
  State<MoviesHorizontalListview> createState() => _MoviesHorizontalListviewState();
}

class _MoviesHorizontalListviewState extends State<MoviesHorizontalListview> {

  final scrollController = ScrollController();


  @override
  void initState() {
    super.initState();

    scrollController.addListener(() { 
      if ( widget.loadNextPage == null)  return;
      
      if (scrollController.position.pixels + 200 >= scrollController.position.maxScrollExtent) {
        widget.loadNextPage!();
      }
    });

  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 380,
      child: Column(
        children: [

          if(widget.title != null || widget.subTitle != null)
            _Title(title: widget.title, subTitle: widget.subTitle,),

          Expanded(
            child: ListView.builder(
              controller: scrollController,
              physics: const ClampingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: widget.movies.length,
              itemBuilder: (BuildContext context, int index) {

                return FadeInRight(child: _Slide(movie: widget.movies[index]));
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {

  final Movie movie;

  const _Slide({required this.movie});

  @override
  Widget build(BuildContext context) {

    final textTheme = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          //* image
          SizedBox(
            width: 150,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                movie.posterPath,
                width: 150,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress){

                  if (loadingProgress != null) {
                    return const SizedBox(height: 240, child: Center(child: CircularProgressIndicator(strokeWidth: 2,)));
                  }
                  return GestureDetector(
                    onTap: (){
                      context.push('/home/0/movie/${movie.id}');
                    },
                    child: FadeIn(child: child),
                  );
                } ,
              ),
            ),
          ),

          //*title
          SizedBox(
            width: 150,
            // height: 20,
            child: Text(
              movie.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: textTheme.titleSmall,
            ),
          ),
          
          SizedBox(
            width: 130,
            child: Row(
              children: [
                const SizedBox(width: 3,),
                Icon(Icons.star_half_outlined, color: Colors.yellow.shade600),
                const SizedBox(width: 3,),
                Text(movie.voteAverage.toString(), style: textTheme.bodyMedium?.copyWith(color: Colors.yellow.shade800),),
                // const SizedBox(width: 10,),
                const Spacer(),
                Text(HumanFormats.humanReadbleNumber(movie.popularity), style: textTheme.bodySmall,),
              ],
            ),
          )
          
        ],
      )
    );
  }
}



class _Title extends StatelessWidget {

  final String? title;
  final String? subTitle;

  const _Title({this.title, this.subTitle});


  @override
  Widget build(BuildContext context) {

    final titleStyleLarge = Theme.of(context).textTheme.titleLarge;


    return Container(
      padding: const EdgeInsets.only(top: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
        if (title != null)
          Text(title!, style: titleStyleLarge),
        const Spacer(),
        if (subTitle != null)
          FilledButton.tonal(
            style: const ButtonStyle(visualDensity: VisualDensity.compact),
            child: Text(subTitle!), 
            onPressed: (){}
          ),

        ],
        
      ),
    );
  }
}