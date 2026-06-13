import 'package:flutter/material.dart';

class BlueCard extends StatelessWidget {
  final Widget child;

  const BlueCard({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF6679FC),
        borderRadius: BorderRadius.circular(16),
      ),
      child: child,
    );
  }
}