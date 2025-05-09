import 'package:pro_deals_admin/utils/imports.dart';

class SettingsController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cPasswordController = TextEditingController();

  RxString emailError = "".obs;
  RxString passwordError = "".obs;
  RxString cPasswordError = "".obs;
  RxBool showPassword = false.obs;

  RxBool isProcess = false.obs;

  showBtnDialog({
    required BuildContext ctx,
    required String title,
    required Widget content,
    required List<Widget> action,
  }) {
    showDialog(
      context: ctx,
      builder: (context) {
        return FluentThemeWidget(
          widget: ContentDialog(
            title: Text(
              title,
              style: AppTextStyle.semiBoldStyle(
                color: AppColor.black,
                size: 22,
              ),
            ),
            content: content,
            actions: action,
          ),
        );
      },
    ).then(
      (value) {
        clearField();
      },
    );
  }

  clearError() {
    emailError.value = "";
    passwordError.value = "";
    cPasswordError.value = "";
  }

  clearField() {
    emailController.clear();
    passwordController.clear();
    cPasswordController.clear();
    emailError.value = "";
    passwordError.value = "";
    cPasswordError.value = "";
  }

  checkValidation({required BuildContext ctx}) {
    clearError();

    if (passwordController.text.isEmpty ||
        cPasswordController.text.isEmpty ||
        passwordController.text.length < 6) {
      if (passwordController.text.isEmpty) {
        passwordError.value = "Please enter password";
      } else if (passwordController.text.length < 6) {
        passwordError.value = "Please enter atlest 6 digit password";
      }
      if (cPasswordController.text.isEmpty) {
        cPasswordError.value = "Please enter confirm password";
      }
    } else if (passwordController.text != cPasswordController.text) {
      cPasswordController.clear();
      cPasswordError.value = "Please enter both password same";
    } else {
      isProcess.value = true;
      callApi(
        ctx: ctx,
        msg: "Password changed successfully",
        url: Apis.adminResetPassword,
        body: {
          "adminID": StorageService.readData(key: StorageKeys.adminId) ?? "",
          "newPassword": passwordController.text,
          "confirmPassword": cPasswordController.text,
        },
      );
    }
  }

  checkValidationResetEmail({required BuildContext ctx}) {
    clearError();
    if (emailController.text.isEmpty) {
      emailError.value = "Please enter email";
    } else if (!GetUtils.isEmail(emailController.text)) {
      emailError.value = "Please enter valid email";
    } else {
      isProcess.value = true;
      callApi(
        ctx: ctx,
        msg: "Email changed successfully",
        url: Apis.adminResetEmail,
        body: {
          "adminID": StorageService.readData(key: StorageKeys.adminId) ?? "",
          "email": emailController.text,
        },
        type: 2,
      );
    }
  }

  callApi({
    required BuildContext ctx,
    required String msg,
    int type = 1,
    required Uri url,
    required Map<String, String> body,
  }) async {
    try {
      var response = await ApiService.postApi(
        url,
        body: body,
        ctx,
      );
      if (response != null) {
        ShowToast.toast(
          msg: response['message'] ?? msg,
          ctx: ctx,
        );
        if (type == 2) {
          StorageService.writeData(
            value: emailController.text,
            key: StorageKeys.adminEmail,
          );
          aEmail.value = emailController.text;
        }
        Navigator.pop(ctx);
      }
      isProcess.value = false;
    } catch (e) {
      isProcess.value = false;

      GFToast.showToast(e.toString(), ctx);
    }
  }
}
