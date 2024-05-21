import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/screens/news_page/bloc/news_bloc.dart';
import 'package:news/screens/news_page/news_page.dart';

void main() {
  runApp(BlocProvider(
    create: (context) => NewsBloc(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NewsPage(),
    );
  }
}
