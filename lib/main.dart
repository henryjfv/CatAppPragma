import 'package:cats_app/src/viewModels/cat_view_model.dart';
import 'package:cats_app/src/views/home_cat_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
