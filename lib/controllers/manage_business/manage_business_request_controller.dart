import 'package:pro_deals_admin/utils/imports.dart';

class ManageBusinessRequestController extends GetxController {
  final BuildContext ctx;

  ManageBusinessRequestController({required this.ctx});

  RxBool isError = false.obs;
  RxBool isLoaded = false.obs;
  RxBool isProcess = false.obs;

  RxList<RequestBusinessModel> allRequests = <RequestBusinessModel>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAllBusinessRequest();
  }

  getAllBusinessRequest() async {
    try {
      var response = await ApiService.getApi(
        Apis.viewBusinessRequest,
        ctx,
      );

      if (response != null) {
        if (response['requestBusinesses'] is List ||
            response['requestBusinesses'].isNotEmpty) {
          response['requestBusinesses']
              .map((e) => allRequests.add(RequestBusinessModel.fromJson(e)))
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

  RxString bId = "".obs;

  acceptBusiness({
    required int i,
    required BuildContext ctx,
  }) async {
    bId.value = allRequests[i].sId ?? "";
    try {
      var response = await ApiService.putApi(
        Apis.acceptBusinessRequest(bId: bId.value),
        ctx,
      );

      if (response != null) {
        allRequests.removeAt(i);
        ShowToast.toast(
          msg: response['message'] ?? "Business request accepted successfully.",
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

  rejectBusiness({
    required int i,
    required BuildContext ctx,
  }) async {
    bId.value = allRequests[i].sId ?? "";
    try {
      var response = await ApiService.deleteApi(
        Apis.rejectBusinessRequest(bId: bId.value),
        ctx,
      );

      if (response != null) {
        allRequests.removeAt(i);
        ShowToast.toast(
          msg: response['message'] ?? "Business request rejected successfully.",
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

  String title({required bool isAccept}) {
    if (isAccept) {
      return "Accept Business?";
    }
    return "Reject Business?";
  }

  String subTitle({required bool isAccept}) {
    if (isAccept) {
      return "Are you sure you want to accept this business request? Once accepted, this decision will be final and cannot be changed.";
    }
    return "Are you sure you want to reject this business request? This action cannot be undone.";
  }

  showConfirmationDialog({
    required BuildContext ctx,
    required int i,
    bool isAccept = false,
  }) {
    showDialog(
      context: ctx,
      builder: (context) {
        return FluentTheme(
          data: FluentThemeData.light().copyWith(),
          child: ContentDialog(
            title: Text(
              title(
                isAccept: isAccept,
              ),
              style: AppTextStyle.semiBoldStyle(
                color: AppColor.black,
                size: 18,
              ),
            ),
            content: Text(
              subTitle(isAccept: isAccept),
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
                onPressed: () {
                  Navigator.pop(context);
                  isProcess.value = true;
                  if (isAccept) {
                    acceptBusiness(i: i, ctx: ctx);
                  } else {
                    rejectBusiness(i: i, ctx: ctx);
                  }
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.resolveWith((states) {
                    if (states.isHovered) {
                      return isAccept
                          ? Colors.green.withOpacity(0.5)
                          : Colors.red.withOpacity(0.5);
                    }
                    return isAccept ? Colors.green : Colors.red;
                  }),
                ),
                child: Text(
                  isAccept ? 'Accept' : 'Reject',
                  style: AppTextStyle.mediumStyle(
                    color: AppColor.white,
                    size: 15,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
