class GovernmentModel {
  final int? id;
  final String? title;

  GovernmentModel({required this.id, required this.title});

  factory GovernmentModel.fromJson(Map<String, dynamic> json) {
    return GovernmentModel(id: json['government_code'], title: json['title'] is String ? json['title'] : null);
  }
}
