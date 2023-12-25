import 'package:get_storage/get_storage.dart';

class GetStorageHelper {
  static GetStorage? _box;

  static GetStorage getBox(String name) {
    _box ??= GetStorage(name);
    return _box!;
  }
}
