import 'package:pro_deals_admin/utils/imports.dart';

class PanelController extends GetxController {
  RxInt select = 0.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    aEmail.value = StorageService.readData(key: StorageKeys.adminEmail) ?? "";
  }
}
