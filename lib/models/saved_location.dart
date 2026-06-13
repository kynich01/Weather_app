class SavedLocation {
  final int? id;
  final String city;
  final String label;
  final String description;

  SavedLocation({
    this.id,
    required this.city,
    required this.label,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'city': city,
      'label': label,
      'description': description,
    };
  }

  factory SavedLocation.fromMap(Map<String, dynamic> map) {
    return SavedLocation(
      id: map['id'],
      city: map['city'],
      label: map['label'],
      description: map['description'],
    );
  }
}