import 'package:flutter/material.dart';

class PhotoContainer extends StatefulWidget {
  final List<String> imagesPath; // Adicione isso

  const PhotoContainer({super.key, required this.imagesPath});

  @override
  State<PhotoContainer> createState() => _PhotoContainerState();
}

class _PhotoContainerState extends State<PhotoContainer> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200, // Adjust the height as needed
      child: GridView.count(
        crossAxisCount: widget.imagesPath.length,
        children: List.generate(widget.imagesPath.length, (index) {
          if (index < widget.imagesPath.length) {
            return Image.network(widget.imagesPath[index]);
          } else {
            return Center();
          }
        }),
      ),
    );
  }
}
