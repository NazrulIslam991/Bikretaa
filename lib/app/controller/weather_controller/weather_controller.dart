import 'dart:convert';

import 'package:bikretaa/app/string.dart';
import 'package:bikretaa/app/urls.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class WeatherController extends GetxController {
  var temperature = ''.obs;
  var weatherIcon = Icons.wb_sunny.obs;
  var cityName = ''.obs;
  var locationEnabled = false.obs;
  var permissionDenied = false.obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkLocationAndRequestPermission();
  }

  // Check location and permission
  Future<void> checkLocationAndRequestPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    LocationPermission permission = await Geolocator.checkPermission();

    if (!serviceEnabled) {
      _setLocationOff();
      return;
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        permissionDenied.value = true;
        _setLocationOff();
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      permissionDenied.value = true;
      _setLocationOff();
      return;
    }

    permissionDenied.value = false;
    await loadWeather();
  }

  void _setLocationOff() {
    temperature.value = '--°C';
    weatherIcon.value = Icons.location_off;
    cityName.value = '';
    locationEnabled.value = false;
    isLoading.value = false;
  }

  /// Load weather data
  Future<void> loadWeather() async {
    try {
      isLoading.value = true;

      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _setLocationOff();
        return;
      }

      Position pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      final data = await _getWeatherDataByLatLon(pos.latitude, pos.longitude);

      double temp = data['main']['temp'];
      int sunrise = data['sys']['sunrise'];
      int sunset = data['sys']['sunset'];
      int now = data['dt'];
      String mainWeather = data['weather'][0]['main'].toString().toLowerCase();

      bool isDay = now >= sunrise && now <= sunset;
      IconData icon;

      if (mainWeather.contains('cloud')) {
        icon = isDay ? Icons.wb_cloudy : Icons.nights_stay;
      } else if (mainWeather.contains('rain') ||
          mainWeather.contains('drizzle')) {
        icon = Icons.grain;
      } else if (mainWeather.contains('thunderstorm')) {
        icon = Icons.flash_on;
      } else if (mainWeather.contains('snow')) {
        icon = Icons.ac_unit;
      } else {
        icon = isDay ? Icons.wb_sunny : Icons.nights_stay;
      }

      temperature.value = '${temp.round()}°C';
      weatherIcon.value = icon;
      cityName.value = data['name'];
      locationEnabled.value = true;
    } catch (e) {
      _setLocationOff();
    } finally {
      isLoading.value = false;
    }
  }

  // Fetch weather from API
  Future<Map<String, dynamic>> _getWeatherDataByLatLon(
    double lat,
    double lon,
  ) async {
    final url = Uri.parse(
      '${Urls.baseWeatherUrl}?lat=$lat&lon=$lon&units=metric&appid=${AppConstants.weatherApiKey}',
    );

    final response = await http.get(url);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw Exception('Failed to fetch weather');
  }
}
