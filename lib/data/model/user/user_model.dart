class UserModel{
  final String card;
  final String dateOfBirth;
  final String fullName;
  final String gender;
  final String password;
  final String phoneNumber;
  final String authId;

  UserModel({
    required this.card,
    required this.password,
    required this.phoneNumber,
    required this.gender,
    required this.dateOfBirth,
    required this.fullName,
    required this.authId,
});

 factory UserModel.fromJson(Map<String,dynamic> json){
   return UserModel(
       card: json["card"] as String? ?? "",
       password: "",
       phoneNumber: json["phone_number"] as String? ?? "",
       gender: json["gender"] as String? ?? "",
       dateOfBirth: json["date_of_birth"] as String? ?? "",
       fullName: json["full_name"] as String? ?? "",
       authId: json["id"] as String? ?? "",
   );
 }
  UserModel copyWith({
    String? phoneNumber,
    String? authId,
    String? password,
    String? dateOfBirth,
    String? card,
    String? fullName,
    String? gender,
  }) {
    return UserModel(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      authId: authId ?? this.authId,
      password: password ?? this.password,
      card: card ?? this.card,
      gender: gender ?? this.gender,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      fullName: fullName ?? this.fullName,
    );
  }
  
}

