import 'package:flutter/material.dart';

class FieldTitle extends StatelessWidget {
  final String title;
  final String subtitle;

  const FieldTitle({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 2, bottom: 4),
      child: Wrap(crossAxisAlignment: WrapCrossAlignment.end, children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.grey[800],
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          subtitle,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        )
      ]),
    );
  }
}
