import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PhotoUploadContainer extends StatefulWidget {
  const PhotoUploadContainer({super.key});

  @override
  State<PhotoUploadContainer> createState() => _PhotoUploadContainerState();
}

class _PhotoUploadContainerState extends State<PhotoUploadContainer> {
  List<File?> _images = [];

  Future<void> _getImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: source);

    if (pickedFile != null) {
      setState(() {
        if (_images.length < 3) {
          _images.add(File(pickedFile.path));
        } else {
          // You can display a toast or snackbar here indicating maximum limit reached
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200, // Adjust the height as needed
      child: GridView.count(
        crossAxisCount: 3,
        children: List.generate(3, (index) {
          if (index < _images.length) {
            return Image.file(_images[index]!);
          } else {
            return IconButton(
              icon: const Icon(Icons.camera_alt),
              onPressed: () {
                _showImagePickerOptions();
              },
            );
          }
        }),
      ),
    );
  }

  void _showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Galeria'),
                onTap: () {
                  _getImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                onTap: () {
                  _getImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
