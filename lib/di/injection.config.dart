// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../network/network.dart' as _i3;
import '../ui/profile/bloc/profile_bloc.dart' as _i6;
import '../ui/profile/repository/impl_profile_repository.dart' as _i5;
import '../ui/profile/repository/profile_repository.dart' as _i4;
import 'app_module.dart' as _i7; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final appModule = _$AppModule();
  gh.singleton<_i3.ApiProvider>(appModule.apiProvider);
  gh.factory<_i4.ProfileRepository>(
      () => _i5.ImplProfileRepository(get<_i3.ApiProvider>()));
  gh.factory<_i6.ProfileBloc>(
      () => _i6.ProfileBloc(get<_i4.ProfileRepository>()));
  return get;
}

class _$AppModule extends _i7.AppModule {}
