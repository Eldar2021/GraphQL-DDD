class AddToDoModel {
  AddToDoModel(
    this.title,
    // ignore: avoid_positional_boolean_parameters
    this.completed,
  );

  factory AddToDoModel.fromJson(Map<String, dynamic> json) {
    return AddToDoModel(
      json['title'] as String,
      json['completed'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'title': title,
      'completed': completed,
    };
  }

  final String title;
  final bool completed;
}
