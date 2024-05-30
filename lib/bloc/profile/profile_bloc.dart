import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_app/bloc/profile/profile_event.dart';
import 'package:hotel_app/bloc/profile/profile_state.dart';
import 'package:hotel_app/data/model/response/form_status.dart';
import '../../data/model/response/network_response.dart';
import '../../data/model/user/user_model.dart';
import '../../data/network/api_provider.dart';




class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() :
        super(
          const  ProfileState(
               errorMessage: "",
               formsStatus: FormsStatus.pure,
               statusMessage: "",
               user: null,

          )) {
    on<UpdateUserProfileEvent>(_update);
    on<CreateUserProfileEvent>(_create);
    on<GetUserProfileEvent>(_getUser);

  }

  _create(CreateUserProfileEvent event,  emit ){

  }
  _getUser(GetUserProfileEvent event,  emit )async {
    emit(state.copyWidth(FormsStatus.loading,"","",null));
    NetworkResponse networkResponse= await ApiProvider.getUserByToken();
    if(networkResponse.errorText.isEmpty){
      UserModel user=UserModel.fromJson(networkResponse.data);
      emit(state.copyWidth(
          FormsStatus.authenticated, "", networkResponse.data.toString(),
          user),
      );
    } else{
      emit(
          state.copyWidth(
              FormsStatus.error, networkResponse.errorText, networkResponse.errorText,null)
      );
    }
  }
  _update(UpdateUserProfileEvent event,  emit ) async {
    emit(state.copyWidth(FormsStatus.loading,"","",null));
    NetworkResponse networkResponse= await ApiProvider.updateProfile(
        card: event.card,
        dateOfBirth: event.dateOfBirth,
        email: event.email,
        fullName: event.fullName,
        gender: event.gender,
        password: event.password,
        phoneNumber:event.phoneNumber,
    );
    print(networkResponse.errorCode);
      UserModel user=UserModel.fromJson(networkResponse.data);
      print(user);
      emit(state.copyWidth(
          FormsStatus.success, "", networkResponse.data.toString(),
          user),
      );
  }

}
