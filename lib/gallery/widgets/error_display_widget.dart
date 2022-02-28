import 'package:flutter/material.dart';
import '../../config/config.dart';

class ErrorDisplayWidget extends StatelessWidget {
  final String errorMessage;
  const ErrorDisplayWidget({required this.errorMessage, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(Insets.medium),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(
              Icons.warning_amber_rounded,
              color: InfiniteColors.pink,
              size: 30,
            ),
            Text(errorMessage,
                textAlign: TextAlign.center, style: InfiniteTextStyles.error),
          ],
        ));
  }
}
