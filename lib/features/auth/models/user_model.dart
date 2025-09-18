class UserModel {
  final String id ; 
  final String name ; 
  final String phoneNumber;
  final String email;
  final String? pictureUrl;

  const UserModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.pictureUrl,
    required this.email
  });

  factory UserModel.fromJson(Map<String , dynamic> json){
    return UserModel(
      id: json['id'] ?? "", 
      name: json['name'] ?? "",
      phoneNumber: json['phone_number'] ?? "",
      pictureUrl: json['picture_url'] ,
      email : json['email'] ?? "",
      );
  }
}