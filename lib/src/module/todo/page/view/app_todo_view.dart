import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../src.dart';

class AddTodoPage extends StatelessWidget {
  const AddTodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AddTodoCubit>(),
      child: AddTodoView(),
    );
  }
}

class AddTodoView extends StatelessWidget {
  AddTodoView({super.key});

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AddTodoView'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: controller,
            ),
            BlocBuilder<AddTodoCubit, AddTodoState>(
              builder: (context, state) {
                if (state is AddTodoLoading) {
                  return const CircularProgressIndicator();
                } else if (state is AddTodoSuccess) {
                  return ListTile(
                    title: Text(state.model.title),
                    subtitle: Text('${state.model.completed}'),
                  );
                // } else if (state is AddTodoError) {
                //   return Text('${state.exception}');
                } else {
                  return ElevatedButton(
                    onPressed: () {
                      context.read<AddTodoCubit>().addTodo(
                            controller.text,
                            true,
                          );
                    },
                    child: const Text('Add Todo'),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
