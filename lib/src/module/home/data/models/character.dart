import '../../../../src.dart';

class Character extends Model {
  const Character({
    required this.id,
    required this.name,
    required this.status,
    this.gender,
    this.type,
    this.species,
    this.image,
  });

  factory Character.fromJson(Map<String, dynamic> map) {
    return Character(
      id: map['id'] as String,
      name: map['name'] as String,
      status: map['status'] as String,
      gender: map['gender'] as String?,
      type: map['type'] as String?,
      species: map['species'] as String?,
      image: map['image'] as String?,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'status': status,
      'gender': gender,
      'type': type,
      'species': species,
      'image': image,
    };
  }

  final String id;
  final String name;
  final String status;
  final String? gender;
  final String? type;
  final String? species;
  final String? image;

  @override
  List<Object?> get props => [id];
}
