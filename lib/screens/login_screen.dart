import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sos_community/components/input_field.dart';
import 'package:sos_community/routes.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/img/logo.svg',
                  width: 200,
                  height: 200,
                ),
                const InputField(
                  label: "E-mail",
                ),
                const InputField(
                  label: "Senha",
                ),
                FilledButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, Routes.CLAIM_LIST);
                    },
                    child: const Text("Entrar"))
              ],
            ),
          ),
          Positioned(
            bottom:
                30, // A distância do botão em relação à parte inferior da tela
            left: 0,
            right: 0,
            child: Center(
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.SIGN_UP);
                },
                child: const Text("Não tem conta? Cadastre-se!"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
