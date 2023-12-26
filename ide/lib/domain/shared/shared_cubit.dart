import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../external/share.dart';
import '../../model/user_model.dart';

part 'shared_state.dart';

class SharedCubit extends Cubit<SharedState> {
  SharedCubit() : super(SharedInitial());
  void checkIsUserLoggin() async {
    try {
      UserModel? userModelnya = await Shared.getShared();
      if (userModelnya != null) {
        emit(LoggeIn(userModelnya));
      } else {
        emit(NotLoggeIn());
      }
    } catch (e) {
      emit(NotLoggeIn());
    }
  }
  }
