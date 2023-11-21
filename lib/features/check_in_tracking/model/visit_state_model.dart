class VisitStateModel {
  int id;
  String name;

  VisitStateModel({
    required this.id,
    required this.name
  });

  factory VisitStateModel.fromJson(Map<String, dynamic> json) {
    return VisitStateModel(
      id: json['id'],
      name: json['name']
    );
  }
}
