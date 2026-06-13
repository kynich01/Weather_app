import 'package:flutter/material.dart';
import '/models/saved_location.dart';
import '/ui/pages/result.dart';
import '/db/weather_location_db.dart';

class LocationCard extends StatelessWidget {
  final SavedLocation loc;
  final String temp;
  final bool isSelected;
  final VoidCallback onEdit;
  final VoidCallback onDeleted;
  final VoidCallback onSelectDone;
  final VoidCallback onSelect;

  const LocationCard({
    super.key,
    required this.loc,
    required this.temp,
    required this.isSelected,
    required this.onEdit,
    required this.onDeleted,
    required this.onSelectDone,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, a, b) => Result(place: loc.city),
            transitionDuration: const Duration(milliseconds: 300),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return ScaleTransition(
                scale: Tween<double>(begin: 0.9, end: 1.0).animate(
                  CurvedAnimation(parent: animation, curve: Curves.easeOut),
                ),
                child: FadeTransition(
                  opacity: animation,
                  child: child,
                ),
              );
            },
          ),
        );
      },
      onLongPress: () {
        onSelect();
        showModalBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          builder: (_) {
            return Container(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        loc.city,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Color(0xFF6679FC),
                        ),
                      ),
                      Text(
                        "${loc.label} • ${loc.description}",
                        style: const TextStyle(color: Colors.grey, fontSize: 13),
                      ),
                      const SizedBox(height: 24),
                      Material(
                        color: Colors.transparent,
                        child: ListTile(
                          onTap: () {
                            Navigator.pop(context); 
                            onEdit();               
                          },
                          leading: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xFF6679FC).withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(Icons.edit, color: Color(0xFF6679FC)),
                          ),
                          title: const Text(
                            "Edit Lokasi",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      const Divider(),
                      Material(
                        color: Colors.transparent,
                        child: ListTile(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                title: const Text(
                                  "Hapus Lokasi?",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF6679FC),
                                  ),
                                ),
                                content: Text(
                                  "\"${loc.city}\" akan dihapus dari daftar lokasi.",
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text(
                                      "Batal",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                      await LocationDB.deleteLocation(loc.id!);
                                      onDeleted();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    child: const Text("Hapus"),
                                  ),
                                ],
                              ),
                            );
                          },
                          leading: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.red.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(Icons.delete, color: Colors.red),
                          ),
                          title: const Text(
                            "Hapus Lokasi",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ).whenComplete(onSelectDone);
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: isSelected ? 6 : 2,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              //*mengatur blue_circle selected
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: isSelected ? 15 : 0,
                height: isSelected ? 15 : 0,
                margin: EdgeInsets.only(right: isSelected ? 12 : 0), //?kalu selected = margin 12 di kanan, flase : 0
                decoration: const BoxDecoration(
                  color: Color(0xFF6679FC),
                  shape: BoxShape.circle,
                ),
                child: isSelected
                    ? const Icon(Icons.check, color: Colors.white, size: 10)
                    : null,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      loc.city,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFF6679FC),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "${loc.label} • ${loc.description}",
                      style: const TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                  ],
                ),
              ),
              Text(
                temp,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Color(0xFF6679FC),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}