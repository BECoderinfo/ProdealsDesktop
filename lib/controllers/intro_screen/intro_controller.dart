import 'package:pro_deals_admin/utils/imports.dart';

class IntroController extends GetxController {
  final BuildContext ctx;

  IntroController({required this.ctx});

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    4.delay().then(
          (value) => splash(),
        );
  }

  splash() {
    if (StorageService.readData(key: StorageKeys.isLoggedIn) ?? false) {
      Navigator.pushReplacementNamed(ctx, '/panel');
    } else if (StorageService.readData(key: StorageKeys.isStaffLoggedIn) ??
        false) {
      Navigator.pushReplacementNamed(ctx, '/staff_panel');
    } else {
      Navigator.pushReplacementNamed(ctx, '/login');
    }
  }
}
