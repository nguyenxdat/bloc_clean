import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/profile_bloc.dart';
import '../../screen/widget/error_widget.dart' as error;

class BodyProfile extends StatefulWidget {
  const BodyProfile({Key? key}) : super(key: key);

  @override
  State<BodyProfile> createState() => _BodyProfileState();
}

class _BodyProfileState extends State<BodyProfile> {
  @override
  void initState() {
    super.initState();
    _getProfile();
  }

  void _getProfile() {
    context.read<ProfileBloc>().add(GetProfileEvent());
  }

  void _handleListener(BuildContext context, ProfileState state) {
    if (state is LoadingState) {
      //** Show Loading */
    }
    if (state is GetProfileSuccessState) {
      //** Receive Data and rebuild Widget */
    }
    if (state is RequestApiFailureState) {
      //** show Toast error message */
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: _handleListener,
      builder: (context, state) {
        if (state is RequestApiFailureState) {
          return error.ErrorWidget(
            tryAgainPressed: _getProfile,
          );
        }
        return const Center(child: Text('Profile screen'));
      },
    );
  }
}
