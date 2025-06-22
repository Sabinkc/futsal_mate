import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:futsalmate/features/dashboard/data/profile_provider_model.dart';

final profileProvider = ChangeNotifierProvider<ProfileProviderModel>((ref) {
  return ProfileProviderModel();
});
