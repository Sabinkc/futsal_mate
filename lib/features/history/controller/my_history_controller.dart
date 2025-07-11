import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:futsalmate/features/history/model/my_posts_model.dart';

final myPostController = ChangeNotifierProvider<MyPostsModel>((ref) {
  return MyPostsModel();
});
