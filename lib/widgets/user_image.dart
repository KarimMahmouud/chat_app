import 'dart:io';
import "package:flutter/material.dart";
import 'package:image_picker/image_picker.dart';

class ImagePic extends StatefulWidget {
  const ImagePic({
    super.key,
    required this.onPicImage,
  });

  final void Function(File picImageFile) onPicImage;

  @override
  State<ImagePic> createState() => _ImagePicState();
}

class _ImagePicState extends State<ImagePic> {
  File? picImageFile;

  void picImage() async {
    final XFile? pickedImage = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 150,
      imageQuality: 50,
    );
    if (pickedImage == null) {
      return;
    }
    setState(() {
      picImageFile = File(pickedImage.path);
    });
    widget.onPicImage(picImageFile!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundImage:
              picImageFile == null ? null : FileImage(picImageFile!),
          backgroundColor: Colors.grey,
          radius: 40,
        ),
        TextButton.icon(
          onPressed: picImage,
          label: const Text("Add Image"),
          icon: const Icon(Icons.image),
        ),
      ],
    );
  }
}
