import 'package:flutter/material.dart';

class CustomAppBarActions extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomAppBarActions({
    super.key,
    required this.title,
    this.actions,
  });

  final String title;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CustomAppBarClipper(),
      child: AppBar(
        title: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 11, 109, 60),
        actions: actions,
        iconTheme: const IconThemeData(
          color: Colors.white, // Define a cor do botão de voltar como branco
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 20);
}

class CustomAppBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    const radius = 20.0;

    path.lineTo(0, size.height);
    path.quadraticBezierTo(
        0, size.height - radius, radius, size.height - radius);
    path.lineTo(size.width - radius, size.height - radius);
    path.quadraticBezierTo(
        size.width, size.height - radius, size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
