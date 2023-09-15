import 'package:flutter/material.dart';

import 'package:cinemapedia/presentation/views/views.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';


class HomeScreen extends StatelessWidget {

  static const name = 'home_screen';
  final int pageIndex;

  HomeScreen({super.key, required this.pageIndex});

  final viewRoutes = <Widget>[
    const HomeView(),
    const SizedBox(),
    const FavoritesView()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: pageIndex,
        children: viewRoutes,
      ),
      bottomNavigationBar: CustomBottomNavigationBar(currentIndex: pageIndex),
      );
  }
}
