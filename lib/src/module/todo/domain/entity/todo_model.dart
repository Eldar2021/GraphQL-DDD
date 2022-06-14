import '../../../../src.dart';

class Todo extends Model {
  const Todo({
    required this.id,
    required this.title,
    required this.completed,
    required this.user,
  });

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'] as String,
      title: json['title'] as String,
      completed: json['completed'] as bool,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'completed': completed,
      'user': user.toJson(),
    };
  }

  final String id;
  final String title;
  final bool completed;
  final User user;

  @override
  List<Object?> get props => [id];
}
