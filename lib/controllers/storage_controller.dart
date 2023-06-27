import 'dart:io';

import 'package:image_picker/image_picker.dart';

/// Storage controller
class StorageController {
  StorageController._();

  /// Img form gallery
  static Future<File?> imgFromGallery() async {
    final XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    return pickedFile != null ? File(pickedFile.path) : null;
  }
}
