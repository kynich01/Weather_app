import 'package:flutter/material.dart';

enum NavPage { result, savedLocations }

class WeatherNavBar extends StatelessWidget {
  final NavPage currentPage;
  final VoidCallback onResultTap;
  final VoidCallback onSavedLocationsTap;

  const WeatherNavBar({
    super.key,
    required this.currentPage,
    required this.onResultTap,
    required this.onSavedLocationsTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF6679FC),
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 3),
      child: Container(
        height: 64,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.12),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: _NavItem(
                isActive: currentPage == NavPage.result,
                icon: Icons.wb_sunny_rounded,
                label: 'Cuaca',
                onTap: onResultTap,
              ),
            ),
            Expanded(
              child: _NavItem(
                isActive: currentPage == NavPage.savedLocations,
                icon: Icons.bookmark_rounded,
                label: 'List Lokasi',
                onTap: onSavedLocationsTap,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final bool isActive;
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _NavItem({
    required this.isActive,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 24,
            color: isActive ? const Color(0xFF6679FC) : Colors.grey,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: isActive ? FontWeight.w700 : FontWeight.w400,
              color: isActive ? const Color(0xFF6679FC) : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}