class FutsalDetailItemModel {
  final String name;
  final String location;
  final String fee;
  final String openingTime;
  final String openingHours;
  final List<String> availability;
  final String imgeUrl;

  FutsalDetailItemModel({
    required this.name,
    required this.location,
    required this.fee,
    required this.openingTime,
    required this.openingHours,
    required this.availability,
    required this.imgeUrl,
  });

  @override
  String toString() {
    return 'FutsalDetailItemModel('
        'name: $name, '
        'location: $location, '
        'fee: $fee, '
        'openingTime: $openingTime, '
        'openingHours: $openingHours, '
        'availability: $availability'
        ')';
  }
}
