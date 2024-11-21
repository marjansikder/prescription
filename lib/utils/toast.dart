import 'package:flutter_dropdown_alert/alert_controller.dart';
import 'package:flutter_dropdown_alert/model/data_alert.dart';

class Toast {
  Toast._();

  static showSuccessToast(String message) {
    AlertController.show("Success", message, TypeAlert.success);
  }

  static showErrorToast(String message) {
    AlertController.show("Error", message, TypeAlert.error);
  }
}
