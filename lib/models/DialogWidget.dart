import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogWidget {
  final String title;
  final String message;

  DialogWidget(this.title, this.message);

  showDialog() {
    Get.defaultDialog(
      title: title,
      content: Text(message),
      textConfirm: 'Entendi',
      confirmTextColor: Colors.black,
      buttonColor: const Color(0xff334bea),
      radius: 20,
      onConfirm: () {
        Get.back();
      },
    );
  }
}
