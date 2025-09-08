// class FutsalDetailItemModel {
//   final String name;
//   final String location;
//   final String fee;
//   final String openingTime;
//   final String openingHours;
//   final List<String> availability;
//   final String imgeUrl;
//   final String latitude;
//   final String longitude;

//   FutsalDetailItemModel({
//     required this.name,
//     required this.location,
//     required this.fee,
//     required this.openingTime,
//     required this.openingHours,
//     required this.availability,
//     required this.imgeUrl,
//     required this.latitude,
//     required this.longitude,
//   });

//   @override
//   String toString() {
//     return 'FutsalDetailItemModel('
//         'name: $name, '
//         'location: $location, '
//         'fee: $fee, '
//         'openingTime: $openingTime, '
//         'openingHours: $openingHours, '
//         'latitude: $latitude,'
//         'longitude: $longitude,'
//         'availability: $availability'
//         ')';
//   }
// }

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
  final int pricePerHour;
  final bool isVerified;
  final String status;
  final double rating;
  final int totalRatings;
  final int totalBookings;
  final String startTime;
  final String endTime;
  final String latitude;
  final String longitude;

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
}
