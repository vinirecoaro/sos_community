import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sos_community/components/input_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool light = false;

  final MaterialStateProperty<Icon?> thumbIcon =
      MaterialStateProperty.resolveWith<Icon?>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.check);
      }
      return const Icon(Icons.close);
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/img/logo.svg',
                width: 200,
                height: 200,
              ),
              const InputField(
                label: "Nome completo",
              ),
              const InputField(
                label: "Celular",
              ),
              const InputField(
                label: "E-mail",
              ),
              const InputField(
                label: "Senha",
              ),
              const InputField(
                label: "Repita a senha",
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Row(
                  children: [
                    Switch(
                      thumbIcon: thumbIcon,
                      value: light,
                      onChanged: (bool value) {
                        setState(() {
                          light = value;
                        });
                      },
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text("Pessoa com deficiência")
                  ],
                ),
              ),
              if (light)
                const InputField(
                  label: "Deficiência",
                ),
              FilledButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cadastrar"))
            ],
          ),
        ),
      ),
    );
  }
}
