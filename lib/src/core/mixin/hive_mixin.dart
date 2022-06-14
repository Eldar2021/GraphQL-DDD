import 'dart:convert';

import 'package:hive/hive.dart';

import '../../src.dart';

mixin HiveMixin {
  Box<String> get box;

  Future<void> put(
    String key,
    List<Model> models,
  ) async {
    await box.put(
      key,
      json.encode(models.map<dynamic>((e) => e.toJson()).toList()),
    );
  }

  String? get(String key) => box.get(key);

  List<T> modelType<T>(
    String modelsString,
    T Function(Map<String, dynamic> body) fromJson,
  ) {
    final listModel = json.decode(modelsString) as List;
    return listModel
        .map<T>(
          (dynamic e) => fromJson(e as Map<String, dynamic>),
        )
        .toList();
  }
}
