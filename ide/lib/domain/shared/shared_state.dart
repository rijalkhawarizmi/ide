part of 'shared_cubit.dart';

sealed class SharedState extends Equatable {
  const SharedState();

  @override
  List<Object> get props => [];
}

final class SharedInitial extends SharedState {}

class LoggeIn extends SharedState {
  final UserModel? userModel;
  const LoggeIn(this.userModel);
}
class NotLoggeIn extends SharedState {}
