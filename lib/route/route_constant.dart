import 'package:flutter/material.dart';

import '../ui/detail/detail_screen.dart';
import '../ui/main/main_screen.dart';

class RouteConstants {
  static const String root = '/';
  static const String detailScreen = '/detail_screen';

  static Map<String, WidgetBuilder> routes = {
    RouteConstants.root: (_) => MainScreen(),
    RouteConstants.detailScreen: (_) => const DetailScreen(),
  };
}
