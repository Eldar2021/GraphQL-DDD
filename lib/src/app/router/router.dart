import 'package:flutter/material.dart';

import '../../src.dart';

class AppRouter {
  static const String home = '/';

  static const String todo = '/todo';

  static const String addTodo = '/add_todo';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute<void>(
          builder: (_) => const HomePage(),
        );

      case todo:
        return MaterialPageRoute<void>(
          builder: (_) => const TodoPage(),
        );

      case addTodo:
        return MaterialPageRoute<void>(
          builder: (_) => const AddTodoPage(),
        );

      default:
        return MaterialPageRoute<void>(
          builder: (_) => const HomePage(),
        );
    }
  }
}
