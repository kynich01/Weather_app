import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherService {

  //* Api key
  static const String apiKey =
      "YOUR_API_KEY_HERE";

  Future<Map<String, dynamic>> getAllData(String place) async {

    //* http get api
    //? Whatherres Api untuk data saat ini 
    final weatherRes = await http.get(
      Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=$place&units=metric&appid=$apiKey",
      ),
    );

    //? forecastres Api untuk data perkiraan cuaca
    final forecastRes = await http.get(
      Uri.parse(
        "https://api.openweathermap.org/data/2.5/forecast?q=$place&units=metric&appid=$apiKey",
      ),
    );

    //* Cek status kode
    //? hhtp dengan kode 200 = berhasil mengabil data 
    if (weatherRes.statusCode == 200 &&
        forecastRes.statusCode == 200) {

      return {
        "weather": json.decode(weatherRes.body),
        "forecast": json.decode(forecastRes.body),
      };

    } else {
      throw Exception("Gagal mengambil data!");
    }
  }
  
  //*Cek nama kota
  Future<bool> checkCity(String cityName) async {
    try {
      final res = await http.get(
        Uri.parse(
          "https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey",
        ),
      );
      return res.statusCode == 200;
    } catch (_) {
      return false;
    }
  }
}

