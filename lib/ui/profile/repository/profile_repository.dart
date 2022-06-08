import '../../../network/profile.dart';

abstract class ProfileRepository {
  Future<Profile> getProfile();
}
