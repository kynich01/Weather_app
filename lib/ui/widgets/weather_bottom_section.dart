import 'package:flutter/material.dart';
import 'package:tracking_cuaca/controller/weather_controller.dart';
import '/ui/widgets/blue_card.dart';
import '/ui/widgets/auto_slide_card.dart';

class WeatherBottomSection extends StatelessWidget {
  final Map<String, dynamic> data;
  final List forecastList;
  final WeatherController controller;
  final String sunrise;
  final String sunset;
  final String windSpeed;
  final String visibility;
  final int windDeg;
  final int humidity;
  final int clouds;

  const WeatherBottomSection({
    super.key,
    required this.data,
    required this.forecastList,
    required this.controller,
    required this.sunrise,
    required this.sunset,
    required this.windSpeed,
    required this.visibility,
    required this.windDeg,
    required this.humidity,
    required this.clouds,
  });

  @override
  Widget build(BuildContext context) {
    final next6 = forecastList.take(6).toList();

    return Expanded(
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            children: [
              // Card Angin
              AutoSlideCard(
                windDirection: controller.getWindDirection(windDeg),
                windSpeed: windSpeed,
                humidity: humidity,
                pressure: data["main"]["pressure"],
              ),

              const SizedBox(height: 14),

              // Card Sunrise & Sunset
              BlueCard(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        const Text("Sunrise", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 23)),
                        Text(sunrise, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16)),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [BoxShadow(color: Colors.white.withValues(alpha: 0.2), blurRadius: 50, spreadRadius: 30)],
                      ),
                      child: Image.asset('assets/sunrise.png', width: 80, height: 80),
                    ),
                    Column(
                      children: [
                        const Text("Sunset", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 23)),
                        Text(sunset, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16)),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 14),

              // Row: Perkiraan cuaca + Awan & Jarak Pandang
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 5,
                    child: BlueCard(
                      child: Column(
                        children: [
                          const Text("Perkiraan cuaca", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 17)),
                          const SizedBox(height: 10),
                          ...next6.map((f) {
                            final time = DateTime.fromMillisecondsSinceEpoch(f["dt"] * 1000);
                            final hour = "${time.hour.toString().padLeft(2, '0')}:00";
                            final temp = f["main"]["temp"].round().toString();
                            final cond = f["weather"][0]["main"];
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(width: 42, child: Text(hour, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 12))),
                                  Icon(controller.getWeatherIcon(cond), size: 16, color: Colors.white),
                                  const SizedBox(width: 4),
                                  Text("$temp°", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 12)),
                                ],
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  // Awan + Jarak Pandang
                  Expanded(
                    flex: 4,
                    child: Column(
                      children: [
                        BlueCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(children: const [Icon(Icons.cloud, color: Colors.white, size: 16), SizedBox(width: 4), Text("Awan", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 13))]),
                              const SizedBox(height: 6),
                              Text("Persentase awan di atmosfer sebesar $clouds%", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 13)),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        BlueCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(children: const [Icon(Icons.remove_red_eye, color: Colors.white, size: 16), SizedBox(width: 4), Text("Jarak Pandang", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13))]),
                              const SizedBox(height: 6),
                              Text("Jarak pandang saat ini mencapai $visibility km", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 12)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              // Card Kondisi Cuaca
              BlueCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: const [
                      Icon(Icons.wb_cloudy, color: Colors.white, size: 16),
                      SizedBox(width: 6),
                      Text("Kondisi Cuaca", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 13)),
                    ]),
                    const SizedBox(height: 4),
                    Padding(
                      padding: const EdgeInsets.only(left: 22),
                      child: Text(
                        "Kondisi cuaca saat ini ${data["weather"][0]["description"]}.",
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}