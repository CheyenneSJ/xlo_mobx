import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:xlo_mobx/screens/create/components/image_source_modal.dart';

import '../../../stores/create_store.dart';
import 'image_dialog.dart';

class ImagesField extends StatelessWidget {
  final CreateStore createStore;

  const ImagesField({
    required this.createStore,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    void onImageSelected(CroppedFile image) {
      createStore.images.add(image);
      Navigator.of(context).pop();
    }

    return Container(
      color: Colors.grey[200],
      height: 120,
      child: Observer(builder: (_) {
        return ListView.builder(
          itemCount:
              createStore.images.length < 5 ? createStore.images.length + 1 : 5,
          itemBuilder: (_, index) {
            if (index == createStore.images.length) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(
                  8,
                  16,
                  0,
                  16,
                  //index == 4 ? 8 : 0,
                ),
                child: GestureDetector(
                  onTap: () {
                    if (Platform.isAndroid) {
                      showModalBottomSheet(
                        context: context,
                        builder: (_) => ImageSourceModal(onImageSelected),
                      );
                    } else {
                      showCupertinoModalPopup(
                        context: context,
                        builder: (context) => ImageSourceModal(onImageSelected),
                      );
                    }
                  },
                  child: CircleAvatar(
                    radius: 44,
                    backgroundColor: Colors.grey[300],
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.camera_alt_outlined,
                          size: 30,
                          color: Colors.white,
                        ),
                        Text(
                          '+',
                          style: TextStyle(color: Colors.white, fontSize: 28),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (_) => ImageDialog(
                              image: createStore.images[index],
                              onDelete: () =>
                                  createStore.images.removeAt(index),
                            ));
                  },
                  child: CircleAvatar(
                    radius: 44,
                    backgroundColor: Colors.grey[300],
                    backgroundImage: FileImage(
                      createStore.images[index],
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '+',
                          style: TextStyle(color: Colors.white, fontSize: 28),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          },
          scrollDirection: Axis.horizontal,
        );
      }),
    );
  }
}
