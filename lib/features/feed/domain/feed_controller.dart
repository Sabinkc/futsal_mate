import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:futsalmate/features/feed/data/feed_model.dart';
import 'package:futsalmate/features/feed/data/post_widget_model.dart';

final feedController = ChangeNotifierProvider<FeedModel>((ref) {
  return FeedModel();
});

final postController = ChangeNotifierProvider<PostWidgetModel>((ref) {
  return PostWidgetModel();
});
