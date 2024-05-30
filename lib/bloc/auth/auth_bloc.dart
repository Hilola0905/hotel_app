import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_app/data/model/response/form_status.dart';
import 'package:hotel_app/data/model/user/user_model.dart';
import 'package:hotel_app/data/network/api_provider.dart';
import '../../data/model/response/network_response.dart';
import 'auth_event.dart';
import 'auth_state.dart';



class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() :
        super(
         const  AuthState(
             errorMessage: "", statusMessage: "",
             formsStatus: FormsStatus.pure,userModel: null
          )) {
    on<VerifyRegisterEvent>(_registerVerify);
    on<CheckedInitialEvent>(_checkedAuth);
    on<UnVerifyRegisterEvent>(_registerUnVerify);
    on<LoginEvent>(_login);
    on<LogOutEvent>(_logOut);
  }

  _checkedAuth(CheckedInitialEvent event,  emit ){
    emit(
      state.copyWidth(FormsStatus.unauthenticated,"", "",null)
    );
  }
  _login(LoginEvent event,  emit ) async {
    emit(state.copyWidth(FormsStatus.loading,"","",null));
    NetworkResponse networkResponse= await ApiProvider.login(email: event.email, password: event.password);
    if(networkResponse.errorText.isEmpty){
      emit(state.copyWidth(FormsStatus.authenticated, "", networkResponse.data.toString(),
          UserModel.fromJson(networkResponse.data))
      );
    } else{
      emit(
          state.copyWidth(
              FormsStatus.error, networkResponse.errorText, networkResponse.errorText,null)
      );
    }

  }
  _logOut(LogOutEvent event,  emit ) async {}
  _registerVerify(VerifyRegisterEvent event,  emit ) async {
    emit(state.copyWidth(FormsStatus.loading,"","",null));
    NetworkResponse networkResponse= await ApiProvider.registerForVerify(
        email: event.email,
        password: event.sendEmailPassword,
    );
    if(networkResponse.errorCode=="400"){
      emit(state.copyWidth(FormsStatus.verifyError, "Siz passwordni xato kiritingiz", "",null));
    }
    if(networkResponse.errorText==""){
      emit(
          state.copyWidth(
            FormsStatus.authenticated,
            "",
            networkResponse.data.toString(),
            UserModel.fromJson(networkResponse.data),
          )

      );
    } else{
      emit(
          state.copyWidth(
              FormsStatus.error, networkResponse.errorText, networkResponse.errorText,null)
      );
    }
  }
  _registerUnVerify(UnVerifyRegisterEvent event,  emit ) async {
    emit(state.copyWidth(FormsStatus.loading,"","",null));
    NetworkResponse networkResponse= await ApiProvider.registerOneMethod(
        email: event.email,
        password: event.password,
        fullName: event.fullName
    );
    if(networkResponse.errorCode=="409"){
      emit(state.copyWidth(FormsStatus.error, "email allaqachon registratsiya bo'lgan", "",null));
    }
    if(networkResponse.errorText==""){
      emit(
          state.copyWidth(
            FormsStatus.unVerify,
            "",
            networkResponse.data.toString(),null,
          )

      );
    } else{
      emit(
          state.copyWidth(
              FormsStatus.error, networkResponse.errorText, networkResponse.errorText,null)
      );
    }
  }
}
