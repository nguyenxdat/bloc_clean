import 'package:injectable/injectable.dart';

import '../network/network.dart';

@module
abstract class AppModule {
  @singleton
  ApiProvider get apiProvider => ApiProvider();
}