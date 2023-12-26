import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ide/external/share.dart';
import 'package:ide/model/user_model.dart';
import 'package:ide/core/services/services.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationInitial());

  void login({required String email, required String password}) async {
    emit(AuthenticationLoading());
    ServicesAPI servicesAPI = ServicesAPI();

    try {
      final response = await servicesAPI.signIn(email, password);
      
      if (response!.statusCode == 200) {
        final responseToken = await servicesAPI.getToken(
            response.data["responseData"]["email"],
            password,
            response.data["responseData"]["client_id"],
            response.data["responseData"]["client_secret"]);
        if (responseToken?.statusCode == 200) {
          Shared.sharedPref(userModel: UserModel.fromJson(response.data["responseData"]), accessTokens: responseToken?.data["access_token"]);
          emit(AuthenticationSuccess(response.data["responseMessage"]));
        }
      } else {
        
        emit(AuthenticationFailed(message: response.data['responseMessage']));
      }
    } catch (e) {
      emit(AuthenticationFailed(message: e.toString()));
    }
  }
}
