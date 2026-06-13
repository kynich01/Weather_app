import 'dart:async';
import 'package:flutter/material.dart';
import '/db/weather_location_db.dart';
import '/models/saved_location.dart';
import '/services/weather_service.dart';

class AddLocationSheet extends StatefulWidget {
  final VoidCallback onSaved;
  final SavedLocation? existingLocation;

  const AddLocationSheet({
    super.key,
    required this.onSaved,
    this.existingLocation,
  });

  @override
  State< AddLocationSheet> createState() => AddLocationSheetState();
}

class AddLocationSheetState extends State< AddLocationSheet> {

  final _cityController = TextEditingController();
  final _descController = TextEditingController();
  final _customLabelController = TextEditingController();

  String _selectedLabel = "Rumah";
  String? _cityError;
  bool _isCheckingCity = false;
  bool _isCityValid = false;

  Timer? _debounce;
  final _service = WeatherService();

  @override
void initState() {
  super.initState();

  //*kalau edit, isi form dengan data lama
  if (widget.existingLocation != null) {
    final loc = widget.existingLocation!;
    _cityController.text = loc.city;
    _descController.text = loc.description;
    _isCityValid = true; //?anggap valid karena sudah tersimpan sebelumnya

    //*set label
    const knownLabels = ["Rumah", "Kantor", "Sekolah"];
    if (knownLabels.contains(loc.label)) {
      _selectedLabel = loc.label;
    } else {
      _selectedLabel = "Lainnya";
      _customLabelController.text = loc.label;
    }
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _cityController.dispose();
    _descController.dispose();
    _customLabelController.dispose();
    super.dispose();
  }

  void _onCityChanged(String value) {
    setState(() {
      _cityError = null;
      _isCityValid = false;
    });

    _debounce?.cancel();
    if (value.trim().isEmpty) return;

    _debounce = Timer(const Duration(milliseconds: 800), () {
      _checkCity(value.trim());
    });
  }

  Future<void> _checkCity(String cityName) async {
    setState(() => _isCheckingCity = true);

    try {
      final isValid = await _service.checkCity(cityName);
      setState(() {
        _isCityValid = isValid;
        _cityError = isValid ? null : "Kota \"$cityName\" tidak ditemukan. Coba periksa ejaan";
        _isCheckingCity = false;
      });
    } catch (_) {
      setState(() {
        _cityError = "Tidak ada koneksi internet.";
        _isCityValid = false;
        _isCheckingCity = false;
      });
    }
  }

  Future<void> _save() async {
    final label = _selectedLabel == "Lainnya"
        ? _customLabelController.text
        : _selectedLabel;

    final location = SavedLocation(
      id: widget.existingLocation?.id,
      city: _cityController.text,
      label: label,
      description: _descController.text,
    );

    //*kalau ada id = update, kalau tidak = insert baru
    if (widget.existingLocation != null) {
      await LocationDB.updateLocation(location);
    } else {
      await LocationDB.insertLocation(location);
    }

    widget.onSaved();
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              widget.existingLocation != null ? "Edit Lokasi" : "Tambah Lokasi",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Color(0xFF6679FC),
              ),
            ),

            const SizedBox(height: 20),

            //*field kota
            TextField(
              controller: _cityController,
              onChanged: _onCityChanged,
              decoration: InputDecoration(
                labelText: "Nama Kota",
                suffixIcon: _isCheckingCity
                    ? const Padding(
                        padding: EdgeInsets.all(12),
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Color(0xFF6679FC),
                          ),
                        ),
                      )
                    : _isCityValid
                        ? const Icon(Icons.check_circle, color: Colors.green)
                        : _cityError != null
                            ? const Icon(Icons.error, color: Colors.red)
                            : null,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: _cityError != null
                        ? Colors.red
                        : _isCityValid
                            ? Colors.green
                            : const Color(0xFF6679FC),
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: _cityError != null
                        ? Colors.red
                        : _isCityValid
                            ? Colors.green
                            : const Color(0xFF6679FC),
                    width: 2,
                  ),
                ),
                errorText: _cityError,
              ),
            ),

            const SizedBox(height: 18),

            //*deskripsi
            TextField(
              controller: _descController,
              decoration: const InputDecoration(
                labelText: "Short Deskripsi (Opsional)",
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF6679FC)),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF6679FC), width: 2),
                ),
              ),
            ),

            const SizedBox(height: 18),

            //*dropdown
            const Text(
              "Label",
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 8),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ...["Rumah", "Kantor", "Sekolah"].map((label) {
                    final isSelected = _selectedLabel == label;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedLabel = label),
                      child: Container(
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFF6679FC)
                              : const Color(0xFF6679FC).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          label,
                          style: TextStyle(
                            color: isSelected
                                ? Colors.white
                                : const Color(0xFF6679FC),
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    );
                  }),
                  GestureDetector(
                    onTap: () => setState(() => _selectedLabel = "Lainnya"),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: _selectedLabel == "Lainnya"
                            ? const Color(0xFF6679FC)
                            : const Color(0xFF6679FC).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.add,
                            size: 14,
                            color: _selectedLabel == "Lainnya"
                                ? Colors.white
                                : const Color(0xFF6679FC),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "Lainnya",
                            style: TextStyle(
                              color: _selectedLabel == "Lainnya"
                                  ? Colors.white
                                  : const Color(0xFF6679FC),
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            if (_selectedLabel == "Lainnya") ...[
              const SizedBox(height: 18),
              TextField(
                controller: _customLabelController,
                decoration: const InputDecoration(
                  labelText: "Masukan Nama Label",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF6679FC)),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF6679FC),
                      width: 2,
                    ),
                  ),
                ),
              ),
            ],

            //*PERTAHANKAN: bagian ini tidak berubah
            const SizedBox(height: 28),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Batal",
                      style: TextStyle(color: Colors.grey)),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _isCityValid ? _save : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6679FC),
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: Colors.grey.shade300,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text("Simpan"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}