import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PhotoUploadContainer extends StatefulWidget {
  final Function(List<String>) onImagesChanged; // Adicione isso

  const PhotoUploadContainer({super.key, required this.onImagesChanged});

  @override
  State<PhotoUploadContainer> createState() => _PhotoUploadContainerState();
}

class _PhotoUploadContainerState extends State<PhotoUploadContainer> {
  final List<File?> _images = [];
  final List<String> _imagesPath = [];

  Future<void> _getImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        if (_images.length < 3) {
          _images.add(File(pickedFile.path));
          _imagesPath.add(pickedFile.path);
          widget.onImagesChanged(_imagesPath);
        } else {
          // You can display a toast or snackbar here indicating maximum limit reached
        }
      });
    }
  }

  void _removeImage(int index) {
    setState(() {
      _images.removeAt(index);
      _imagesPath.removeAt(index);
      widget.onImagesChanged(_imagesPath);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200, // Adjust the height as needed
      child: GridView.count(
        crossAxisCount: 3,
        children: List.generate(3, (index) {
          if (index < _images.length) {
            return GestureDetector(
              onTap: () {
                _showImageOptions(index);
              },
              child: Image.file(_images[index]!),
            );
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

  void _showImageOptions(int index) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.delete),
                title: const Text('Excluir'),
                onTap: () {
                  _removeImage(index);
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
