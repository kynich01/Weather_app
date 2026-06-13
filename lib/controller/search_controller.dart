import 'dart:async';
import 'package:flutter/material.dart';
import '/services/weather_service.dart';

class SearchFieldController extends ChangeNotifier {
  final TextEditingController placeController = TextEditingController();
  //*memanggil class api
  final WeatherService _service = WeatherService();

  //*deklarasi variabel
  bool isChecking = false;
  bool isValid = false;
  bool isError = false;
  String? errorMessage;
  Timer? _debounce;

  //*Warna border sesuai status
  Color get borderColor {
    if (isError) return Colors.red;
    if (isValid) return Colors.green;
    return Colors.transparent;
  }

  //*pengecekan untuk input user
  void onChanged(String value) {
    isValid = false;
    isError = false;
    errorMessage = null;
    notifyListeners();

    _debounce?.cancel();
    if (value.trim().isEmpty) return;

    _debounce = Timer(const Duration(milliseconds: 500), () {
      checkCity(value.trim());
    });
  }

  Future<void> checkCity(String input) async {
    isChecking = true;
    notifyListeners();

    try {
      final valid = await _service.checkCity(input);
      isChecking = false;
      isValid = valid;
      isError = !valid;
      errorMessage = valid
          ? null
          : "Kota \"$input\" tidak ditemukan. Coba periksa ejaan.";
    } catch (_) {
      isChecking = false;
      isError = true;
      errorMessage = "Tidak ada koneksi internet.";
    }

    notifyListeners();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    placeController.dispose();
    super.dispose();
  }
}