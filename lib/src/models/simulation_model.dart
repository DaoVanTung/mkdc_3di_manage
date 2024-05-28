// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class SimulationModel {
  final String id;
  final String name;
  final String model;
  final List<String> tags;
  final String username;
  final String started;
  final String finished;
  final int totalTime;
  final String type;

  SimulationModel({
    required this.id,
    required this.name,
    required this.model,
    required this.tags,
    required this.username,
    required this.started,
    required this.finished,
    required this.totalTime,
    required this.type,
  });

  SimulationModel copyWith({
    String? id,
    String? name,
    String? model,
    List<String>? tags,
    String? username,
    String? started,
    String? finished,
    int? totalTime,
    String? type,
  }) {
    return SimulationModel(
      id: id ?? this.id,
      name: name ?? this.name,
      model: model ?? this.model,
      tags: tags ?? this.tags,
      username: username ?? this.username,
      started: started ?? this.started,
      finished: finished ?? this.finished,
      totalTime: totalTime ?? this.totalTime,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'model': model,
      'tags': tags,
      'username': username,
      'started': started,
      'finished': finished,
      'totalTime': totalTime,
      'type': type,
    };
  }

  factory SimulationModel.fromMap(Map<String, dynamic> map) {
    return SimulationModel(
      id: map['id'] as String,
      name: map['name'] as String,
      model: map['model'] as String,
      tags: List<String>.from((map['tags'] as List<String>)),
      username: map['username'] as String,
      started: map['started'] as String,
      finished: map['finished'] as String,
      totalTime: map['totalTime'] as int,
      type: map['type'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SimulationModel.fromJson(String source) =>
      SimulationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SimulationModel(id: $id, name: $name, model: $model, tags: $tags, username: $username, started: $started, finished: $finished, totalTime: $totalTime, type: $type)';
  }

  @override
  bool operator ==(covariant SimulationModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.model == model &&
        listEquals(other.tags, tags) &&
        other.username == username &&
        other.started == started &&
        other.finished == finished &&
        other.totalTime == totalTime &&
        other.type == type;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        model.hashCode ^
        tags.hashCode ^
        username.hashCode ^
        started.hashCode ^
        finished.hashCode ^
        totalTime.hashCode ^
        type.hashCode;
  }
}
