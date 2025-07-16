import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:futsalmate/features/dashboard/data/location_model.dart';

final locationController = ChangeNotifierProvider<LocationModel>((ref) {
  return LocationModel();
});
