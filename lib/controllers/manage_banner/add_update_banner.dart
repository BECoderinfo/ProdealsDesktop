import 'package:pro_deals_admin/utils/imports.dart';

class AddUpdateBannerController extends GetxController {
  final dynamic data;
  final BuildContext ctx;

  AddUpdateBannerController({
    required this.data,
    required this.ctx,
  });

  final addUpdateBannerKey = GlobalKey(debugLabel: 'Add Update Banner Key');

  RxBool isEdit = false.obs;
  RxBool isProcess = false.obs;
  RxBool isLoaded = false.obs;
  BannerListModel banner = BannerListModel();

  Rxn<File?> bannerImage = Rxn<File?>();
  Rxn<String?> selectedType = Rxn<String?>();
  Rxn<String?> selectedOffer = Rxn<String?>();

  RxList<Offers> offerList = <Offers>[].obs;

  List<String> bannerTypeList = [
    "Upper slider banner",
    "Middle slider banner",
    "Lower slider banner",
  ];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if (data['isEdit'] is bool && data['isEdit']) {
      isEdit.value = true;
      banner = data['data'];

      if (banner.type == "1") {
        selectedType.value = bannerTypeList.first;
      } else if (banner.type == "2") {
        selectedType.value = bannerTypeList[1];
      } else if (banner.type == "3") {
        selectedType.value = bannerTypeList.last;
      } else {
        selectedType.value = bannerTypeList.first;
      }
    } else {
      getOffers();
    }
  }

  getOffers() async {
    try {
      var response = await ApiService.getApi(
        Apis.getAllOffer,
        ctx,
      );

      if (response != null) {
        if (response['offers'] is List || response['offers'].isNotEmpty) {
          response['offers']
              .map((e) => offerList.add(Offers.fromJson(e)))
              .toList();
        }
        isLoaded.value = true;
      }
    } catch (e) {
      GFToast.showToast(e.toString(), ctx);
    }
  }

  checkValidation({required BuildContext ctx}) {
    if (!isEdit.value) {
      if (bannerImage.value == null) {
        ShowToast.toast(
          msg: "Please select banner image",
          ctx: ctx,
        );
      } else if (selectedType.value == null) {
        ShowToast.toast(
          msg: "Please select banner type",
          ctx: ctx,
        );
      } else if (selectedOffer.value == null) {
        ShowToast.toast(
          msg: "Please select offer.",
          ctx: ctx,
        );
      } else {
        isProcess.value = true;
        addBannerApiCall();
      }
    } else {
      if ((banner.image?.data ?? []).isImage() && bannerImage.value == null) {
        ShowToast.toast(
          msg: "Please select banner image",
          ctx: ctx,
        );
      } else if (selectedType.value == null) {
        ShowToast.toast(
          msg: "Please select banner type",
          ctx: ctx,
        );
      } else {
        isProcess.value = true;
        updateBanner(ctx: ctx);
      }
    }
  }

  getType() {
    if (selectedType.value == bannerTypeList.first) {
      return "1";
    } else if (selectedType.value == bannerTypeList[1]) {
      return "2";
    } else {
      return "3";
    }
  }

  updateBanner({required BuildContext ctx}) async {
    try {
      String i = getType();
      List l1 = [];
      List l2 = [];
      if (bannerImage.value != null) {
        l1.add('image');
        l2.add(bannerImage.value?.path ?? "");
      }
      var response = await ApiService.multipartApi(
        method: 'PUT',
        Apis.updateBanner(bId: banner.sId ?? ""),
        ctx,
        l1,
        l2,
        body: {
          "type": i.toString(),
        },
      );

      if (response != null) {
        ShowToast.toast(
          msg: response['response'] ?? "Banner updated successfully.",
          ctx: ctx,
        );
        Navigator.pop(ctx, true);
      }
      isProcess.value = false;
    } catch (e) {
      isProcess.value = false;

      GFToast.showToast(e.toString(), ctx);
    }
  }

  addBannerApiCall() async {
    try {
      String i = getType();
      String offerId = "";
      int i1 = offerList.indexWhere(
        (element) =>
            element.description == selectedOffer.value?.split(" | ").first,
      );
      int i2 = offerList.indexWhere(
        (element) =>
            element.businessId?.businessName ==
            selectedOffer.value?.split(" | ").last,
      );
      if (i1 == i2) {
        offerId = offerList[i1].sId ?? "";
      } else {
        ShowToast.toast(
          msg: "Something went wrong. Please try again.",
          ctx: ctx,
        );
        return;
      }
      var response = await ApiService.multipartApi(
        Apis.addBanner,
        ctx,
        'image',
        bannerImage.value?.path,
        body: {
          "type": i.toString(),
          "offerId": offerId,
        },
      );

      if (response != null) {
        ShowToast.toast(
          msg: response['response'] ?? "Banner added successfully.",
          ctx: ctx,
        );
        acceptBanner(id: response['banner']['_id'] ?? "");
      }
      isProcess.value = false;
    } catch (e) {
      isProcess.value = false;

      GFToast.showToast(e.toString(), ctx);
    }
  }

  acceptBanner({required String id}) async {
    try {
      var response = await ApiService.postApi(
        Apis.acceptBanner(bId: id),
        ctx,
      );

      if (response != null) {
        Navigator.pop(ctx, true);
      }
    } catch (e) {
      GFToast.showToast(e.toString(), ctx);
    }
  }
}
