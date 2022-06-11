import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../src.dart';

class TodoFetchView extends StatelessWidget {
  const TodoFetchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocBuilder<TodoCubit, Fetchtate>(
        builder: (context, state) {
          if (state is FetchLoading) {
            return const CircularProgressIndicator();
          } else if (state is FetchSuccess<Todo>) {
            return TodosListWidget(todos: state.list);
          } else if (state is FetchError) {
            return Text('${state.exception}');
          } else {
            return const Text('some error');
          }
        },
      ),
    );
  }
}

class TodosListWidget extends StatelessWidget {
  const TodosListWidget({super.key, required this.todos});

  final List<Todo> todos;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        final todo = todos[index];
        return Card(
          child: ListTile(
            leading: Text(todo.id),
            title: Text(todo.title),
            subtitle: Text(todo.user.name),
            trailing: Text('${todo.completed}'),
          ),
        );
      },
    );
  }
}
