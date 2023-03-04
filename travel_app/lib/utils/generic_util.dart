import 'package:get/get.dart';

class GenericUtil {
  static void snackGeneric(title, message) {
    Get.closeAllSnackbars();
    Get.snackbar(title, message);
  }

  static void snackSuccess() {
    Get.closeAllSnackbars();
    Get.snackbar("Success", "Logged In Successfully");
  }
}