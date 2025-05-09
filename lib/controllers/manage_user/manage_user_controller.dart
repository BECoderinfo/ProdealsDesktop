import 'package:pro_deals_admin/utils/imports.dart';

class ManageUserController extends GetxController {
  final BuildContext ctx;

  ManageUserController({required this.ctx});

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAllUser();
  }

  RxBool isLoaded = false.obs;
  RxBool isError = false.obs;
  RxBool isProcess = false.obs;
  RxString uId = "".obs;

  RxList<UserModel> allUser = <UserModel>[].obs;

  getAllUser() async {
    try {
      var response = await ApiService.getApi(
        Apis.viewAllUser,
        ctx,
      );

      if (response != null) {
        if (response['users'] is List || response['users'].isNotEmpty) {
          response['users']
              .map((e) => allUser.add(UserModel.fromJson(e)))
              .toList();
        }
        isLoaded.value = true;
      } else {
        isError.value = true;
      }
    } catch (e) {
      isError.value = false;

      GFToast.showToast(e.toString(), ctx);
    }
  }

  deleteUser({required int i}) async {
    uId.value = allUser[i].id ?? "";
    try {
      var response = await ApiService.putApi(
        Apis.deleteUser(uId: uId.value),
        ctx,
      );

      if (response != null) {
        allUser.removeAt(i);
        ShowToast.toast(
          msg: response['message'] ?? "User deleted successfully.",
          ctx: ctx,
        );
        uId.value = "";
      }
      isProcess.value = false;
    } catch (e) {
      isProcess.value = false;

      GFToast.showToast(e.toString(), ctx);
    }
  }

  showDeleteDialog({
    required BuildContext ctx,
    required int i,
  }) {
    showDialog(
      context: ctx,
      builder: (context) {
        return FluentTheme(
          data: FluentThemeData.light().copyWith(),
          child: ContentDialog(
            title: Text(
              'Delete User?',
              style: AppTextStyle.semiBoldStyle(
                color: AppColor.black,
                size: 18,
              ),
            ),
            content: Text(
              'Are you sure you want to delete this user? This action cannot be undone.',
              style: AppTextStyle.regularStyle(
                color: AppColor.black,
                size: 17,
              ),
            ),
            actions: [
              Button(
                child: Text(
                  'Cancel',
                  style: AppTextStyle.mediumStyle(
                    color: AppColor.black,
                    size: 15,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              Button(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.resolveWith((states) {
                    if (states.isHovered) {
                      return Colors.red.withOpacity(0.5);
                    }
                    return Colors.red;
                  }),
                ),
                child: Text(
                  'OK',
                  style: AppTextStyle.mediumStyle(
                    color: AppColor.white,
                    size: 15,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  isProcess.value = true;
                  deleteUser(i: i);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
