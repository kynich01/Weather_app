import 'package:flutter/material.dart';
import '/models/saved_location.dart'; 
import '/controller/saved_locations_controller.dart'; 
import '/ui/widgets/location_card.dart'; 
import '/ui/widgets/add_location_sheet.dart'; 
import '/ui/widgets/weather_navbar.dart'; 

class SavedLocationsPage extends StatefulWidget {
  final String lastPlace;
  const SavedLocationsPage({super.key, this.lastPlace = ''});

  @override
  State<SavedLocationsPage> createState() => _SavedLocationsPageState();
}

class _SavedLocationsPageState extends State<SavedLocationsPage> {
  final _controller = SavedLocationsController();
  bool _isExpanded = false;

  void _openEditSheet(SavedLocation loc) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return AddLocationSheet(
          onSaved: _controller.loadLocations,
          existingLocation: loc,
        );
      },
    );
  }

  void _openAddSheet() {
    setState(() => _isExpanded = false);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return AddLocationSheet(
          onSaved: _controller.loadLocations,
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => setState(() {}));
    _controller.loadLocations();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFF6679FC),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("List Cuaca", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF6679FC),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [

          // isi utama
          Expanded(
            child: _controller.locations.isEmpty
                ? const Center(
                    child: Text(
                      "Belum ada lokasi",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _controller.locations.length,
                    itemBuilder: (context, index) {
                      final loc = _controller.locations[index];
                      final temp = _controller.temperatures[loc.id] ?? "...";
                      final isSelected = _controller.selectedId == loc.id;
                      return LocationCard(
                        loc: loc,
                        temp: temp,
                        isSelected: isSelected,
                        onEdit: () => _openEditSheet(loc),
                        onDeleted: _controller.loadLocations,
                        onSelect: () => setState(() => _controller.selectedId = loc.id),
                        onSelectDone: () => setState(() => _controller.selectedId = null),
                      );
                    },
                  ),
          ),

          // Stack: tombol ^ mengambang + container putih + navbar
          Stack(
            clipBehavior: Clip.none,
            children: [

              // Container putih (tambah lokasi + navbar)
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  
                  // Tombol ^ di sini, pakai Transform untuk efek mengambang
                  Center(
                    child: GestureDetector(
                      onTap: () => setState(() => _isExpanded = !_isExpanded),
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: AnimatedRotation(
                          turns: _isExpanded ? 0.5 : 0.0,
                          duration: const Duration(milliseconds: 250),
                          child: const Icon(
                            Icons.keyboard_arrow_up_rounded,
                            color: Color(0xFF6679FC),
                            size: 22,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Konten tambah lokasi expandable
                  ClipRect(
                    child: AnimatedAlign(
                      alignment: Alignment.topCenter,
                      heightFactor: _isExpanded ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      child: GestureDetector(
                        onTap: _openAddSheet,
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                          child: const Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.add, color: Color(0xFF6679FC), size: 38),
                              SizedBox(height: 6),
                              Text(
                                "Tambah Lokasi",
                                style: TextStyle(
                                  color: Color(0xFF6679FC),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Navbar
                  SafeArea(
                    top: false,
                    child: WeatherNavBar(
                      currentPage: NavPage.savedLocations,
                      onResultTap: () {
                        if (widget.lastPlace.isEmpty) return;
                        Navigator.pop(context);
                      },
                      onSavedLocationsTap: () {},
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}