import 'package:pro_deals_admin/utils/imports.dart';

class ManageBannerController extends GetxController {
  final BuildContext ctx;

  ManageBannerController({required this.ctx});

  RxBool isLoaded = false.obs;
  RxBool isError = false.obs;
  RxBool isLoaded1 = false.obs;
  RxBool isError1 = false.obs;
  RxBool isProcess = false.obs;
  RxString bId = "".obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getData();
  }

  getData() async {
    await getBannerList();
    await requestBannerList();
  }

  RxInt currentIndex = 0.obs;

  RxList<BannerListModel> type1 = <BannerListModel>[].obs;
  RxList<BannerListModel> type2 = <BannerListModel>[].obs;
  RxList<BannerListModel> type3 = <BannerListModel>[].obs;

  RxList<BannerListModel> requestList = <BannerListModel>[].obs;

  getBannerList() async {
    try {
      var response = await ApiService.getApi(
        Apis.getAllBanner,
        ctx,
      );

      if (response != null) {
        type1.clear();
        type2.clear();
        type3.clear();
        if (response['bannersByType'] != null) {
          if (response['bannersByType']["1"] is List &&
              response['bannersByType']["1"].isNotEmpty) {
            response['bannersByType']["1"]
                .map((e) => type1.add(BannerListModel.fromJson(e)))
                .toList();
          }
          if (response['bannersByType']["2"] is List &&
              response['bannersByType']["2"].isNotEmpty) {
            response['bannersByType']["2"]
                .map((e) => type2.add(BannerListModel.fromJson(e)))
                .toList();
          }
          if (response['bannersByType']["3"] is List &&
              response['bannersByType']["3"].isNotEmpty) {
            response['bannersByType']["3"]
                .map((e) => type3.add(BannerListModel.fromJson(e)))
                .toList();
          }
        }
      }
      isLoaded.value = true;
    } catch (e) {
      isError.value = false;

      GFToast.showToast(e.toString(), ctx);
    }
  }

  requestBannerList() async {
    try {
      var response = await ApiService.getApi(
        Apis.getPendingBanner,
        ctx,
      );

      if (response != null) {
        if (response['banners'] is List && response['banners'].isNotEmpty) {
          response['banners']
              .map((e) => requestList.add(BannerListModel.fromJson(e)))
              .toList();
        }
      }
      isLoaded1.value = true;
    } catch (e) {
      isError1.value = false;

      GFToast.showToast(e.toString(), ctx);
    }
  }

  TextStyle tabTextStyle({required int index}) {
    return currentIndex.value == index
        ? AppTextStyle.mediumStyle(
            color: Colors.black,
            size: 18,
          )
        : AppTextStyle.regularStyle(
            color: AppColor.smokyBlack,
            size: 16,
          );
  }

  zoomImage({
    required List<int> data,
    required BuildContext ctx,
    required double wid,
  }) {
    showDialog(
      context: ctx,
      barrierDismissible: true,
      builder: (context) {
        return FluentTheme(
          data: FluentThemeData.light(),
          child: ContentDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(FluentIcons.clear),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            content: InteractiveViewer(
              panEnabled: true,
              minScale: 0.5,
              maxScale: 4.0,
              child: Image.memory(
                Uint8List.fromList(
                  data,
                ),
                height: wid / 3,
                width: wid / 3,
                fit: BoxFit.contain,
              ),
            ),
          ),
        );
      },
    );
  }

  deleteBanner({
    required int i,
    required BuildContext ctx,
    dynamic type,
  }) async {
    if (type is int) {
      bId.value = requestList[i].sId ?? "";
    } else {
      bId.value = type;
    }
    try {
      var response = await ApiService.deleteApi(
        Apis.deleteBanner(bId: bId.value),
        ctx,
      );

      if (response != null) {
        if (type is int) {
          requestList.removeAt(i);
          ShowToast.toast(
            msg: "Banner request rejected successfully.",
            ctx: ctx,
          );
        } else {
          type1.removeWhere(
            (element) => element.sId == bId.value,
          );
          type2.removeWhere(
            (element) => element.sId == bId.value,
          );
          type3.removeWhere(
            (element) => element.sId == bId.value,
          );
          ShowToast.toast(
            msg: response['message'] ?? "Banner deleted successfully.",
            ctx: ctx,
          );
        }
        bId.value = "";
      }
      isProcess.value = false;
    } catch (e) {
      isProcess.value = false;

      GFToast.showToast(e.toString(), ctx);
    }
  }

  acceptBanner({
    required int i,
    required BuildContext ctx,
  }) async {
    bId.value = requestList[i].sId ?? "";

    try {
      var response = await ApiService.postApi(
        Apis.acceptBanner(bId: bId.value),
        ctx,
      );

      if (response != null) {
        requestList.removeAt(i);
        ShowToast.toast(
          msg: response['message'] ?? "Banner request accepted successfully.",
          ctx: ctx,
        );

        bId.value = "";
        getBannerList();
        currentIndex.value = 0;
      }
      isProcess.value = false;
    } catch (e) {
      isProcess.value = false;

      GFToast.showToast(e.toString(), ctx);
    }
  }

  String title({required bool isAccept}) {
    if (isAccept) {
      return "Accept Banner?";
    }
    return "Reject Banner?";
  }

  String subTitle({required bool isAccept}) {
    if (isAccept) {
      return "Are you sure you want to accept this Banner request? Once accepted, this decision will be final and cannot be changed.";
    }
    return "Are you sure you want to reject this banner request? This action cannot be undone.";
  }

  showConfirmationDialog({
    required BuildContext ctx,
    required int i,
    bool isAccept = false,
    dynamic type,
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
                    acceptBanner(i: i, ctx: ctx);
                  } else {
                    deleteBanner(
                      i: i,
                      ctx: ctx,
                      type: type,
                    );
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

  showDeleteDialog({
    required BuildContext ctx,
    required int i,
    required String id,
  }) {
    showDialog(
      context: ctx,
      builder: (context) {
        return FluentTheme(
          data: FluentThemeData.light().copyWith(),
          child: ContentDialog(
            title: Text(
              'Delete Banner?',
              style: AppTextStyle.semiBoldStyle(
                color: AppColor.black,
                size: 18,
              ),
            ),
            content: Text(
              'Are you sure you want to delete this banner? This action cannot be undone.',
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
                  deleteBanner(
                    i: i,
                    ctx: ctx,
                    type: id,
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  String getBannerTypeName({required String type}) {
    if (type == "1") {
      return "Upper slider banner";
    } else if (type == "2") {
      return "Middle slider banner";
    } else if (type == "3") {
      return "Lower slider banner";
    }
    return "";
  }
}
