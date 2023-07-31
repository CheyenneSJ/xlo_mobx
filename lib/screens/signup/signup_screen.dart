import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xlo_mobx/screens/signup/components/field_title.dart';
import 'package:xlo_mobx/stores/signup_store.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../components/error_box.dart';

part 'signup_screen.g.dart';

class SignupScreen = _SignupScreen with _$SignupScreen;

abstract class _SignupScreen with Store {}

class SignUpScreen extends StatelessWidget {
  final SignupStore signupStore = SignupStore();

  SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro'),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 32),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Observer(builder: (_) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: ErrorBox(
                          message: signupStore.error,
                        ),
                      );
                    }),
                    const FieldTitle(
                      title: 'Apelido  ',
                      subtitle: 'Como aparecerá em seus anúncios',
                    ),
                    Observer(builder: (_) {
                      return TextField(
                        enabled: !signupStore.loading,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: 'Exemplo: João S.',
                          isDense: true,
                          errorText: signupStore.nameError,
                        ),
                        onChanged: signupStore.setName,
                      );
                    }),
                    const SizedBox(height: 16),
                    const FieldTitle(
                      title: 'E-mail  ',
                      subtitle: 'Enviaremos um e-mail de confirmação',
                    ),
                    Observer(builder: (_) {
                      {
                        return TextField(
                          enabled: !signupStore.loading,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            hintText: 'Exemplo: joao@gmail.com',
                            isDense: true,
                            errorText: signupStore.emailError,
                          ),
                          onChanged: signupStore.setEmail,
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                        );
                      }
                    }),
                    const SizedBox(height: 16),
                    const FieldTitle(
                      title: 'Celular  ',
                      subtitle: 'Proteja sua conta',
                    ),
                    Observer(builder: (_) {
                      return TextField(
                        enabled: !signupStore.loading,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: '(99) 99999-9999',
                          isDense: true,
                          errorText: signupStore.phoneError,
                        ),
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          TelefoneInputFormatter(),
                        ],
                        onChanged: signupStore.setPhone,
                      );
                    }),
                    const SizedBox(height: 16),
                    const FieldTitle(
                      title: 'Senha  ',
                      subtitle: 'Use letras, números e caracteres especiais',
                    ),
                    Observer(builder: (_) {
                      return TextField(
                        enabled: !signupStore.loading,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          isDense: true,
                          errorText: signupStore.pass1Error,
                        ),
                        onChanged: signupStore.setPass1,
                      );
                    }),
                    const SizedBox(height: 16),
                    const FieldTitle(
                      title: 'Confirmar senha   ',
                      subtitle: 'Repita a senha',
                    ),
                    Observer(builder: (_) {
                      return TextField(
                        enabled: !signupStore.loading,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          isDense: true,
                          errorText: signupStore.pass2Error,
                        ),
                        onChanged: signupStore.setPass2,
                      );
                    }),
                    Observer(builder: (_) {
                      return Container(
                        height: 40,
                        margin: const EdgeInsets.only(top: 20, bottom: 12),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            backgroundColor: Colors.orangeAccent,
                          ),
                          onPressed: signupStore.signUpPressedEnable
                              ? signupStore.signUp
                              : null,
                          child: signupStore.loading
                              ? const CircularProgressIndicator()
                              : const Text('Cadastrar'),
                        ),
                      );
                    }),
                    const Divider(
                      color: Colors.black87,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Já tem uma conta?',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              'Entrar',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.purple,
                                fontSize: 16,
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
