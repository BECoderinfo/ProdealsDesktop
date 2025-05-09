import 'package:pro_deals_admin/utils/imports.dart';

class LoginController extends GetxController {
  TextEditingController email = TextEditingController();

  TextEditingController pass = TextEditingController();

  Rxn<String?> emailError = Rxn<String?>();
  Rxn<String?> passError = Rxn<String?>();

  PageController p = PageController();

  RxBool isProcess = false.obs;
  RxInt loginType = 0.obs;

  adminLogin({required BuildContext ctx}) async {
    try {
      var response = await ApiService.postApi(
        Apis.adminLogin,
        body: {
          "email": email.text,
          "password": pass.text,
        },
        ctx,
      );
      isProcess.value = false;
      if (response != null) {
        ShowToast.toast(
          msg: "${response['message'] ?? ""}",
          ctx: ctx,
        );
        // verifyOtp(
        //   ctx: ctx,
        //   otp1: response['otp'],
        // );
        p.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.linear,
        );
      }
    } catch (e) {
      isProcess.value = false;

      GFToast.showToast(e.toString(), ctx);
    }
  }

  staffLogin({required BuildContext ctx}) async {
    try {
      var response = await ApiService.postApi(
        Apis.staffLogin,
        body: {
          "StaffId": email.text,
          "password": pass.text,
        },
        ctx,
      );
      isProcess.value = false;
      if (response != null) {
        ShowToast.toast(
          msg: "${response['message'] ?? ""}",
          ctx: ctx,
        );
        secureApi(
          token: response['token'] ?? "",
          ctx: ctx,
          url: Apis.secureStaff,
        );
      }
    } catch (e) {
      isProcess.value = false;

      GFToast.showToast(e.toString(), ctx);
    }
  }

  TextEditingController otp = TextEditingController();

  verifyOtp({
    required BuildContext ctx,
    String? otp1,
  }) async {
    try {
      var response = await ApiService.postApi(
        Apis.adminOTPVerify(email: email.text),
        body: {
          // "otp": otp1,
          "otp": otp.text,
        },
        ctx,
      );
      isProcess.value = false;
      if (response != null) {
        secureApi(
          token: response['adminToken'] ?? "",
          ctx: ctx,
          url: Apis.adminSecure,
        );
      }
    } catch (e) {
      isProcess.value = false;

      GFToast.showToast(e.toString(), ctx);
    }
  }

  resendOtp({required BuildContext ctx}) async {
    try {
      var response = await ApiService.postApi(
        Apis.adminResendOTP(email: email.text),
        ctx,
        body: null,
      );
      isProcess.value = false;

      if (response != null) {
        ShowToast.toast(
            msg: response['message'] ?? "Otp resent done.", ctx: ctx);
      }
    } catch (e) {
      isProcess.value = false;

      GFToast.showToast(e.toString(), ctx);
    }
  }

  void secureApi({
    required String token,
    required BuildContext ctx,
    required Uri url,
  }) async {
    try {
      var response = await ApiService.getApi(
        url,
        ctx,
        headers: {
          "token": token,
        },
      );
      if (loginType.value == 0) {
        StorageService.writeData(
          key: StorageKeys.adminId,
          value: response['data']['adminId'] ?? "",
        );
        StorageService.writeData(
          key: StorageKeys.isLoggedIn,
          value: true,
        );
        StorageService.writeData(
          key: StorageKeys.adminEmail,
          value: email.text,
        );
        StorageService.writeData(
          key: StorageKeys.adminPassword,
          value: pass.text,
        );
        StorageService.writeData(
          key: StorageKeys.adminToken,
          value: token,
        );
        Navigator.pushReplacementNamed(ctx, '/panel');
      } else {
        StorageService.writeData(
          key: StorageKeys.staffId,
          value: response['data']['StaffId'] ?? "",
        );
        StorageService.writeData(
          key: StorageKeys.staffSId,
          value: response['data']['_id'] ?? "",
        );
        StorageService.writeData(
          key: StorageKeys.isStaffLoggedIn,
          value: true,
        );
        StorageService.writeData(
          key: StorageKeys.staffEmail,
          value: response['data']['email'] ?? "",
        );
        StorageService.writeData(
          key: StorageKeys.staffName,
          value: response['data']['name'] ?? "",
        );
        StorageService.writeData(
          key: StorageKeys.staffPhone,
          value: response['data']['phone'] ?? "",
        );
        StorageService.writeData(
          key: StorageKeys.staffRole,
          value: response['data']['role'] ?? "",
        );
        Navigator.pushReplacementNamed(ctx, '/staff_panel');
      }
      emailError.value = null;
      email.clear();
      passError.value = null;
      pass.clear();
      isProcess.value = false;
    } catch (e) {
      isProcess.value = false;

      GFToast.showToast(e..toString(), ctx);
    }
  }
}
