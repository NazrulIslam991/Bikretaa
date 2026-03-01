class HolidayModel {
  final String date;
  final String name;

  HolidayModel({required this.date, required this.name});

  factory HolidayModel.fromJson(Map<String, dynamic> json) {
    return HolidayModel(date: json['date']['iso'], name: json['name']);
  }
}
