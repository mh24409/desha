class AttendanceHistoryModel {
  String date;
  String checkInTime;
  String checkOutTime;
  bool checkedInOnTime;
  bool checkedOutOnTime;

  AttendanceHistoryModel({
    required this.date,
    required this.checkInTime,
    required this.checkOutTime,
    required this.checkedInOnTime,
    required this.checkedOutOnTime,
  });

  factory AttendanceHistoryModel.fromJson(Map<String, dynamic> json) {
    return AttendanceHistoryModel(
      date: json['date'],
      checkInTime: json['check_in_time'],
      checkOutTime: json['check_out_time'],
      checkedInOnTime: json['checked_in_on_time'],
      checkedOutOnTime: json['checked_out_on_time'],
    );
  }
}
