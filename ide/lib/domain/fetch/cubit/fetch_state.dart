part of 'fetch_cubit.dart';

sealed class FetchState extends Equatable {
  const FetchState();

  @override
  List<Object> get props => [];
}

final class FetchInitial extends FetchState {}

final class FetchLoading extends FetchState {}

final class FetchSuccess extends FetchState {
  final List<ModelData> modelData;
  const FetchSuccess({required this.modelData});
  @override
  List<Object> get props => [];
}

final class FetchFailed extends FetchState {}
