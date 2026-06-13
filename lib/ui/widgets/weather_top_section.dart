import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class WeatherTopSection extends StatelessWidget {
  final String place;
  final Map<String, dynamic> data;
  final String weatherCondition;
  final String animationPath;
  final int tempMax;
  final int tempMin;
  final int feelsLike;

  const WeatherTopSection({
    super.key,
    required this.place,
    required this.data,
    required this.weatherCondition,
    required this.animationPath,
    required this.tempMax,
    required this.tempMin,
    required this.feelsLike,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //*Header lokasi
          Row(
            children: [
              Image.asset('assets/pin_white.png', width: 20, height: 20),
              const SizedBox(width: 4),
              Text(
                place,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 13),

          //*Suhu besar + animasi
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${data["main"]["temp"].round()}°",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 72,
                          fontWeight: FontWeight.bold,
                          height: 1,
                        ),
                      ),
                      Text(
                        weatherCondition,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        "↑$tempMax°/↓$tempMin°",
                        style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Terasa seperti $feelsLike°",
                        style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              Transform.translate(
                offset: const Offset(0, -20),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withValues(alpha: 0.2),
                        blurRadius: 40,
                        spreadRadius: 10,
                      ),
                    ],
                  ),
                  child: Lottie.asset(animationPath, width: 170, height: 170),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}