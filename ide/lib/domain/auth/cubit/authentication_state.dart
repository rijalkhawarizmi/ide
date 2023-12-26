part of 'authentication_cubit.dart';

sealed class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

final class AuthenticationInitial extends AuthenticationState {}

final class AuthenticationLoading extends AuthenticationState {}

final class AuthenticationSuccess extends AuthenticationState {
final String message;

const AuthenticationSuccess(this.message);

  @override
  List<Object> get props => [message];
}

final class AuthenticationFailed extends AuthenticationState {
  final String message;

  const AuthenticationFailed({required this.message});

  @override
  List<Object> get props => [message];
}
