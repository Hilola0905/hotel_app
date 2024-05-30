class UserModel{
  final String card;
  final String birthday;
  final String fullName;
  final String gender;
  final String imageUrl;
  final String phoneNumber;
  final String authId;
  final String email;
  final String role;
  final String refreshToken;

  UserModel({
    required this.card,
    required this.phoneNumber,
    required this.gender,
    required this.birthday,
    required this.fullName,
    required this.authId,
    required this.email,
    required this.imageUrl,
    required this.role,
    required this.refreshToken
});


  UserModel copyWith({
    String? phoneNumber,
    String? imageUrl,
    String? authId,
    String? birthday,
    String? card,
    String? fullName,
    String? gender,
    String? email,
    String? refreshToken,
    String? role,

  }) {
    return UserModel(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      authId: authId ?? this.authId,
      card: card ?? this.card,
      gender: gender ?? this.gender,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      birthday: birthday ?? this.birthday,
      imageUrl: imageUrl ?? this.imageUrl,
      role: role ?? this.role,
      refreshToken: refreshToken ?? this.role,
    );
  }
  factory UserModel.fromJson(Map<String,dynamic> json){
    return UserModel(
      card: json["card"] as String? ?? "",
      phoneNumber: json["phone_num"] as String? ?? "",
      gender: json["gender"] as String? ?? "",
      fullName: json["full_name"] as String? ?? "",
      authId: json["id"] as String? ?? "",
      email: json["email"] as String? ?? "",
      birthday: json["birthday"] as String? ?? "",
      imageUrl: json["image_url"] as String? ?? "",
      role: json["role"] as String? ?? "",
      refreshToken: json["refresh_token"] as String? ?? "",
    );
  }
  Map<String,dynamic> toJson(){
    return {
      "phone_num":phoneNumber,
      'card':card,
      "gender":gender,
      "full_name":fullName,
      "email":email,
      "birthday":birthday,
      "id":authId,
      "image_url":imageUrl,
      "role":role,
      "refresh_token":refreshToken,
    };
  }
  
}

