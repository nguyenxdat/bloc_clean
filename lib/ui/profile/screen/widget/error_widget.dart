import 'package:flutter/material.dart';

class ErrorWidget extends StatelessWidget {
  final Function()? tryAgainPressed;
  const ErrorWidget({
    Key? key,
    this.tryAgainPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Error when request'),
          if (tryAgainPressed != null)
            TextButton(
                onPressed: tryAgainPressed, child: const Text('Try again'))
          else
            const SizedBox.shrink(),
        ],
      ),
    );
  }
}
