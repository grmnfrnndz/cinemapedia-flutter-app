import 'package:flutter/material.dart';


class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    const currentIndex = 0;

    return BottomNavigationBar(
      elevation: 0,
      currentIndex: currentIndex,
      onTap: (value) {
        
      },
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