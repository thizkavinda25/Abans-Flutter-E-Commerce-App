import 'package:abans_online/components/custom_text_field.dart';
import 'package:abans_online/data/categories.dart';
import 'package:abans_online/providers/product_add_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductAddScreen extends StatefulWidget {
  const ProductAddScreen({super.key});

  @override
  State<ProductAddScreen> createState() => _ProductAddScreenState();
}

class _ProductAddScreenState extends State<ProductAddScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProductAddProvider>(
      builder: (context, productAddProvider, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.grey.shade900,
            foregroundColor: Colors.white,
            centerTitle: true,
            title: Text('Add Product'),
          ),
          body: Padding(
            padding: EdgeInsetsGeometry.symmetric(vertical: 12, horizontal: 16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField(
                    labelText: 'Name',
                    controller: productAddProvider.productNameController,
                  ),
                  CustomTextField(
                    labelText: 'Description',
                    maxLines: 5,
                    maxLength: 50,
                    controller: productAddProvider.descriptionController,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text('Product Category'),
                  ),
                  Wrap(
                    children: Categories.list.map((category) {
                      final isSelected =
                          productAddProvider.selectedCategoryId == category.id;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8, bottom: 15),
                        child: GestureDetector(
                          onTap: () {
                            productAddProvider.setProductCategory(category.id);
                          },

                          child: Chip(
                            backgroundColor: isSelected
                                ? Colors.deepPurple.shade100
                                : Colors.grey.shade200,
                            avatar: Icon(category.icon),
                            label: Text(category.name),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  CustomTextField(
                    labelText: 'Price',
                    keyboardType: TextInputType.number,
                    prefixText: 'LKR ',
                    controller: productAddProvider.priceController,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Product Category'),
                        FilledButton(
                          onPressed: () {
                            productAddProvider.addImages();
                          },
                          child: Text('Add Images'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
