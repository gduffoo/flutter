import 'package:image_picker/image_picker.dart';
import 'package:teslo_shop/features/shared/infraestructure/services/camera_gallery_service.dart';

class CameraGalleryServiceImpl extends CameraGalleyService {
  final ImagePicker _picker = ImagePicker();

  @override
  Future<String?> selectPhoto() async {
    // Capture a photo.
    final XFile? photo = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
      preferredCameraDevice: CameraDevice.rear,
    );

    if (photo == null) return null;

    return photo.path;
  }

  @override
  Future<String?> takePhoto() async {
    // Capture a photo.
    final XFile? photo = await _picker.pickImage(source: ImageSource.gallery);

    if (photo == null) return null;

    return photo.path;
  }
}
