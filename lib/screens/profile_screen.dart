import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sos_community/components/custom_app_bar.dart';
import 'package:sos_community/components/show_text_field.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController claimNumController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    emailController.text = "vinirec@example.com";
    claimNumController.text = "18";
    return Scaffold(
      appBar: const CustomAppBar("Perfil"),
      body: Stack(
        children: [
          Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 60,
                ),
                SvgPicture.asset(
                  'assets/img/avatar.svg',
                  width: 200,
                  height: 200,
                ),
                const SizedBox(
                  height: 60,
                ),
                ShowTextField(
                  label: "E-mail",
                  controller: emailController,
                  enabled: false,
                ),
                ShowTextField(
                  label: "Numero de reclamações",
                  controller: claimNumController,
                  enabled: false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
