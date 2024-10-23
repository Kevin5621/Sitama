import 'package:sistem_magang/common/widgets/profil%20header/model.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final UserProfile profile;

  ProfileLoaded(this.profile);
}

class ProfileUploading extends ProfileState {
  final UserProfile currentProfile;

  ProfileUploading(this.currentProfile);
}

class ProfileError extends ProfileState {
  final String message;

  ProfileError(this.message);
}