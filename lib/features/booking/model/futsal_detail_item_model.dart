class FutsalDetailItemModel {
  final String name;
  final String location;
  final String fee;
  final String openingTime;
  final String openingHours;
  final List<String> availability;
  final String imgeUrl;
  final String latitude;
  final String longitude;

  FutsalDetailItemModel({
    required this.name,
    required this.location,
    required this.fee,
    required this.openingTime,
    required this.openingHours,
    required this.availability,
    required this.imgeUrl,
    required this.latitude,
    required this.longitude,
  });

  @override
  String toString() {
    return 'FutsalDetailItemModel('
        'name: $name, '
        'location: $location, '
        'fee: $fee, '
        'openingTime: $openingTime, '
        'openingHours: $openingHours, '
        'latitude: $latitude,'
        'longitude: $longitude,'
        'availability: $availability'
        ')';
  }
}
