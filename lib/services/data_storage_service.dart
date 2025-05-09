import 'package:pro_deals_admin/utils/imports.dart';

class StorageService {
  static dynamic readData({required String key}) {
    return MyVariables.box.read(key);
  }

  static writeData({
    required String key,
    required dynamic value,
  }) {
    return MyVariables.box.write(key, value);
  }

  static bool checkIfExist({required String key}) {
    return MyVariables.box.hasData(key);
  }

  static removeData({required String key}) {
    MyVariables.box.remove(key);
  }

  static removeBox() {
    MyVariables.box.erase();
  }
}

class StorageKeys {
  static const String isLoggedIn = "logged_in";
  static const String adminId = "id";
  static const String adminEmail = "email";
  static const String adminPassword = "password";
  static const String adminToken = "token";

  /// staff keys
  static const String isStaffLoggedIn = "staff_logged_in";
  static const String staffId = "staff_id";
  static const String staffSId = "staff_sid";
  static const String staffName = "staff_name";
  static const String staffEmail = "staff_email";
  static const String staffPhone = "staff_phone";
  static const String staffRole = "staff_role";
}
