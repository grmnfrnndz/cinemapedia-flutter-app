import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;

  const CustomBottomNavigationBar({super.key, required this.currentIndex});

  void onViewTapped(BuildContext context, int index) {
    context.go('/home/$index');
    switch(index) {
      case 0:
        context.go('/home/$index');
      case 1:
        context.go('/home/$index');
      case 2:
        context.go('/home/$index');
      default:
        context.go('/home/0');
    }
  }

  @override
  Widget build(BuildContext context) {

    return BottomNavigationBar(
      elevation: 0,
      currentIndex: currentIndex,
      onTap: (index) => onViewTapped(context, index),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_max_outlined),
          label: 'Cinema',
          ),
        BottomNavigationBarItem(
          icon: Icon(Icons.label_outline),
          label: 'Categories',
          ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_outline),
          label: 'Favorites',
          ),
      ],
    );
  }
}