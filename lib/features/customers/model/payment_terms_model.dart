class PaymentTermsModel {
  final int id;
  final String? title;

  PaymentTermsModel({required this.id, required this.title});

  factory PaymentTermsModel.fromJson(Map<String, dynamic> json) {
    return PaymentTermsModel(id: json['id'], title: json['title'] is String ? json['title'] : null);
  }
}