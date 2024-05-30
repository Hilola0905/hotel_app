
import 'package:equatable/equatable.dart';
import 'package:hotel_app/data/model/user/user_model.dart';
import '../../data/model/response/form_status.dart';


class AuthState extends Equatable {

  final  FormsStatus formsStatus;
  final String errorMessage;
  final String statusMessage;
  final UserModel? userModel;

  const AuthState({
    required this.errorMessage,
    required this.formsStatus,
    required this.statusMessage,
    required this.userModel
  });
  AuthState copyWidth(
      FormsStatus? formsStatus,
      String? errorMessage,
      String? statusMessage,
      UserModel? userModel,
      ){
    return AuthState(
      errorMessage: errorMessage ?? this.errorMessage,
      formsStatus: formsStatus ?? this.formsStatus,
      statusMessage: statusMessage ?? this.statusMessage,
      userModel: userModel ?? this.userModel,
    );
  }
  @override
  // TODO: implement props
  List<Object?> get props => [
    statusMessage,
    errorMessage,
    formsStatus,
    userModel
  ];

}

