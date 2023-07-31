import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo_mobx/components/error_box.dart';
import 'package:xlo_mobx/stores/login_store.dart';

import '../signup/signup_screen.dart';

class LoginScreen extends StatelessWidget {
  final LoginStore loginStore = LoginStore();
  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Entrar'),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 8,
              margin: const EdgeInsets.symmetric(horizontal: 32),
              child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Acessar com E-mail',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[900],
                        ),
                      ),
                      Observer(builder: (_) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: ErrorBox(message: loginStore.error ?? ''),
                        );
                      }),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 2, bottom: 4, top: 8),
                        child: Text(
                          'E-mail',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[800],
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Observer(builder: (_) {
                        return TextField(
                          enabled: !loginStore.loading,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            isDense: true,
                            errorText: loginStore.emailError,
                          ),
                          keyboardType: TextInputType.emailAddress,
                          onChanged: loginStore.setEmail,
                        );
                      }),
                      const SizedBox(
                        height: 16,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 2,
                          bottom: 4,
                        ),
                        child: Row(
                          children: [
                            Text(
                              'Senha',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[800],
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const Spacer(),
                            GestureDetector(
                              child: const Text(
                                'Esqueceu sua senha',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.purple,
                                ),
                              ),
                              onTap: () {},
                            ),
                          ],
                        ),
                      ),
                      Observer(builder: (_) {
                        return TextField(
                          enabled: !loginStore.loading,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            isDense: true,
                            errorText: loginStore.emailError,
                          ),
                          obscureText: true,
                          onChanged: loginStore.setPassword,
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
                                disabledBackgroundColor:
                                    Colors.orange.withAlpha(120)),
                            onPressed: () {
                              if (loginStore.loginPressed != null) {
                                loginStore.loginPressed!();
                              }
                            },
                            child: loginStore.loading
                                ? const CircularProgressIndicator(
                                    valueColor:
                                        AlwaysStoppedAnimation(Colors.white),
                                  )
                                : const Text('ENTRAR'),
                          ),
                        );
                      }),
                      const Divider(
                        thickness: 2,
                        color: Colors.grey,
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child:
                              Wrap(alignment: WrapAlignment.center, children: [
                            const Text(
                              'Não tem uma conta?',
                              style: TextStyle(fontSize: 16),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => SignUpScreen()));
                              },
                              child: const Text(
                                'Cadastre-se',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.purple,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ]))
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
