// ignore_for_file: prefer_final_fields

import 'dart:io';
import 'package:abans_online/controllers/product_controller.dart';
import 'package:abans_online/controllers/storage_controller.dart';
import 'package:abans_online/models/product_model.dart';
import 'package:abans_online/utils/custom_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

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

    if (remaining <= 0) return;

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

  void clearData() {
    _productNameController.clear();
    _descriptionController.clear();
    _priceController.clear();
    _pickedImages.clear();
    _selectedCategoryId = null;
    notifyListeners();
  }

  Future<void> publishProduct(BuildContext context) async {
    if (_productNameController.text.trim().isEmpty) {
      CustomDialogs.showErrorSnackBar(context, 'Please add product name');
    } else if (_descriptionController.text.trim().isEmpty) {
      CustomDialogs.showErrorSnackBar(
        context,
        'Please provide product description',
      );
    } else if (_selectedCategoryId == null) {
      CustomDialogs.showErrorSnackBar(context, 'Please add product category');
    } else if (_priceController.text.trim().isEmpty) {
      CustomDialogs.showErrorSnackBar(context, 'Please add product price');
    } else if (_pickedImages.isEmpty) {
      CustomDialogs.showErrorSnackBar(
        context,
        'Please add at least one product image',
      );
    } else {
      List<String> imageUrls = [];
      EasyLoading.show();
      for (var image in _pickedImages) {
        final imgUrl = await StorageController().uploadFile(
          image,
          'Product Images',
        );
        if (imgUrl != null) {
          imageUrls.add(imgUrl);
        }
      }
      final product = ProductModel(
        id: Uuid().v4(),
        name: _productNameController.text.trim(),
        description: _descriptionController.text.trim(),
        categoryId: _selectedCategoryId!,
        price: double.parse(_priceController.text.trim()),
        images: imageUrls,
      );
      final isSuccess = await ProductController().publishProduct(product);
      if (isSuccess) {
        clearData();
        CustomDialogs.showSuccessSnackBar(
          context,
          'Product published successfully',
        );
      } else {
        CustomDialogs.showErrorSnackBar(context, 'Failed to publish product');
      }
      EasyLoading.dismiss();
    }
  }
}
