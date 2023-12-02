import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/config/config.dart';
import 'package:uuid/uuid.dart';
import '../../../../domain/entities/todo.dart';

const uuid = Uuid();

enum TodoFilter { all, completed, pending }

final todoFilterProvider = StateProvider<TodoFilter>((ref) {
  return TodoFilter.all;
});

final todosProvider = StateProvider<List<Todo>>((ref) {
  List<Todo> todosList = [];

  for (int i = 0; i < 10; i++) {
    final todo = Todo(
      id: uuid.v4(),
      description: RandomGenerator.getRandomName(),
      completedAt: i % 2 == 0 ? DateTime.now() : null,
    );
    todosList.add(todo);
  }
  return todosList;
});

final filteredTodosProvider = Provider<List<Todo>>((ref) {
  final selectedFilter = ref.watch(todoFilterProvider);
  final todos = ref.watch(todosProvider);

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
