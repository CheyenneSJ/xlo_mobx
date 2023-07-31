import 'package:flutter/material.dart';

class ImageDialog extends StatelessWidget {
  final dynamic image;
  final VoidCallback onDelete;
  const ImageDialog({
    Key? key,
    this.image,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.file(image),
          FloatingActionButton(
              child: const Text('Excluir', style: TextStyle(color: Colors.red)),
              onPressed: () {
                Navigator.of(context).pop();
                onDelete();
              }),
        ],
      ),
    );
  }
}
