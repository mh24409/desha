class ResponsibilityModel {
  final String? name;
  final String? mobile;
  final String? email;
  final String? workAt;
  final String? workTo;
  final String? workDayFrom;
  final String? workDayTo;

  ResponsibilityModel({
    required this.name,
    required this.mobile,
    required this.email,
    required this.workAt,
    required this.workTo,
    required this.workDayFrom,
    required this.workDayTo,
  });

  factory ResponsibilityModel.fromJson(Map<String, dynamic> json) {
    return ResponsibilityModel(
      name: json['name'] is String ? json['name'] : null,
      mobile: json['mobile'] is String ? json['mobile'] : null,
      email: json['email'] is String ? json['email'] : null,
      workAt: json['work_at'] is String ? json['work_at'] : null,
      workTo: json['work_to'] is String ? json['work_to'] : null,
      workDayFrom: json['work_day_from'] is String ? json['work_day_from'] : null,
      workDayTo: json['work_day_to'] is String ? json['work_day_to'] : null,
    );
  }
}