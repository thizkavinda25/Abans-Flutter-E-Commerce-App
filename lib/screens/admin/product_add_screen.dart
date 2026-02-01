import 'package:abans_online/components/custom_text_field.dart';
import 'package:abans_online/data/categories.dart';
import 'package:flutter/material.dart';

class ProductAddScreen extends StatefulWidget {
  const ProductAddScreen({super.key});

  @override
  State<ProductAddScreen> createState() => _ProductAddScreenState();
}

class _ProductAddScreenState extends State<ProductAddScreen> {
  @override
  Widget build(BuildContext context) {
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
              CustomTextField(labelText: 'Name'),
              CustomTextField(
                labelText: 'Description',
                maxLines: 5,
                maxLength: 50,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text('Product Category'),
              ),
              Wrap(
                children: Categories.list.map((category) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8, bottom: 15),
                    child: Chip(
                      avatar: Icon(category.icon),
                      label: Text(category.name),
                    ),
                  );
                }).toList(),
              ),
              CustomTextField(
                labelText: 'Price',
                keyboardType: TextInputType.number,
                prefixText: 'LKR ',
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Product Category'),
                    FilledButton(onPressed: () {}, child: Text('Add Images')),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
