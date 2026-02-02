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
    final images = await imagePicker.pickMultiImage(
      limit: 5,
      imageQuality: 70,
      maxHeight: 600,
    );
    _pickedImages = images.map((e) => File(e.path)).toList();
  }
}
