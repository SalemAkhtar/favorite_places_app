import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  ImageInput({super.key, required this.onPickImage});

  final void Function(File image) onPickImage;

  State<ImageInput> createState() {
    return _ImageInputState();
  }
}

class _ImageInputState extends State<ImageInput> {
  File? _selectedImage;
  void _takePicture() async {
    final imagePicker = ImagePicker();
    final _pickedImage = await imagePicker.pickImage(
      source: ImageSource.camera,
    );
    if (_pickedImage == null) {
      return;
    }
    setState(() {
      _selectedImage = File(_pickedImage.path);
    });
    widget.onPickImage(_selectedImage!);
  }

  Widget build(BuildContext context) {
    Widget content = TextButton.icon(
      onPressed: _takePicture,
      icon: Icon(Icons.camera),
      label: Text('Take Picture'),
    );
    if (_selectedImage != null) {
      content = GestureDetector(
        onTap: _takePicture,
        child: Image.file(
          _selectedImage!,
          fit: BoxFit.cover,
          
          width: double.infinity,
          height: double.infinity,
        ),
      );
    }
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Theme.of(context).primaryColor.withOpacity(0.2),
        ),
      ),
      height: 250,
      width: double.infinity,
      alignment: Alignment.center,
      child: content,
    );
  }
}
