import 'package:cats_app/src/models/cat.dart';
import 'package:cats_app/src/viewModels/cat_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCatPage extends StatefulWidget {
  const HomeCatPage({super.key});

  @override
  State<HomeCatPage> createState() => _HomeCatPageState();
}

class _HomeCatPageState extends State<HomeCatPage> {
  @override
  void initState() {
    context.read<CatViewModel>().add(LoadItemsEvent());
    super.initState();
  }

  Widget _itemCard(BuildContext context, Cat item) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.name ?? '',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 8.0),
            Center(
              child: SizedBox(
                width: 150.0,
                height: 150.0,
                child: Image.network(
                  "https://cdn2.thecatapi.com/images/${item.referenceImageId}.jpg",
                  errorBuilder: (context, error, stackTrace) =>
                      const Text("No imagen "),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              'País: ${item.origin}',
              style: const TextStyle(fontSize: 14.0),
            ),
            Text(
              'Inteligencia: ${item.temperament}',
              style: const TextStyle(fontSize: 14.0),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Catbreeds')),
      ),
      body: BlocBuilder<CatViewModel, LoadItemsState>(
        builder: (context, state) {
          if (state.items.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              itemCount: state.items.length,
              itemBuilder: (context, index) {
                final item = state.items[index];
                return _itemCard(context, item);
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<CatViewModel>().add(LoadItemsEvent());
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
