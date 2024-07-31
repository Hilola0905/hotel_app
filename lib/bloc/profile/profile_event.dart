
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:hotel_app/data/model/user/user_model.dart';



abstract class ProfileEvent extends Equatable {}


class CreateUserProfileEvent extends ProfileEvent{
  final UserModel userModel;
  CreateUserProfileEvent(this.userModel);
  @override
  List<Object?> get props => [
    userModel.hashCode,
  ];
}
class GetUserProfileEvent extends ProfileEvent{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class UpdateImageProfileEvent extends ProfileEvent{
  final File imageFile;
  UpdateImageProfileEvent({
    required this.imageFile
});
  @override
  // TODO: implement props
  List<Object?> get props => [
    imageFile.hashCode
  ];
}
class UpdateUserProfileEvent extends ProfileEvent{
  final String? card;
  final String? dateOfBirth;
  final String? fullName;
  final String? gender;
  final String? password;
  final String? phoneNumber;
  final String? email;
  UpdateUserProfileEvent({
    this.password,
    this.fullName,
    this.dateOfBirth,
    this.gender,
    this.card,
    this.phoneNumber,
    this.email,
});

  @override
  List<Object?> get props => [
    email.hashCode,
    password.hashCode,
    fullName.hashCode,
    dateOfBirth.hashCode,
    gender.hashCode,
    card.hashCode,
    phoneNumber.hashCode,
  ];
}


