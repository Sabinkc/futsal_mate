// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:futsalmate/common/colors.dart';
// import 'package:futsalmate/features/booking/controller/booking_controller.dart';
// import 'package:futsalmate/features/booking/model/futsal_detail_item_model.dart';
// import 'package:futsalmate/features/booking/view/screens/futsal_detail_screen.dart';
// import 'dart:developer' as logger;

// class BookingScreen extends ConsumerStatefulWidget {
//   const BookingScreen({super.key});

//   @override
//   ConsumerState<BookingScreen> createState() => _BookingScreenState();
// }

// class _BookingScreenState extends ConsumerState<BookingScreen> {
//   final TextEditingController _searchController = TextEditingController();
//   List<FutsalDetailItemModel> _filteredFutsals = [];
//   bool _isInitialized = false;

//   @override
//   void initState() {
//     super.initState();
//     Future.delayed(Duration.zero, () async {
//       final futsalRefR = ref.read(futsalDetailController);
//       await futsalRefR.fetchFutsalDetails();
//     });
//   }

//   void _filterFutsals(String query, List<FutsalDetailItemModel> allFutsals) {
//     if (query.isEmpty) {
//       setState(() {
//         _filteredFutsals = allFutsals;
//       });
//     } else {
//       final filtered = allFutsals
//           .where(
//             (futsal) => futsal.name.toLowerCase().contains(query.toLowerCase()),
//           )
//           .toList();
//       setState(() {
//         _filteredFutsals = filtered;
//       });
//     }
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final futsalRef = ref.watch(futsalDetailController);

//     // Initialize filtered list only once when data is loaded
//     if (!_isInitialized &&
//         !futsalRef.isFetchFutsalLoading &&
//         futsalRef.futsalDetails.isNotEmpty) {
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         setState(() {
//           _filteredFutsals = futsalRef.futsalDetails;
//           _isInitialized = true;
//         });
//       });
//     }

//     // Get the current list to display
//     final List<FutsalDetailItemModel> displayList =
//         _searchController.text.isEmpty
//         ? futsalRef.futsalDetails
//         : _filteredFutsals;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Bookings", style: TextStyle(color: Colors.white)),
//         centerTitle: true,
//         backgroundColor: CommonColors.primaryColor,
//         // actions: [
//         //   Padding(
//         //     padding: const EdgeInsets.only(right: 10),
//         //     child: InkWell(
//         //       onTap: () {
//         //         // TODO: Implement filter
//         //       },
//         //       child: const Text(
//         //         "Filter",
//         //         style: TextStyle(color: Colors.white),
//         //       ),
//         //     ),
//         //   ),
//         // ],
//       ),
//       body: Column(
//         children: [
//           // Search Bar
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Colors.grey[100],
//                 borderRadius: BorderRadius.circular(12),
//                 border: Border.all(color: Colors.grey[300]!),
//               ),
//               child: TextField(
//                 controller: _searchController,
//                 decoration: InputDecoration(
//                   hintText: "Search futsals by name...",
//                   prefixIcon: const Icon(Icons.search, color: Colors.grey),
//                   border: InputBorder.none,
//                   contentPadding: const EdgeInsets.symmetric(
//                     vertical: 16,
//                     horizontal: 16,
//                   ), // Add vertical padding
//                   suffixIcon: _searchController.text.isNotEmpty
//                       ? IconButton(
//                           icon: const Icon(Icons.clear, color: Colors.grey),
//                           onPressed: () {
//                             _searchController.clear();
//                             _filterFutsals('', futsalRef.futsalDetails);
//                           },
//                         )
//                       : null,
//                 ),
//                 onChanged: (value) {
//                   _filterFutsals(value, futsalRef.futsalDetails);
//                 },
//               ),
//             ),
//           ),
//           // Results count
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   _searchController.text.isEmpty
//                       ? "All futsals (${futsalRef.futsalDetails.length})"
//                       : "Found ${_filteredFutsals.length} futsal${_filteredFutsals.length != 1 ? 's' : ''}",
//                   style: const TextStyle(color: Colors.grey, fontSize: 14),
//                 ),
//                 if (_searchController.text.isNotEmpty)
//                   TextButton(
//                     onPressed: () {
//                       _searchController.clear();
//                       _filterFutsals('', futsalRef.futsalDetails);
//                     },
//                     child: Text(
//                       "Clear",
//                       style: TextStyle(color: CommonColors.primaryColor),
//                     ),
//                   ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 8),
//           // Futsals List
//           Expanded(
//             child: futsalRef.isFetchFutsalLoading
//                 ? Center(
//                     child: CircularProgressIndicator(
//                       color: CommonColors.primaryColor,
//                     ),
//                   )
//                 : displayList.isEmpty
//                 ? Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(
//                           _searchController.text.isEmpty
//                               ? Icons.sports_soccer
//                               : Icons.search_off,
//                           size: 80,
//                           color: Colors.grey,
//                         ),
//                         const SizedBox(height: 16),
//                         Text(
//                           _searchController.text.isEmpty
//                               ? "No futsals available"
//                               : "No futsals found for '${_searchController.text}'",
//                           style: const TextStyle(
//                             fontSize: 16,
//                             color: Colors.grey,
//                           ),
//                           textAlign: TextAlign.center,
//                         ),
//                         if (_searchController.text.isNotEmpty)
//                           Padding(
//                             padding: const EdgeInsets.only(top: 16),
//                             child: TextButton(
//                               onPressed: () {
//                                 _searchController.clear();
//                                 _filterFutsals('', futsalRef.futsalDetails);
//                               },
//                               child: Text(
//                                 "Clear search",
//                                 style: TextStyle(
//                                   color: CommonColors.primaryColor,
//                                 ),
//                               ),
//                             ),
//                           ),
//                       ],
//                     ),
//                   )
//                 : ListView.builder(
//                     itemCount: displayList.length,
//                     itemBuilder: (context, index) {
//                       final futsal = displayList[index];

//                       return Padding(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 20,
//                           vertical: 10,
//                         ),
//                         child: InkWell(
//                           onTap: () {
//                             logger.log("futsal detail: $futsal");
//                             Navigator.push(
//                               context,
//                               CupertinoPageRoute(
//                                 builder: (context) =>
//                                     FutsalDetailScreen(futsalDetail: futsal),
//                               ),
//                             );
//                           },
//                           child: Container(
//                             padding: const EdgeInsets.all(10),
//                             decoration: BoxDecoration(
//                               border: Border.all(color: Colors.grey.shade300),
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             child: Row(
//                               children: [
//                                 // Image section
//                                 ClipRRect(
//                                   borderRadius: BorderRadius.circular(8),
//                                   child: Image.network(
//                                     futsal.imageUrl,
//                                     height: 100,
//                                     width: 100,
//                                     fit: BoxFit.cover,
//                                     errorBuilder:
//                                         (context, error, stackTrace) =>
//                                             Container(
//                                               height: 100,
//                                               width: 100,
//                                               color: Colors.grey[200],
//                                               child: const Icon(
//                                                 Icons.broken_image,
//                                                 size: 40,
//                                                 color: Colors.grey,
//                                               ),
//                                             ),
//                                   ),
//                                 ),
//                                 const SizedBox(width: 12),
//                                 // Info section
//                                 Expanded(
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         futsal.name,
//                                         style: const TextStyle(
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                       const SizedBox(height: 4),
//                                       Text(
//                                         "Address: ${futsal.address}, ${futsal.city}",
//                                         style: const TextStyle(
//                                           color: Colors.grey,
//                                         ),
//                                       ),
//                                       const SizedBox(height: 4),
//                                       Text(
//                                         "Price: Rs. ${futsal.pricePerHour}/hr",
//                                         style: const TextStyle(
//                                           color: Colors.black87,
//                                         ),
//                                       ),
//                                       const SizedBox(height: 4),
//                                       Text(
//                                         "Hours: ${futsal.startTime} - ${futsal.endTime}",
//                                         style: const TextStyle(
//                                           color: Colors.black54,
//                                         ),
//                                       ),
//                                       Text(
//                                         "Distance: ${futsalRef.getDistanceForFutsal(futsal)}",
//                                         style: TextStyle(
//                                           color: Colors.blue[700],
//                                           fontWeight: FontWeight.w500,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:futsalmate/common/colors.dart';
import 'package:futsalmate/features/booking/controller/booking_controller.dart';
import 'package:futsalmate/features/booking/model/futsal_detail_item_model.dart';
import 'package:futsalmate/features/booking/view/screens/futsal_detail_screen.dart';
import 'dart:developer' as logger;

class BookingScreen extends ConsumerStatefulWidget {
  const BookingScreen({super.key});

  @override
  ConsumerState<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends ConsumerState<BookingScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<FutsalDetailItemModel> _filteredFutsals = [];
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      final futsalRefR = ref.read(futsalDetailController);
      await futsalRefR.fetchFutsalDetails();
    });
  }

  void _filterFutsals(String query, List<FutsalDetailItemModel> allFutsals) {
    if (query.isEmpty) {
      setState(() {
        _filteredFutsals = allFutsals;
      });
    } else {
      final filtered = allFutsals
          .where(
            (futsal) => futsal.name.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
      setState(() {
        _filteredFutsals = filtered;
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final futsalRef = ref.watch(futsalDetailController);

    // Initialize filtered list only once when data is loaded
    if (!_isInitialized &&
        !futsalRef.isFetchFutsalLoading &&
        futsalRef.futsalDetails.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          _filteredFutsals = futsalRef.futsalDetails;
          _isInitialized = true;
        });
      });
    }

    // Get the current list to display
    final List<FutsalDetailItemModel> displayList =
        _searchController.text.isEmpty
        ? futsalRef.futsalDetails
        : _filteredFutsals;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Book Futsal", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: CommonColors.primaryColor,
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: "Search futsals by name...",
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 16,
                  ),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear, color: Colors.grey),
                          onPressed: () {
                            _searchController.clear();
                            _filterFutsals('', futsalRef.futsalDetails);
                          },
                        )
                      : null,
                ),
                onChanged: (value) {
                  _filterFutsals(value, futsalRef.futsalDetails);
                },
              ),
            ),
          ),

          // Results count
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _searchController.text.isEmpty
                      ? "All futsals (${futsalRef.futsalDetails.length})"
                      : "Found ${_filteredFutsals.length} futsal${_filteredFutsals.length != 1 ? 's' : ''}",
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
                if (_searchController.text.isNotEmpty)
                  TextButton(
                    onPressed: () {
                      _searchController.clear();
                      _filterFutsals('', futsalRef.futsalDetails);
                    },
                    child: Text(
                      "Clear",
                      style: TextStyle(color: CommonColors.primaryColor),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // Futsals List
          Expanded(
            child: futsalRef.isFetchFutsalLoading
                ? Center(
                    child: CircularProgressIndicator(
                      color: CommonColors.primaryColor,
                    ),
                  )
                : displayList.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _searchController.text.isEmpty
                              ? Icons.sports_soccer
                              : Icons.search_off,
                          size: 80,
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          _searchController.text.isEmpty
                              ? "No futsals available"
                              : "No futsals found for '${_searchController.text}'",
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        if (_searchController.text.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: TextButton(
                              onPressed: () {
                                _searchController.clear();
                                _filterFutsals('', futsalRef.futsalDetails);
                              },
                              child: Text(
                                "Clear search",
                                style: TextStyle(
                                  color: CommonColors.primaryColor,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: displayList.length,
                    itemBuilder: (context, index) {
                      final futsal = displayList[index];

                      return Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 8,
                        ),
                        child: InkWell(
                          onTap: () {
                            logger.log("futsal detail: $futsal");
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) =>
                                    FutsalDetailScreen(futsalDetail: futsal),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                              border: Border.all(
                                color: Colors.grey.withOpacity(0.3),
                              ),
                            ),
                            child: Row(
                              children: [
                                // Image section
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(
                                    futsal.imageUrl,
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            Container(
                                              height: 100,
                                              width: 100,
                                              color: Colors.grey[200],
                                              child: const Icon(
                                                Icons.sports_soccer,
                                                size: 40,
                                                color: Colors.grey,
                                              ),
                                            ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                // Info section
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        futsal.name,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.location_on,
                                            size: 14,
                                            color: Colors.grey[600],
                                          ),
                                          const SizedBox(width: 4),
                                          Expanded(
                                            child: Text(
                                              "${futsal.address}, ${futsal.city}",
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey[600],
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.access_time,
                                            size: 14,
                                            color: Colors.grey[600],
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            "${futsal.startTime} - ${futsal.endTime}",
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey[600],
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        spacing: 5,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8,
                                              vertical: 4,
                                            ),
                                            decoration: BoxDecoration(
                                              color: CommonColors.primaryColor
                                                  .withOpacity(0.1),
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                            ),
                                            child: Text(
                                              "Rs. ${futsal.pricePerHour}/hr",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color:
                                                    CommonColors.primaryColor,
                                              ),
                                            ),
                                          ),
                                          Flexible(
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 8,
                                                    vertical: 4,
                                                  ),
                                              decoration: BoxDecoration(
                                                color: Colors.blue[50],
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                              ),
                                              child: Text(
                                                futsalRef.getDistanceForFutsal(
                                                  futsal,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.blue[700],
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
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
