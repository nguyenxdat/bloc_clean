import 'package:flutter/material.dart';

import '../../route/route.dart';
import '../../services/navigation_services.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Home Screen'),
          TextButton(
              onPressed: () =>
                  navService.pushNamed(RouteConstants.detailScreen),
              child: const Text('Open detail')),
        ],
      )),
    );
  }
}
