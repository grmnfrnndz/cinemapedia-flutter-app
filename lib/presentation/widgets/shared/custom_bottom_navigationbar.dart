import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});


  int getCurrentIndex(BuildContext context) {
    final String location = GoRouterState.of(context).fullPath ?? '/';

    switch(location) {
      case '/':
        return 0;
      case '/categories':
        return 1;
      case '/favorites':
        return 2;
      default:
        return 0;
    }
  }


  void onOtemTapped(BuildContext context, int index) {

    switch(index) {

      case 0: 
        context.go('/');
        break;
      case 1: 
        context.go('/');
        break;
      case 2: 
        context.go('/favorites');
        break;
      default:
        context.go('/');
    }
  }


  @override
  Widget build(BuildContext context) {
    final currentIndex = getCurrentIndex(context);

    return BottomNavigationBar(
      elevation: 0,
      currentIndex: currentIndex,
      onTap: (index) => onOtemTapped(context, index),
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