import 'package:cats_app/src/data/Breeds.dart';
import 'package:cats_app/src/models/cat.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoadItemsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadItemsState extends Equatable {
  final List<Cat> items;

  const LoadItemsState({this.items = const []}); // Proporciona un valor por defecto para items

  @override
  List<Object?> get props => [items];
}

class CatViewModel extends Bloc<LoadItemsEvent, LoadItemsState> {
  CatViewModel() : super(const LoadItemsState()) { // Inicializa con un estado por defecto
    on<LoadItemsEvent>(_onLoadItems); // Maneja el evento LoadItemsEvent
  }

  Future<void> _onLoadItems(LoadItemsEvent event, Emitter<LoadItemsState> emit) async {
    try {
      final items = await Breeds().get();
      List<Cat> cats = [];
      if (items != null) {
        for (var element in items) {
          cats.add(Cat.fromJson(element));
        }
      }
      emit(LoadItemsState(items: cats)); // Emite un nuevo estado con los datos cargados
    } catch (_) {
      emit(state); // En caso de error, emite el estado actual sin cambios
    }
  }
}