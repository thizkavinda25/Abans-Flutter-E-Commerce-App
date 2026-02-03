// ignore_for_file: prefer_final_fields

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProductAddProvider extends ChangeNotifier {
  TextEditingController _productNameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _priceController = TextEditingController();

  TextEditingController get productNameController => _productNameController;
  TextEditingController get descriptionController => _descriptionController;
  TextEditingController get priceController => _priceController;

  String? _selectedCategoryId;
  String? get selectedCategoryId => _selectedCategoryId;

  List<File> _pickedImages = [];
  List<File> get pickedImages => _pickedImages;

  void setProductCategory(String id) {
    _selectedCategoryId = id;
    notifyListeners();
  }

  Future<void> addImages() async {
    final imagePicker = ImagePicker();
    final remaining = 5 - _pickedImages.length;

    if (remaining <= 0) return; // Already reached max

    if (remaining == 1) {
      final image = await imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
        maxHeight: 600,
      );
      if (image != null) {
        _pickedImages.add(File(image.path));
        notifyListeners();
      }
    } else {
      final images = await imagePicker.pickMultiImage(
        imageQuality: 70,
        maxHeight: 600,
      );

      if (images != null && images.isNotEmpty) {
        // Add only up to remaining slots
        final newImages = images
            .take(remaining)
            .map((img) => File(img.path))
            .toList();
        _pickedImages.addAll(newImages);
        notifyListeners();
      }
    }
  }

  void removeImage(File image) {
    _pickedImages.remove(image);
    notifyListeners();
  }
}
