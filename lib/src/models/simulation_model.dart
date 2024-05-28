class SimulationModel {
  String id;
  String name;
  String modelId;
  String modelName;
  List<String> tags;
  String username;
  String started;
  String finished;
  int totalTime;
  int duration;
  String type;
  String status;

  SimulationModel({
    required this.id,
    required this.name,
    required this.modelId,
    required this.modelName,
    required this.tags,
    required this.username,
    required this.started,
    required this.finished,
    required this.totalTime,
    required this.duration,
    required this.type,
    required this.status,
  });

  SimulationModel copyWith({
    String? id,
    String? name,
    String? modelId,
    String? modelName,
    List<String>? tags,
    String? username,
    String? started,
    String? finished,
    int? totalTime,
    int? duration,
    String? type,
    String? status,
  }) {
    return SimulationModel(
      id: id ?? this.id,
      name: name ?? this.name,
      modelId: modelId ?? this.modelId,
      modelName: modelName ?? this.modelName,
      tags: tags ?? this.tags,
      username: username ?? this.username,
      started: started ?? this.started,
      finished: finished ?? this.finished,
      totalTime: totalTime ?? this.totalTime,
      duration: duration ?? this.duration,
      type: type ?? this.type,
      status: status ?? this.status,
    );
  }
}
