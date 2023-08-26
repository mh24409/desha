class CustomerTypeModel {
  final int id;
  final String? title;

  CustomerTypeModel({required this.id, required this.title});

  factory CustomerTypeModel.fromJson(Map<String, dynamic> json) {
    return CustomerTypeModel(id: json['id'], 
    
    title: json['title'] is String ? json['title'] : null);
  }
}
