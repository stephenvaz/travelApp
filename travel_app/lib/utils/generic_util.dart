import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/utils/MStyles.dart';
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
class MTextField extends StatelessWidget {
  final maxLen;

  final onTap;

  final readOnly;

  final suffixIcon;

  const MTextField(
      {Key? key,
      required this.label,
      required this.mcont,
      this.maxLen,
      this.onTap,
      this.readOnly,
      this.suffixIcon})
      : super(key: key);

  final String label;
  final TextEditingController mcont;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextField(
        onTap: onTap,
        readOnly: readOnly ?? false,
        maxLines: maxLen ?? 1,
        controller: mcont,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: MStyles.pColor),
          ),
          label: Text(label),
          filled: true,
          fillColor: MStyles.pColor.withOpacity(0.25),
        ),
      ),
    );
  }
}
