import 'package:flutter/material.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'config/router/app_router.dart';
import 'package:cinemapedia/config/theme/app_theme.dart';


Future<void> main() async {

  // init dotenv - environment variables
  await dotenv.load(fileName: '.env');

  runApp(
    // ref all providers impl of riverpod (ProviderScope)
    const ProviderScope(child: MyApp())
  );

}

class MyApp extends StatelessWidget {
  
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: AppTheme(selectedColor: 0, isDarkMode: false).getTheme(),
      title: 'Material App',
    );
  }

}
