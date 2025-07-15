import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:futsalmate/features/booking/model/futsal_detail_model.dart';

final futsalDetailController = ChangeNotifierProvider<FutsalDetailModel>((ref) {
  return FutsalDetailModel();
});
