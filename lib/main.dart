import 'package:cats_app/src/viewModels/cat_view_model.dart';
import 'package:cats_app/src/views/home_cat_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Breeds Cat App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: BlocProvider<CatViewModel>(
          create: (context) =>
              CatViewModel(), // No se necesitan argumentos aquí
          child: const MaterialApp(
            home: HomeCatPage(),
          ),
        ));
  }
}
