import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ide/model/model_data.dart';
import 'package:ide/core/services/services.dart';

part 'fetch_state.dart';

class FetchCubit extends Cubit<FetchState> {
  FetchCubit() : super(FetchInitial());
  ServicesAPI _servicesAPI = ServicesAPI();

  void fetchData() async {
    emit(FetchLoading());
    try {
      final res = await _servicesAPI.fetchData();
      if (res != null) {
        emit(FetchSuccess(modelData: res));
      } else {
        emit(FetchFailed());
      }
    } catch (e) {
      emit(FetchFailed());
    }
  }
}
