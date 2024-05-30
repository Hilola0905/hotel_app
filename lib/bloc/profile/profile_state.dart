
import 'package:equatable/equatable.dart';
import 'package:hotel_app/data/model/user/user_model.dart';
import '../../data/model/response/form_status.dart';


class ProfileState extends Equatable {

  final  FormsStatus formsStatus;
  final String? errorMessage;
  final String? statusMessage;
  final UserModel? user;

  const ProfileState({
    required this.errorMessage,
    required this.formsStatus,
    required this.statusMessage,
    required this.user
  });
  ProfileState copyWidth(
      FormsStatus? formsStatus,
      String? errorMessage,
      String? statusMessage,
      UserModel? user,
      ){
    return ProfileState(
      errorMessage: errorMessage ?? this.errorMessage,
      formsStatus: formsStatus ?? this.formsStatus,
      statusMessage: statusMessage ?? this.statusMessage,
      user:  user ?? this.user,
    );
  }
  @override
  // TODO: implement props
  List<Object?> get props => [
    statusMessage,
    errorMessage,
    formsStatus,
    user
  ];

}


