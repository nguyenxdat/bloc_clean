import 'package:flutter_application_bloc_clean/network/api_provider.dart';
import 'package:flutter_application_bloc_clean/network/profile.dart';
import 'package:injectable/injectable.dart';

import '../../../network/network.dart';
import 'profile_repository.dart';

@Injectable(as: ProfileRepository)
class ImplProfileRepository extends ProfileRepository {
  final ApiProvider _apiProvider;

  ImplProfileRepository(this._apiProvider);
  @override
  Future<Profile> getProfile() async {
    final response = await _apiProvider.get(Enpoints.getProfile);
    return Profile.fromMap(response);
  }
}
