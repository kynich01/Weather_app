import 'package:flutter/material.dart';
import '/controller/search_controller.dart';
import '/ui/pages/result.dart';
import '/ui/widgets/search_bottom_panel.dart';

class SearchField extends StatefulWidget {
  const SearchField({super.key});

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  //*Memanggil class yang ada di kontroller
  final SearchFieldController _controller = SearchFieldController();

  //*fungsi untuk navi ke result
  void _navigateToResult(BuildContext context) {
    if (!_controller.isValid) return;
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, a, b) => Result(place: _controller.placeController.text.trim()),
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

  //*membersihkan kontroller ketika sudah tidak dipakai
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller, 
      builder: (context, _) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: [
              //*Gambar atas
              Expanded(
                child: Center(
                  child: Image.asset('assets/find_location.png', height: 550),
                ),
              ),

              //*Panel bawah
              SearchBottomPanel(
                controller: _controller,
                onSubmit: () => _navigateToResult(context),
              ),
            ],
          ),
        );
      },
    );
  }
}