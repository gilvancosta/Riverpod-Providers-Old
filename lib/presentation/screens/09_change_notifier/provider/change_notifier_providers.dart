import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../../config/helpers/random_generator.dart';
import '../../../../domain/entities/todo.dart';
import '../../04_todo/provider/todo_providers.dart';

const uuid = Uuid();

final todoChangeNotifierProvider =
    ChangeNotifierProvider<TodoChangeNotifier>((ref) {
  return TodoChangeNotifier();
});

class TodoChangeNotifier extends ChangeNotifier {
  List<Todo> todos = <Todo>[
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
  ];

  void addTodo() {
    todos = [
      ...todos,
      Todo(
        id: uuid.v4(),
        description: RandomGenerator.getRandomName(),
        completedAt: null,
      )
    ];
    notifyListeners();
  }

  void toggleDone(String id) {
    todos = todos.map((todo) {
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

    notifyListeners();
  }

  void delete(String todoId) {
    todos = todos.where((t) => t.id != todoId).toList();
    notifyListeners();
  }
}

final filteredGuestChangeNotifier = Provider<List<Todo>>((ref) {
  final selectedFilter = ref.watch(todoFilterProvider);
  final todoChangeNotifier01 = ref.watch(todoChangeNotifierProvider);

// não precisa usar break, pois o return já sai da função
// não precisa usar default, pois todos os casos são tratados

  switch (selectedFilter) {
    case TodoFilter.all:
      return todoChangeNotifier01.todos;
    case TodoFilter.completed:
      return todoChangeNotifier01.todos.where((todo) => todo.done).toList();
    case TodoFilter.pending:
      return todoChangeNotifier01.todos.where((todo) => !todo.done).toList();
  }
});
