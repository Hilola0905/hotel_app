class DataModel{
  final int? id;
  final String modelId;
  final String name;
  DataModel({
    required this.id,
    required this.name,
    required this.modelId,
});
  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
        id: json["id"] as int? ?? 0,
        name: json["name"] as String? ?? "",
        modelId: json["model_id"] as String? ?? "",
    );
  }
  DataModel copyWith({
    required int id,
  }) {
    return DataModel(
        id: id, name: name, modelId: modelId);
  }
  Map<String, dynamic> toJson() {
    return {
     "id": id,
      "model_id": modelId,
      "name": name,
    };
  }

}