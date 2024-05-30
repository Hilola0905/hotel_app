
import 'package:equatable/equatable.dart';



abstract class AuthEvent extends Equatable {}

class UnVerifyRegisterEvent extends AuthEvent{
  final String email;
  final String password;
  final String fullName;
  UnVerifyRegisterEvent(this.password,this.fullName,this.email);
  @override
  List<Object?> get props => [
    password.hashCode,
    fullName.hashCode,
    email.hashCode
  ];
}
class VerifyRegisterEvent extends AuthEvent{
  final String email;
  final String sendEmailPassword;
  VerifyRegisterEvent(this.email,this.sendEmailPassword);
  @override
  List<Object?> get props => [
    email.hashCode,
  ];
}
class LoginEvent extends AuthEvent{

  final String email;
  final String password;
  LoginEvent(this.email, this.password);

  @override
  List<Object?> get props => [
    email.hashCode,
    password.hashCode
  ];


}
class LogOutEvent extends AuthEvent{
  LogOutEvent();
  @override
  List<Object?> get props => [];
}
class CheckedInitialEvent extends AuthEvent{
  @override
  List<Object?> get props => [];
}

