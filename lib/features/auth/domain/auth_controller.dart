import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:futsalmate/features/auth/data/auth_provider_model.dart';

final authProvider = ChangeNotifierProvider<AuthProviderModel>((ref) {
  return AuthProviderModel();
});
