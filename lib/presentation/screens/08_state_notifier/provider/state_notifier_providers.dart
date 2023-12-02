import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../../config/helpers/random_generator.dart';
import '../../../../domain/entities/todo.dart';
import '../../04_todo/provider/todo_providers.dart';


const uuid = Uuid();

//enum TodoFilter { all, completed, pending }

final todosStateNotifierProvider =
    StateNotifierProvider<TodoNotifier, List<Todo>>((ref) {
  return TodoNotifier();
});

class TodoNotifier extends StateNotifier<List<Todo>> {
  TodoNotifier()
      : super([
          Todo(
            id: uuid.v4(),
            description: RandomGenerator.getRandomName(),
            completedAt: null,
          ),
          Todo(
            id: uuid.v4(),
            description: RandomGenerator.getRandomName(),
            completedAt: null,
          ),
          Todo(
            id: uuid.v4(),
            description: RandomGenerator.getRandomName(),
            completedAt: null,
          ),
        ]);

  void createTodo() {
    state = [
      ...state,
      Todo(
        id: uuid.v4(),
        description: RandomGenerator.getRandomName(),
        completedAt: null,
      )
    ];
  }

  void toggleDone(String id) {
    state = state.map((todo) {
      if (todo.id != id) return todo;
      if (todo.done) return todo.copyWith(completedAt: null);
      return todo.copyWith(completedAt: DateTime.now());
    }).toList();

/*     state = [
      for (final t in state)
        if (t.id == todo.id)
          Todo(
            id: t.id,
            description: t.description,
            completedAt: t.done ? null : DateTime.now(),
          )
        else
          t
    ];
 */
  }

  void delete(Todo todo) {
    state = state.where((t) => t.id != todo.id).toList();
  }
}

final filteredGuestProvider = Provider<List<Todo>>((ref) {
  final selectedFilter = ref.watch(todoFilterProvider);
  final todos = ref.watch(todosStateNotifierProvider);

// não precisa usar break, pois o return já sai da função
// não precisa usar default, pois todos os casos são tratados

  switch (selectedFilter) {
    case TodoFilter.all:
      return todos;
    case TodoFilter.completed:
      return todos.where((todo) => todo.done).toList();
    case TodoFilter.pending:
      return todos.where((todo) => !todo.done).toList();
  }
});

