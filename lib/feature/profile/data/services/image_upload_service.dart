import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  Future<String?> getPickedImagePath() async {
    var imagePicker = ImagePicker();
    var imageFile = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    return imageFile?.path;
  }
}
