import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:xlo_mobx/components/custom_drawer/custom_drawer.dart';
import 'package:xlo_mobx/stores/create_store.dart';

import 'components/category_field.dart';
import 'components/cep_field.dart';
import 'components/images_field.dart';

class CreateScreen extends StatelessWidget {
  const CreateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CreateStore createStore = GetIt.I<CreateStore>();
    const labelStyle = TextStyle(
      fontWeight: FontWeight.w800,
      color: Colors.grey,
      fontSize: 18,
    );

    const contentPadding = EdgeInsets.fromLTRB(16, 10, 12, 10);
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Criar anuncio'),
      ),
      body: Card(
        clipBehavior: Clip.antiAlias,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 8,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ImagesField(
              createStore: createStore,
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Título *',
                labelStyle: labelStyle,
                contentPadding: contentPadding,
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Descrição *',
                labelStyle: labelStyle,
                contentPadding: contentPadding,
              ),
              maxLines: null,
            ),
            CategoryField(createStore: createStore),
            CepField(),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Preço *',
                labelStyle: labelStyle,
                contentPadding: contentPadding,
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                RealInputFormatter(moeda: true),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
