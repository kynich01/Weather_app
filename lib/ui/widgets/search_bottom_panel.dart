import 'package:flutter/material.dart';
import '/controller/search_controller.dart';
import '/ui/widgets/search_input_field.dart';

class SearchBottomPanel extends StatelessWidget {
  final SearchFieldController controller;
  final VoidCallback onSubmit;

  const SearchBottomPanel({
    super.key,
    required this.controller,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFF6679FC),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(150),
          topRight: Radius.circular(150),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 66),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Weather Tracking',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Tracking cuaca dan pilih lokasi dengan memasukan\n'
            'nama lokasi yang ingin di track pada search bar\n'
            'dibawah ini',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white70, fontSize: 13, height: 1.5),
          ),
          const SizedBox(height: 28),

          // Widget TextField
          SearchInputField(
            controller: controller,
            onSubmit: onSubmit,
          ),

          const SizedBox(height: 16),
        ],
      ),
    );
  }
}