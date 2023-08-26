import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../../utils/enums/picked_image_source.dart';

Future<File> pickedImageFromGalleryOrCamera({
  required PickedImageSources imageSources,
}) async {
  ImagePicker picker = ImagePicker();
  final pickedFile = await picker.pickImage(
    source: imageSources == PickedImageSources.gallery
        ? ImageSource.gallery
        : ImageSource.camera,
  );
  File pickedImage = File(pickedFile!.path);
  return pickedImage ;
}
