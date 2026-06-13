import 'package:flutter/material.dart';
import 'dart:async';

class AutoSlideCard extends StatefulWidget {
  final String windDirection;
  final String windSpeed;
  final int humidity;
  final int pressure;

  const AutoSlideCard({
    super.key,
    required this.windDirection,
    required this.windSpeed,
    required this.humidity,
    required this.pressure,
  });

  @override
  State<AutoSlideCard> createState() => _AutoSlideCardState();
}

class _AutoSlideCardState extends State<AutoSlideCard> {
  final PageController _pageController = PageController();

  int _currentPage = 0;

  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(
      const Duration(seconds: 5),
      (timer) {
        final nextPage = (_currentPage + 1) % 3;

        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOutCubic,
        );

        setState(() {
          _currentPage = nextPage;
        });
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> infos = [
      {
        "icon": Icons.air,
        "title": "Angin",
        "desc":
            "Angin bertiup dari arah ${widget.windDirection} "
                "dengan kecepatan ${widget.windSpeed} km/h.",
      },
      {
        "icon": Icons.water_drop,
        "title": "Kelembapan",
        "desc":
            "Kelembapan udara saat ini sebesar ${widget.humidity}%. "
                "${widget.humidity > 70 ? 'Udara terasa lembap.' : 'Udara cukup nyaman.'}",
      },
      {
        "icon": Icons.compress,
        "title": "Tekanan Udara",
        "desc":
            "Tekanan atmosfer saat ini ${widget.pressure} hPa. "
                "${widget.pressure > 1013 ? 'Cuaca cenderung cerah.' : 'Cuaca cenderung mendung.'}",
      },
    ];

    return SizedBox(
      width: 400,
      height: 110,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xFF6679FC),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: infos.length,
                onPageChanged: (i) {
                  setState(() {
                    _currentPage = i;
                  });
                },
                itemBuilder: (context, index) {
                  final info = infos[index];

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            info["icon"] as IconData,
                            color: Colors.white,
                            size: 16,
                          ),

                          const SizedBox(width: 6),

                          Text(
                            info["title"],
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 6),

                      Padding(
                        padding: const EdgeInsets.only(left: 22),
                        child: Text(
                          info["desc"],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                infos.length,
                    (i) => AnimatedContainer(
                  duration: const Duration(milliseconds: 600),
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _currentPage == i
                        ? Colors.white
                        : Colors.white.withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}