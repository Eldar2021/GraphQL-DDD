import '../../../../src.dart';

class User extends Model {
  const User({
    required this.id,
    required this.name,
  });

  factory User.fromJson(Map<String, dynamic> map) {
    return User(
      id: map['id'] as String,
      name: map['name'] as String,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  final String id;
  final String name;

  @override
  List<Object?> get props => [id];
}
