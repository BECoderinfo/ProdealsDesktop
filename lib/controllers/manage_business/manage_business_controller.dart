import '../../utils/imports.dart';

class ManageBusinessController extends GetxController {
  final BuildContext ctx;

  ManageBusinessController({required this.ctx});

  RxBool isError = false.obs;
  RxBool isLoaded = false.obs;
  RxBool isProcess = false.obs;

  RxList<AllBusinessModel> allBusiness = <AllBusinessModel>[].obs;
  RxString bId = "".obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAllBusiness();
  }

  getAllBusiness() async {
    try {
      isLoaded.value = false;
      var response = await ApiService.getApi(
        Apis.getAllBusiness,
        ctx,
      );

      if (response != null) {
        allBusiness.clear();
        if (response['businesses'] is List ||
            response['businesses'].isNotEmpty) {
          response['businesses']
              .map((e) => allBusiness.add(AllBusinessModel.fromJson(e)))
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

  address({required int i}) {
    return "${allBusiness[i].address ?? ""}, ${allBusiness[i].city ?? ""}, ${allBusiness[i].state ?? ""} ${allBusiness[i].pincode ?? ""}";
  }

  deleteBusiness({required int i}) async {
    bId.value = allBusiness[i].sId ?? "";
    try {
      var response = await ApiService.deleteApi(
        Apis.deleteBusiness(bId: bId.value),
        ctx,
      );

      if (response != null) {
        allBusiness.removeAt(i);
        ShowToast.toast(
          msg: response['response'] ?? "Business deleted successfully.",
          ctx: ctx,
        );
        bId.value = "";
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
              'Delete Business?',
              style: AppTextStyle.semiBoldStyle(
                color: AppColor.black,
                size: 18,
              ),
            ),
            content: Text(
              'Are you sure you want to delete this business? This action cannot be undone.',
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
                  deleteBusiness(i: i);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
