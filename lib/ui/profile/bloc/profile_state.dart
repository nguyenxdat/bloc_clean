part of 'profile_bloc.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class LoadingState extends ProfileState {}

class GetProfileSuccessState extends ProfileState {
  final Profile model;

  GetProfileSuccessState(this.model);
}

class RequestApiFailureState extends ProfileState {
  final Exception e;

  RequestApiFailureState(this.e);
}
