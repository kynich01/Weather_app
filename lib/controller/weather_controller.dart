import 'package:flutter/material.dart';

class WeatherController {

  //*untuk animasi kondisi cuaca di bagian atas
  String getWeatherAnimation(String condition) {

    switch (condition.toLowerCase()) {

      case 'clear':
        return 'assets/sunny.json';

      case 'clouds':
        return 'assets/cloudy.json';

      case 'rain':
      case 'drizzle':
        return 'assets/rain.json';

      case 'thunderstorm':
        return 'assets/storm.json';

      default:
        return 'assets/cloudy.json';
    }
  }

  //*untuk mengubah unix time jadi format waktu biasa
  String formatTime(
    int unixTime,
    int timezoneOffset,
  ) {

    final dt =
        DateTime.fromMillisecondsSinceEpoch(
      (unixTime + timezoneOffset) * 1000,
      isUtc: true,
    );

    return
        "${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}";
  }

  //*untuk mengubah angka derajat menjadi nama arah mata angin
  String getWindDirection(int deg) {

    const dirs = [

      'Utara',
      'Timur Laut',
      'Timur',
      'Tenggara',
      'Selatan',
      'Barat Daya',
      'Barat',
      'Barat Laut',
    ];

    return dirs[
      ((deg + 22.5) / 45).floor() % 8
    ];
  }

  //*untuk icon di bagian perkiraan cuaca
  IconData getWeatherIcon(
    String condition,
  ) {

    switch (
      condition.toLowerCase()
    ) {

      case 'clear':
        return Icons.wb_sunny;

      case 'rain':
      case 'drizzle':
        return Icons.grain;

      case 'thunderstorm':
        return Icons.flash_on;

      default:
        return Icons.cloud;
    }
  }
}