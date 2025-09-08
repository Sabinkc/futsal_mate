class FutsalDetailItemModel {
  final String futsalId;
  final String name;
  final String imageUrl;
  final String address;
  final String city;
  final String location;
  final String description;
  final String ownerEmail;
  final String ownerPhone;
  final num pricePerHour;
  final bool isVerified;
  final String status;
  final num rating;
  final num totalRatings;
  final num totalBookings;
  final String startTime;
  final String endTime;
  final num latitude;
  final num longitude;

  FutsalDetailItemModel({
    required this.futsalId,
    required this.name,
    required this.imageUrl,
    required this.address,
    required this.city,
    required this.location,
    required this.description,
    required this.ownerEmail,
    required this.ownerPhone,
    required this.pricePerHour,
    required this.isVerified,
    required this.status,
    required this.rating,
    required this.totalRatings,
    required this.totalBookings,
    required this.startTime,
    required this.endTime,
    required this.latitude,
    required this.longitude,
  });

  @override
  String toString() {
    return '''
FutsalDetailItemModel(
  futsalId: $futsalId,
  name: $name,
  imageUrl: $imageUrl,
  address: $address,
  city: $city,
  location: $location,
  description: $description,
  ownerEmail: $ownerEmail,
  ownerPhone: $ownerPhone,
  pricePerHour: $pricePerHour,
  isVerified: $isVerified,
  status: $status,
  rating: $rating,
  totalRatings: $totalRatings,
  totalBookings: $totalBookings,
  startTime: $startTime,
  endTime: $endTime,
  latitude: $latitude,
  longitude: $longitude
)''';
  }
}
