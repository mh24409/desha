import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import '../../utils/enums/picked_image_source.dart';

Future<String> pickedImageFromGalleryOrCamera({
  required PickedImageSources imageSources,
}) async {
  ImagePicker picker = ImagePicker();
  final pickedFile = await picker.pickImage(
    source: imageSources == PickedImageSources.gallery
        ? ImageSource.gallery
        : ImageSource.camera,
    imageQuality: 40
  );
  Uint8List pickedImage = File(pickedFile!.path).readAsBytesSync();
  String base64Image = base64Encode(pickedImage);
  return base64Image;
}
