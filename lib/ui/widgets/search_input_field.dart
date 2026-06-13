import 'package:flutter/material.dart';
import '/controller/search_controller.dart';

class SearchInputField extends StatelessWidget {
  final SearchFieldController controller;
  final VoidCallback onSubmit;

  const SearchInputField({
    super.key,
    required this.controller,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller.placeController,
          onChanged: controller.onChanged,
          onSubmitted: (_) => onSubmit(),
          style: const TextStyle(color: Colors.black87),
          decoration: InputDecoration(
            hintText: 'Masukan nama kota',
            hintStyle: const TextStyle(color: Colors.grey),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 14,
            ),
            suffixIconConstraints: const BoxConstraints(
              minWidth: 40,
              minHeight: 40,
            ),
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 15),
              child: controller.isChecking
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Color(0xFF6679FC),
                      ),
                    )
                  : GestureDetector(
                      onTap: onSubmit,
                      child: controller.isValid
                          ? const Icon(Icons.check_circle, color: Colors.green, size: 28)
                          : controller.isError
                              ? const Icon(Icons.error, color: Colors.red, size: 28)
                              : Image.asset('assets/magnifying-glass.png', width: 30, height: 30),
                    ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: controller.borderColor, width: 2),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: controller.borderColor, width: 2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: controller.borderColor, width: 2),
            ),
          ),
        ),

        // Pesan error
        if (controller.errorMessage != null) ...[
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text(
              controller.errorMessage!,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ],
    );
  }
}