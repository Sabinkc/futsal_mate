class PostItemModel {
  final String uid;
  final String postedBy;
  final String gameTime;
  final String type;
  final String noOfPlayers;
  final String futsalName;
  final String location;
  final String contactNo;
  final String skillLevel;
  final String position;

  const PostItemModel({
    required this.uid,
    required this.postedBy,
    required this.gameTime,
    required this.type,
    required this.noOfPlayers,
    required this.futsalName,
    required this.location,
    required this.contactNo,
    required this.skillLevel,
    required this.position,
  });

  @override
  String toString() {
    return 'PostItemModel('
        'uid: $uid, '
        'postedBy: $postedBy, '
        'gameTime: $gameTime, '
        'type: $type, '
        'noOfPlayers: $noOfPlayers, '
        'futsalName: $futsalName, '
        'location: $location, '
        'contactNo: $contactNo, '
        'skillLevel: $skillLevel, '
        'position: $position'
        ')';
  }
}
