import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../04_todo/provider/todo_providers.dart';
import 'provider/change_notifier_providers.dart';

class ChangeNotifierScreen extends ConsumerWidget {
  const ChangeNotifierScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Notifier Provider'),
      ),
      body: const _TodoView(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          ref.read(todoChangeNotifierProvider.notifier).addTodo();
        },
      ),
    );
  }
}

class _TodoView extends ConsumerWidget {
  const _TodoView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentFilter = ref.watch(todoFilterProvider);
    // final todos = ref.watch(todosProvider);
    // final todos = ref.watch(filteredTodosProvider);

    final todosChangeNotifier = ref.watch(filteredGuestChangeNotifier);

    return Column(
      children: [
        const ListTile(
          title: Text('Listado de invitados'),
          subtitle: Text('Estas son las personas a invitar a la fiesta'),
        ),

        SegmentedButton(
          segments: const [
            ButtonSegment(value: TodoFilter.all, icon: Text('Todos')),
            ButtonSegment(value: TodoFilter.completed, icon: Text('Invitados')),
            ButtonSegment(
                value: TodoFilter.pending, icon: Text('No invitados')),
          ],
          selected: <TodoFilter>{currentFilter},
          onSelectionChanged: (value) {
            ref.read(todoFilterProvider.notifier).state = value.first;
          },
        ),
        const SizedBox(height: 5),

        /// Listado de personas a invitar
        Expanded(
          child: ListView.builder(
            itemCount: todosChangeNotifier.length,
            itemBuilder: (context, index) {
              final todo = todosChangeNotifier[index];
              return SwitchListTile(
                  title: Text(todo.description),
                  value: todo.done,
                  onChanged: (value) {
                    ref
                        .read(todoChangeNotifierProvider.notifier)
                        .toggleDone(todo.id);
                  });
            },
          ),
        )
      ],
    );
  }
}
