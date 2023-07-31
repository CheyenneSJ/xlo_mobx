import 'package:flutter/material.dart';

class ErrorBox extends StatelessWidget {
  final String message;
  const ErrorBox({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (message.isEmpty) return Container();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Colors.red,
        child: Row(
          children: [
            const Icon(
              Icons.error_outline,
              color: Colors.white,
              size: 40,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                'Ops! $message. Por Favor, tente novamente.',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
