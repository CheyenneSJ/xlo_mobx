import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageSourceModal extends StatelessWidget {
  final Function(CroppedFile) onImageSelected;
  const ImageSourceModal(this.onImageSelected);

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return BottomSheet(
        onClosing: () {},
        builder: (_) => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextButton(
              onPressed: getFromCamera,
              child: const Text('Câmera'),
            ),
            TextButton(
              onPressed: getFromGallery,
              child: const Text('Galeria'),
            ),
          ],
        ),
      );
    } else {
      return CupertinoActionSheet(
        title: const Text('Selecionar foto para o anuncio'),
        message: const Text('Escolha a origem da foto'),
        cancelButton: CupertinoActionSheetAction(
          child: const Text(
            'Cancelar',
            style: TextStyle(color: Colors.red),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          CupertinoActionSheetAction(
            onPressed: getFromCamera,
            child: const Text('Câmera'),
          ),
          CupertinoActionSheetAction(
            onPressed: getFromGallery,
            child: const Text('Galeria'),
          ),
        ],
      );
    }
  }

  Future<void> getFromCamera() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile == null) {
      return imageSelected(File(pickedFile?.path ?? ''));
    }
  }

  Future<void> getFromGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile == null) {
      final image = File(pickedFile?.path ?? '');
      imageSelected(image);
    }
  }

  Future<void> imageSelected(File image) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: image.path,
      aspectRatio: const CropAspectRatio(
        ratioX: 1,
        ratioY: 1,
      ),
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Editar imagem',
          toolbarColor: Colors.purple,
          toolbarWidgetColor: Colors.white,
        ),
        IOSUiSettings(
          title: 'Editar imagem',
          cancelButtonTitle: 'Cancelar',
          doneButtonTitle: 'Concluir',
        )
      ],
    );
    if (croppedFile != null) onImageSelected(croppedFile!);
  }
}
