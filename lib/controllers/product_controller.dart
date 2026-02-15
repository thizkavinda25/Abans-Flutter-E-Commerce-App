import 'package:abans_online/models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/web.dart';

class ProductController {
  CollectionReference productCollection = FirebaseFirestore.instance.collection('Products');

  Future<bool> publishProduct(ProductModel product) async {
   try {
     await productCollection.doc(product.id).set(product.toJson());
     return true;
   } catch (e) {
     Logger().e(e);
     return false;
   }
  }
}