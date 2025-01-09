class VIPPackage {
  final String id;
  final String name;
  final String description;
  final double price;
  final List<String> features;
  final int durationDays;

  VIPPackage({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.features,
    required this.durationDays,
  });

  factory VIPPackage.fromFirestore(Map<String, dynamic> data, [String? id]) {
    return VIPPackage(
      id: id ?? '',
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      price: (data['price'] ?? 0).toDouble(),
      features: List<String>.from(data['features'] ?? []),
      durationDays: data['duration_days'] ?? 30,
    );
  }
}