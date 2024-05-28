class SimulationModel {
  String id;
  String name;
  String model;
  List<String> tags;
  String username;
  String started;
  String finished;
  int totalTime;
  String type;
  String status;

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
    required this.status,
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
    String? status,
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
      status: status ?? this.status,
    );
  }
}
