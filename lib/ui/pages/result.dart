import 'package:flutter/material.dart';
import '/services/weather_service.dart';
import '/controller/weather_controller.dart'; //
import '/controller/search_controller.dart';
import '/ui/widgets/weather_top_section.dart'; 
import '/ui/widgets/weather_bottom_section.dart';
import '/ui/widgets/result_search_bar.dart'; 
import '/ui/widgets/weather_navbar.dart'; 
import '/ui/pages/saved_locations_page.dart'; //

class Result extends StatefulWidget {
  final String place;
  const Result({super.key, required this.place});

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  final WeatherService weatherService = WeatherService();
  final WeatherController controller = WeatherController();
  final SearchFieldController _searchController = SearchFieldController();

  late Future<Map<String, dynamic>> _weatherFuture;

  @override
  void initState() {
    super.initState();
    _weatherFuture = weatherService.getAllData(widget.place);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _submitSearch(BuildContext context) {
    if (!_searchController.isValid) return;
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, a, b) => Result(place: _searchController.placeController.text.trim()),
        transitionDuration: const Duration(milliseconds: 300),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
  }

  void _goToSavedLocations(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, a, b) => SavedLocationsPage(lastPlace: widget.place),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF6679FC),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _weatherFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Colors.white));
          }
          if (!snapshot.hasData) {
            return const Center(child: Text("Location Error!", style: TextStyle(color: Colors.white)));
          }

          //*Ambil semua data
          final data = snapshot.data!["weather"];
          final forecastData = snapshot.data!["forecast"];
          final weatherCondition = data["weather"][0]["main"];
          final animationPath = controller.getWeatherAnimation(weatherCondition);
          final timezoneOffset = data["timezone"];
          final sunrise = controller.formatTime(data["sys"]["sunrise"], timezoneOffset);
          final sunset = controller.formatTime(data["sys"]["sunset"], timezoneOffset);
          final feelsLike = data["main"]["feels_like"].round();
          final tempMax = data["main"]["temp_max"].round();
          final tempMin = data["main"]["temp_min"].round();
          final clouds = data["clouds"]["all"];
          final visibility = (data["visibility"] / 1000).toStringAsFixed(0);
          final windSpeed = (data["wind"]["speed"] * 3.6).toStringAsFixed(1);
          final windDeg = data["wind"]["deg"];
          final humidity = data["main"]["humidity"];
          final forecastList = forecastData["list"] as List;

          return SafeArea(
            child: AnimatedBuilder(
              animation: _searchController,
              builder: (context, _) {
                return Column(
                  children: [
                    // Bagian atas: suhu + animasi
                    WeatherTopSection(
                      place: widget.place,
                      data: data,
                      weatherCondition: weatherCondition,
                      animationPath: animationPath,
                      tempMax: tempMax,
                      tempMin: tempMin,
                      feelsLike: feelsLike,
                    ),

                    //*Bagian tengah: semua card
                    WeatherBottomSection(
                      data: data,
                      forecastList: forecastList,
                      controller: controller,
                      sunrise: sunrise,
                      sunset: sunset,
                      windSpeed: windSpeed,
                      visibility: visibility,
                      windDeg: windDeg,
                      humidity: humidity,
                      clouds: clouds,
                    ),

                    //*Search bar bawah
                    ResultSearchBar(
                      controller: _searchController,
                      onSubmit: () => _submitSearch(context),
                    ),

                    //*Navbar bawah
                    WeatherNavBar(
                      currentPage: NavPage.result,
                      onResultTap: () {}, // sudah di halaman ini
                      onSavedLocationsTap: () => _goToSavedLocations(context),
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}