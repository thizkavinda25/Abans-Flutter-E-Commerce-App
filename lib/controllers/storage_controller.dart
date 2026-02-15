import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart';
import 'package:uuid/uuid.dart';

class StorageController {
  Future<String?> uploadFile(File file, String path) async {
    final String fileName =
        '${Uuid().v4()}.${basename(file.path).split('.').last}';

    try {
      final reference = FirebaseStorage.instance.ref('$path/$fileName');
      final uploadTask = reference.putFile(file);
      final snapshot = await uploadTask.whenComplete(() {});
      final downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }
}
