import 'package:cats_app/src/models/cat.dart';
import 'package:cats_app/src/viewModels/cat_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCatPage extends StatefulWidget {
  const HomeCatPage({super.key});

  @override
  State<HomeCatPage> createState() => _HomeCatPageState();
}

class _HomeCatPageState extends State<HomeCatPage> {
  final TextEditingController _textController = TextEditingController();

  List<Cat> originalList = [];

  List<Cat> filteredList = [];

  @override
  void initState() {
    context.read<CatViewModel>().add(LoadItemsEvent());
    super.initState();
    _textController.addListener(_filterList);
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _filterList() {
    filteredList = [];
    setState(() {
      if (_textController.text.isEmpty) {
        filteredList.clear();
        filteredList.addAll(originalList);
      } else {
        filteredList = originalList
            .where((element) => element.name!
                .toLowerCase()
                .contains(_textController.text.toLowerCase()))
            .toList();
      }
    });
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
                      const Text("No imagen"),
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
            originalList = state.items.toList();

            final list = filteredList.length == 0 ? originalList : filteredList;
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _textController,
                    decoration: const InputDecoration(
                      labelText: 'Search',
                      hintText: 'Type to filter',
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      final item = list[index];
                      return _itemCard(context, item);
                    },
                  ),
                ),
              ],
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
