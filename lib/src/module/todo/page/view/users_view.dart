import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../src.dart';

class UsersFetchView extends StatelessWidget {
  const UsersFetchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocBuilder<UsersCubit, Fetchtate>(
        builder: (context, state) {
          if (state is FetchLoading) {
            return const CircularProgressIndicator();
          } else if (state is FetchSuccess<User>) {
            return UsersListWidget(users: state.list);
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

class UsersListWidget extends StatelessWidget {
  const UsersListWidget({super.key, required this.users});

  final List<User> users;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        return Card(
          child: ListTile(
            leading: Text(user.id),
            title: Text(user.name),
          ),
        );
      },
    );
  }
}
