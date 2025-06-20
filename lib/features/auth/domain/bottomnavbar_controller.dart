import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:futsalmate/features/auth/data/bottomnavbar_provider_model.dart';

final navBarProvider = ChangeNotifierProvider<BottomnavbarProviderModel>((ref) {
  return BottomnavbarProviderModel();
});
