import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../di/injection.dart';
import '../bloc/profile_bloc.dart';
import 'widget/body.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: BlocProvider(
        create: (context) => getIt<ProfileBloc>(),
        child: const BodyProfile(),
      ),
    );
  }
}

