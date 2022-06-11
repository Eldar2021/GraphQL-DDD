import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../src.dart';
import 'todo_view.dart';
import 'users_view.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<TodoCubit>()..fetchData(),
        ),
        BlocProvider(
          create: (context) => sl<UsersCubit>()..fetchData(),
        ),
      ],
      child: const TodoView(),
    );
  }
}

class TodoView extends StatelessWidget {
  const TodoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TodoView'),
      ),
      body: PageView(
        children: const [
          TodoFetchView(),
          UsersFetchView(),
        ],
      ),
    );
  }
}
