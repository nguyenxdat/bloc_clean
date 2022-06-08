import 'package:flutter/material.dart';

import '../ui/main/main_screen.dart';

class RouteConstants {
  static const String root = '/';

  static Map<String, WidgetBuilder> routes = {
    RouteConstants.root: (_) => MainScreen(),
  };
}
