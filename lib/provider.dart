import 'package:flutter_riverpod/flutter_riverpod.dart';


class EntityDataNotifier extends StateNotifier<List> {
  EntityDataNotifier() : super([]);

  set(List file) {
    state = file;
  }

  add(var entity) {
    List old = List.from(state);
    old.add(entity);
    state = old;
  }
  
  remove() {
    List old = List.from(state);
    old.removeLast();
    state = old;
  }

}

final entityDataProvider =
    StateNotifierProvider<EntityDataNotifier, List>(
        (ref) => EntityDataNotifier());
