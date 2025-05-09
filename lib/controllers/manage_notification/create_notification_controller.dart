import 'package:pro_deals_admin/utils/imports.dart';

class CreateNotificationController extends GetxController {
  final BuildContext ctx;

  CreateNotificationController({
    required this.ctx,
  });

  final createNotificationKey =
      GlobalKey(debugLabel: 'Add Update Plan Details Key');

  RxBool isProcess = false.obs;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  RxString titleError = "".obs;
  RxString descriptionError = "".obs;
  RxString comboBoxError = "".obs;

  RxBool isLoaded = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getData();
  }

  getData() async {
    await getBusiness();
    await getOffers();
    await getBanner();
    isLoaded.value = true;
  }

  RxList<AllBusinessModel> allBusiness = <AllBusinessModel>[].obs;

  getBusiness() async {
    try {
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
      }
    } catch (e) {
      GFToast.showToast(e.toString(), ctx);
    }
  }

  RxList<Offers> offerList = <Offers>[].obs;

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
      }
    } catch (e) {
      GFToast.showToast(e.toString(), ctx);
    }
  }

  RxList<BannerListModel> bannerList = <BannerListModel>[].obs;

  getBanner() async {
    try {
      var response = await ApiService.getApi(
        Apis.getAllBanner,
        ctx,
      );

      if (response != null) {
        if (response['bannersByType'] != null) {
          if (response['bannersByType']["1"] is List &&
              response['bannersByType']["1"].isNotEmpty) {
            response['bannersByType']["1"]
                .map((e) => bannerList.add(BannerListModel.fromJson(e)))
                .toList();
          }
          if (response['bannersByType']["2"] is List &&
              response['bannersByType']["2"].isNotEmpty) {
            response['bannersByType']["2"]
                .map((e) => bannerList.add(BannerListModel.fromJson(e)))
                .toList();
          }
          if (response['bannersByType']["3"] is List &&
              response['bannersByType']["3"].isNotEmpty) {
            response['bannersByType']["3"]
                .map((e) => bannerList.add(BannerListModel.fromJson(e)))
                .toList();
          }
        }
      }
    } catch (e) {
      GFToast.showToast(e.toString(), ctx);
    }
  }

  List<String> notificationType = [
    "Other",
    "Business",
    "Offer",
    "Ads",
  ];

  Rxn<Offers?> selectedOffer = Rxn<Offers?>();
  Rxn<AllBusinessModel?> selectedBusiness = Rxn<AllBusinessModel?>();
  Rxn<BannerListModel?> selectedBanner = Rxn<BannerListModel?>();
  Rxn<String?> selectedType = Rxn<String?>();

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    selectedOffer.value = null;
    selectedBusiness.value = null;
    selectedBanner.value = null;
    selectedType.value = null;
    titleError.value = '';
    descriptionError.value = '';
    comboBoxError.value = '';
    titleController.clear();
    descriptionController.clear();
  }

  clearError() {
    titleError.value = '';
    descriptionError.value = '';
    comboBoxError.value = '';
  }

  checkValidation({required BuildContext ctx}) {
    clearError();
    if (titleController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        selectedType.value == null) {
      if (titleController.text.isEmpty) {
        titleError.value = 'Please enter notification title';
      }
      if (descriptionController.text.isEmpty) {
        descriptionError.value = 'Please enter notification description';
      }
      if (descriptionController.text.isEmpty) {
        comboBoxError.value = 'Please select notification type';
      }
    } else if (selectedType.value != notificationType.first &&
        checkSelectedType()) {
      if (selectedType.value == notificationType[1]) {
        comboBoxError.value = 'Please select business';
      }
      if (selectedType.value == notificationType[2]) {
        comboBoxError.value = 'Please select offer';
      }
      if (selectedType.value == notificationType[3]) {
        comboBoxError.value = 'Please select banner ads';
      }
    } else {
      callApi(ctx: ctx);
    }
  }

  callApi({required BuildContext ctx}) async {
    try {
      Map<String, String> mm = {};
      if (selectedType.value == notificationType[1]) {
        mm = {
          "businessName": selectedBusiness.value?.businessName ?? "",
          "businessId": selectedBusiness.value?.sId ?? "",
        };
      } else if (selectedType.value == notificationType[2]) {
        mm = {
          "offerName": selectedOffer.value?.description ?? "",
          "offerId": selectedOffer.value?.sId ?? "",
        };
      } else if (selectedType.value == notificationType[3]) {
        mm = {
          "adsId": selectedBanner.value?.sId ?? "",
          "adsOffer": selectedBanner.value?.offerId?.description ?? "",
        };
      }
      var response = await ApiService.postApi(
        Apis.createNotification,
        ctx,
        body: {
          "title": titleController.text,
          "description": descriptionController.text,
          "type": (selectedType.value ?? "").toLowerCase(),
          "data": mm
        },
      );

      if (response != null) {
        ShowToast.toast(
          msg: response['message'],
          ctx: ctx,
        );
        Navigator.pop(
          ctx,
          true,
        );
      }
      isProcess.value = false;
    } catch (e) {
      isProcess.value = false;

      GFToast.showToast(e.toString(), ctx);
    }
  }

  bool checkSelectedType() {
    if (selectedOffer.value != null) {
      return false;
    }
    if (selectedBanner.value != null) {
      return false;
    }
    if (selectedBusiness.value != null) {
      return false;
    }
    return true;
  }
}
