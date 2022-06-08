import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_bloc_clean/network/profile.dart';
import 'package:flutter_application_bloc_clean/ui/profile/repository/profile_repository.dart';
import 'package:injectable/injectable.dart';

part 'profile_event.dart';
part 'profile_state.dart';

@injectable
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository _profileRepository;

  ProfileBloc(this._profileRepository) : super(ProfileInitial()) {
    on<GetProfileEvent>(_mapGetProfileEvent);
  }

  void _mapGetProfileEvent(
    GetProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(LoadingState());
    try {
      final response = await _profileRepository.getProfile();
      emit(GetProfileSuccessState(response));
    } on Exception catch (e) {
      emit(RequestApiFailureState(e));
    }
  }
}
