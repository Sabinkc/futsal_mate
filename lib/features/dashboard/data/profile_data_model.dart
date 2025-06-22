class ProfileDataModel {
  final String userName;
  final String phone;
  final String age;
  final String address;
  final String position;
  final String skillLevel;

  ProfileDataModel({
    required this.userName,
    required this.phone,
    required this.age,
    required this.address,
    required this.position,
    required this.skillLevel,
  });

  @override
  String toString() {
    return 'ProfileDataModel(userName: $userName, phone: $phone, age: $age, address: $address, position: $position, skillLevel: $skillLevel)';
  }
}
