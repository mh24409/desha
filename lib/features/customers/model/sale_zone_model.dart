class SaleZoneModel {
 final int? id;
  final String? title;

  SaleZoneModel({required this.id, required this.title});

  factory SaleZoneModel.fromJson(Map<String, dynamic> json) {
    return SaleZoneModel(id: json['id'], title: json['title'] is String ? json['title'] : null);
  }
}