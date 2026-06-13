import 'package:flutter/material.dart';
import '/controller/search_controller.dart';

class ResultSearchBar extends StatelessWidget {
  final SearchFieldController controller;
  final VoidCallback onSubmit;

  const ResultSearchBar({
    super.key,
    required this.controller,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        return Container(
          color: const Color(0xFF6679FC),
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //*Search bar + error message
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: controller.isError
                              ? Colors.red
                              : controller.isValid
                                  ? Colors.green
                                  : const Color(0xFF6679FC),
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Image.asset('assets/placeholder.png', width: 25, height: 25),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              controller: controller.placeController,
                              onChanged: controller.onChanged,
                              onSubmitted: (_) => onSubmit(),
                              decoration: const InputDecoration(
                                hintText: 'Masukan nama kota',
                                hintStyle: TextStyle(color: Colors.grey),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          if (controller.isChecking)
                            const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Color(0xFF6679FC),
                              ),
                            )
                          else if (controller.isValid)
                            GestureDetector(
                              onTap: onSubmit,
                              child: const Icon(Icons.check_circle, color: Colors.green, size: 22),
                            )
                          else if (controller.isError)
                            const Icon(Icons.error, color: Colors.red, size: 22),
                        ],
                      ),
                    ),

                    //!Pesan error dari controller
                    if (controller.isError && controller.errorMessage != null)
                      Padding(
                        padding: const EdgeInsets.only(left: 16, top: 4),
                        child: Text(
                          controller.errorMessage!,
                          style: const TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}