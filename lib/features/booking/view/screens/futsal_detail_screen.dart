// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:futsalmate/common/colors.dart';
// import 'package:futsalmate/features/booking/model/futsal_detail_item_model.dart';
// import 'package:futsalmate/features/booking/view/widgets/booking_widget.dart';

// class FutsalDetailScreen extends StatelessWidget {
//   final FutsalDetailItemModel futsalDetail;

//   const FutsalDetailScreen({super.key, required this.futsalDetail});

//   // Function to get current location from shared preferences
//   Future<Map<String, String>> _getCurrentLocation() async {
//     try {
//       final pref = await SharedPreferences.getInstance();
//       String lat = pref.getString("latitude") ?? "";
//       String long = pref.getString("longitude") ?? "";
//       return {'latitude': lat, 'longitude': long};
//     } catch (e) {
//       return {'latitude': '', 'longitude': ''};
//     }
//   }

//   // Function to launch Google Maps with directions
//   Future<void> _launchDirections() async {
//     try {
//       final currentLocation = await _getCurrentLocation();
//       final currentLat = currentLocation['latitude'];
//       final currentLong = currentLocation['longitude'];

//       // Check if current location is available
//       if (currentLat == null ||
//           currentLat.isEmpty ||
//           currentLong == null ||
//           currentLong.isEmpty) {
//         _showLocationError();
//         return;
//       }

//       // Check if futsal location coordinates are available
//       if (futsalDetail.latitude == null ||
//           futsalDetail.latitude.toString().isEmpty ||
//           futsalDetail.longitude == null ||
//           futsalDetail.longitude.toString().isEmpty) {
//         _showFutsalLocationError();
//         return;
//       }

//       // Create Google Maps URL for directions
//       final String googleMapsUrl =
//           "https://www.google.com/maps/dir/?api=1"
//           "&origin=$currentLat,$currentLong"
//           "&destination=${futsalDetail.latitude},${futsalDetail.longitude}"
//           "&travelmode=driving";

//       if (await canLaunchUrl(Uri.parse(googleMapsUrl))) {
//         await launchUrl(Uri.parse(googleMapsUrl));
//       } else {
//         throw 'Could not launch Google Maps';
//       }
//     } catch (e) {
//       _showErrorDialog();
//     }
//   }

//   void _showLocationError() {
//     // You might want to show a dialog or snackbar here
//     // For now, I'll just print the error
//     print("Current location not available. Please enable location services.");
//   }

//   void _showFutsalLocationError() {
//     print("Futsal location coordinates are not available.");
//   }

//   void _showErrorDialog() {
//     print(
//       "Failed to launch Google Maps. Please make sure Google Maps is installed.",
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;

//     return Scaffold(
//       appBar: AppBar(
//         leading: BackButton(color: Colors.white),
//         title: const Text(
//           "Futsal Details",
//           style: TextStyle(color: Colors.white),
//         ),
//         centerTitle: true,
//         backgroundColor: CommonColors.primaryColor,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Futsal Image
//             Image.network(
//               futsalDetail.imageUrl,
//               height: height * 0.3,
//               width: double.infinity,
//               fit: BoxFit.cover,
//               errorBuilder: (context, error, stackTrace) => Container(
//                 height: height * 0.3,
//                 color: Colors.grey[300],
//                 alignment: Alignment.center,
//                 child: const Icon(
//                   Icons.broken_image,
//                   size: 80,
//                   color: Colors.grey,
//                 ),
//               ),
//             ),

//             Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Name
//                   Text(
//                     futsalDetail.name,
//                     style: const TextStyle(
//                       fontSize: 22,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 8),

//                   // Location
//                   Row(
//                     children: [
//                       const Icon(
//                         Icons.location_on_outlined,
//                         size: 18,
//                         color: Colors.grey,
//                       ),
//                       const SizedBox(width: 4),
//                       Expanded(
//                         child: Text(
//                           "${futsalDetail.location}, ${futsalDetail.city}",
//                           style: const TextStyle(
//                             fontSize: 14,
//                             color: Colors.grey,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 16),

//                   // Fee & Rating
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         "Price: Rs. ${futsalDetail.pricePerHour}/hr",
//                         style: const TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                       Row(
//                         children: [
//                           const Icon(
//                             Icons.star,
//                             color: Colors.orange,
//                             size: 18,
//                           ),
//                           const SizedBox(width: 4),
//                           Text(
//                             "${futsalDetail.rating.toStringAsFixed(1)}",
//                             style: const TextStyle(fontSize: 16),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 16),

//                   // Operating Hours
//                   Row(
//                     children: [
//                       const Icon(
//                         Icons.access_time,
//                         size: 18,
//                         color: Colors.grey,
//                       ),
//                       const SizedBox(width: 4),
//                       Text(
//                         "Open: ${futsalDetail.startTime} - ${futsalDetail.endTime}",
//                         style: const TextStyle(
//                           fontSize: 14,
//                           color: Colors.grey,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 16),

//                   // Description
//                   if (futsalDetail.description.isNotEmpty) ...[
//                     const Text(
//                       "Description",
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     Text(
//                       futsalDetail.description,
//                       style: const TextStyle(
//                         fontSize: 14,
//                         color: Colors.black87,
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                   ],

//                   // Contact Info
//                   const Text(
//                     "Contact",
//                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 8),
//                   Text("Phone: ${futsalDetail.ownerPhone}"),
//                   Text("Email: ${futsalDetail.ownerEmail}"),
//                   const SizedBox(height: 20),

//                   // Directions Button
//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton.icon(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.green,
//                         padding: const EdgeInsets.symmetric(vertical: 14),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                       ),
//                       onPressed: _launchDirections,
//                       icon: const Icon(Icons.directions, color: Colors.white),
//                       label: const Text(
//                         "Get Directions",
//                         style: TextStyle(fontSize: 16, color: Colors.white),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 12),

//                   // Book Button
//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: CommonColors.primaryColor,
//                         padding: const EdgeInsets.symmetric(vertical: 14),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                       ),
//                       onPressed: () {
//                         showModalBottomSheet(
//                           context: context,
//                           isScrollControlled: true,
//                           shape: const RoundedRectangleBorder(
//                             borderRadius: BorderRadius.vertical(
//                               top: Radius.circular(20),
//                             ),
//                           ),
//                           builder: (context) {
//                             return BookingWidget(futsalDetail: futsalDetail);
//                           },
//                         );
//                       },
//                       child: const Text(
//                         "Book Now",
//                         style: TextStyle(fontSize: 16, color: Colors.white),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:futsalmate/common/colors.dart';
import 'package:futsalmate/features/booking/model/futsal_detail_item_model.dart';
import 'package:futsalmate/features/booking/view/widgets/booking_widget.dart';

class FutsalDetailScreen extends StatelessWidget {
  final FutsalDetailItemModel futsalDetail;

  const FutsalDetailScreen({super.key, required this.futsalDetail});

  // Function to get current location from shared preferences
  Future<Map<String, String>> _getCurrentLocation() async {
    try {
      final pref = await SharedPreferences.getInstance();
      String lat = pref.getString("latitude") ?? "";
      String long = pref.getString("longitude") ?? "";
      return {'latitude': lat, 'longitude': long};
    } catch (e) {
      return {'latitude': '', 'longitude': ''};
    }
  }

  // Function to launch Google Maps with directions
  Future<void> _launchDirections() async {
    try {
      final currentLocation = await _getCurrentLocation();
      final currentLat = currentLocation['latitude'];
      final currentLong = currentLocation['longitude'];

      // Check if current location is available
      if (currentLat == null ||
          currentLat.isEmpty ||
          currentLong == null ||
          currentLong.isEmpty) {
        _showLocationError();
        return;
      }

      // Check if futsal location coordinates are available
      if (futsalDetail.latitude == null ||
          futsalDetail.latitude.toString().isEmpty ||
          futsalDetail.longitude == null ||
          futsalDetail.longitude.toString().isEmpty) {
        _showFutsalLocationError();
        return;
      }

      // Create Google Maps URL for directions
      final String googleMapsUrl =
          "https://www.google.com/maps/dir/?api=1"
          "&origin=$currentLat,$currentLong"
          "&destination=${futsalDetail.latitude},${futsalDetail.longitude}"
          "&travelmode=driving";

      if (await canLaunchUrl(Uri.parse(googleMapsUrl))) {
        await launchUrl(Uri.parse(googleMapsUrl));
      } else {
        throw 'Could not launch Google Maps';
      }
    } catch (e) {
      _showErrorDialog();
    }
  }

  void _showLocationError() {
    // You might want to show a dialog or snackbar here
    // For now, I'll just print the error
    print("Current location not available. Please enable location services.");
  }

  void _showFutsalLocationError() {
    print("Futsal location coordinates are not available.");
  }

  void _showErrorDialog() {
    print(
      "Failed to launch Google Maps. Please make sure Google Maps is installed.",
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.white),
        title: const Text(
          "Futsal Details",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: CommonColors.primaryColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Futsal Image
            Container(
              height: height * 0.3,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                child: Image.network(
                  futsalDetail.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Colors.grey[200],
                    child: const Icon(
                      Icons.sports_soccer,
                      size: 80,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name
                  Text(
                    futsalDetail.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Location with icon
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey[200]!),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 20,
                          color: CommonColors.primaryColor,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            "${futsalDetail.location}, ${futsalDetail.city}",
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Price and Hours in a row
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: CommonColors.primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: CommonColors.primaryColor.withOpacity(0.3),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Price",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "Rs. ${futsalDetail.pricePerHour}/hr",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.orange.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.orange.withOpacity(0.3),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Hours",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "${futsalDetail.startTime} - ${futsalDetail.endTime}",
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Description
                  if (futsalDetail.description.isNotEmpty) ...[
                    const Text(
                      "About",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey[200]!),
                      ),
                      child: Text(
                        futsalDetail.description,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                          height: 1.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],

                  // Contact Info
                  const Text(
                    "Contact Information",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey[200]!),
                    ),
                    child: Column(
                      children: [
                        _buildContactItem(
                          icon: Icons.phone,
                          label: "Phone",
                          value: futsalDetail.ownerPhone,
                        ),
                        const SizedBox(height: 12),
                        _buildContactItem(
                          icon: Icons.email,
                          label: "Email",
                          value: futsalDetail.ownerEmail,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Action Buttons
                  Column(
                    children: [
                      // Directions Button
                      Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.green.withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: _launchDirections,
                          icon: const Icon(
                            Icons.directions,
                            color: Colors.white,
                          ),
                          label: const Text(
                            "Get Directions",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Book Button
                      Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: CommonColors.primaryColor.withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: CommonColors.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20),
                                ),
                              ),
                              builder: (context) {
                                return BookingWidget(
                                  futsalDetail: futsalDetail,
                                );
                              },
                            );
                          },
                          child: const Text(
                            "Book Now",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: CommonColors.primaryColor.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 18, color: CommonColors.primaryColor),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
