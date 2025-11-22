import 'dart:convert';

import 'package:bikretaa/app/string.dart';
import 'package:bikretaa/app/urls.dart';
import 'package:bikretaa/features/calender/model/event_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  // Fetch Holidays from Calendarific
  static Future<List<HolidayModel>> getHolidays(int year) async {
    final url =
        "${Urls.calendarificBaseUrl}?api_key=${AppConstants.calendarificApiKey}&country=${AppConstants.countryCode}&year=$year";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List holidays = data['response']['holidays'];
      return holidays.map((e) => HolidayModel.fromJson(e)).toList();
    } else {
      return [];
    }
  }
}
