import 'package:pro_deals_admin/utils/imports.dart';

class UpdateBusinessController extends GetxController {
  final BuildContext ctx;
  final AllBusinessModel business;

  UpdateBusinessController({
    required this.ctx,
    required this.business,
  });

  final updateBusinessKey = GlobalKey(debugLabel: 'Update Business');

  PageController p = PageController();

  RxBool isProcess = false.obs;
  RxBool isDelete = false.obs;
  RxBool isLoaded = false.obs;

  Widget summaryWidget({
    required String title,
    required Widget content,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyle.mediumStyle(
            color: AppColor.smokyBlack,
            size: 18,
          ),
        ),
        content
      ],
    );
  }

  getData() async {
    await cityFetch();
    await categoryFetch();
    if (!city.contains(business.city ?? "")) {
      city.add(business.city ?? "");
    }
    if (!category.contains(business.category ?? "")) {
      category.add(business.category ?? "");
    }
    selectedCity.value = business.city;
    selectedCategory.value = business.category;
    isLoaded.value = true;
  }

  cityFetch() async {
    try {
      var response = await ApiService.getApi(
        Apis.getAllCity,
        ctx,
      );

      if (response != null) {
        city.clear();
        if (response['citys'] is List || response['citys'].isNotEmpty) {
          response['citys'].map((e) => city.add(e['Cityname'])).toList();
        }
      }
    } catch (e) {}
  }

  categoryFetch() async {
    try {
      var response = await ApiService.getApi(
        Apis.getAllCategory,
        ctx,
      );

      if (response != null) {
        category.clear();
        if (response is List || response.isNotEmpty) {
          response.map((e) => category.add(e['category'])).toList();
        }
      }
    } catch (e) {}
  }

  RxList<String> city = <String>[].obs;
  RxList<String> category = <String>[].obs;
  List<String> daysOfWeek = [
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Open All Days",
  ];

  Rxn<String?> selectedOffDays = Rxn<String?>();
  Rxn<String?> selectedCity = Rxn<String?>();
  Rxn<String?> selectedCategory = Rxn<String?>();
  TextEditingController nameController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController openTimeController = TextEditingController();
  TextEditingController closeTimeController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  Rxn<String?> nameError = Rxn<String?>();
  Rxn<String?> contactError = Rxn<String?>();
  Rxn<String?> addressError = Rxn<String?>();
  Rxn<String?> stateError = Rxn<String?>();
  Rxn<String?> pinCodeError = Rxn<String?>();
  Rxn<String?> cityError = Rxn<String?>();
  Rxn<String?> categoryError = Rxn<String?>();
  Rxn<String?> areaError = Rxn<String?>();
  Rxn<String?> openTimeError = Rxn<String?>();
  Rxn<String?> closeTimeError = Rxn<String?>();
  Rxn<String?> descriptionError = Rxn<String?>();
  Rxn<String?> offDaysError = Rxn<String?>();

  Rxn<File?> imageFile = Rxn<File?>();
  RxList<File?> storeImageList = <File?>[].obs;

  timePickerDialog(
      {required BuildContext ctx, required int type, required String title}) {
    showDialog(
      context: ctx,
      builder: (context) {
        return FluentThemeWidget(
          widget: ContentDialog(
            title: Text(
              "Select ${title.toLowerCase()}",
            ),
            content: FluentTheme(
              data: FluentThemeData.light(),
              child: TimePicker(
                selected: DateTime.now(),
                onChanged: (time) {
                  if (type == 1) {
                    openTimeError.value = null;
                    openTimeController.text =
                        DateFormat('hh:mm a').format(time);
                  } else {
                    closeTimeError.value = null;
                    closeTimeController.text =
                        DateFormat('hh:mm a').format(time);
                  }
                  Navigator.pop(context);
                },
                onCancel: () {
                  Navigator.pop(context);
                },
                header: title,
                minuteIncrement: 10,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget imagePickerWidget({required int index}) {
    return Obx(
      () => Container(
        width: 110,
        height: 150,
        decoration: BoxDecoration(
          color: AppColor.primary.withOpacity(0.5),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: (storeImageList.isNotEmpty &&
                      (index >= 0 && index < storeImageList.length) &&
                      storeImageList[index] != null
                  ? Image.file(
                      storeImageList[index]!,
                      width: 110,
                      height: 150,
                      fit: BoxFit.cover,
                    )
                  : ((business.storeImages?.isNotEmpty ?? false) &&
                          (index >= 0 &&
                              index < (business.storeImages?.length ?? 0)))
                      ? Image.memory(
                          Uint8List.fromList(
                            business.storeImages![index].data!.data!,
                          ),
                          fit: BoxFit.cover,
                          width: 110,
                          height: 150,
                        )
                      : Image.asset(
                          'assets/images/default_image.png',
                          fit: BoxFit.cover,
                          width: 110,
                          height: 150,
                        )),
            ),
            Positioned(
              bottom: 8,
              right: 8,
              child: ((business.storeImages?.isNotEmpty ?? false) &&
                      (index >= 0 &&
                          index < (business.storeImages?.length ?? 0)))
                  ? isDelete.value
                      ? Checkbox(
                          style: const CheckboxThemeData(
                            checkedIconColor:
                                WidgetStatePropertyAll(AppColor.black300),
                            foregroundColor:
                                WidgetStatePropertyAll(AppColor.primary),
                          ),
                          checked: imageIdList
                              .contains(business.storeImages?[index].sId ?? ""),
                          onChanged: (bool? value) {
                            if (imageIdList.contains(
                                business.storeImages?[index].sId ?? "")) {
                              imageIdList.remove(
                                  business.storeImages?[index].sId ?? "");
                            } else {
                              imageIdList
                                  .add(business.storeImages?[index].sId ?? "");
                            }
                          },
                        )
                      : GestureDetector(
                          onTap: () {
                            isDelete.value = true;
                            imageIdList
                                .add(business.storeImages?[index].sId ?? "");
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColor.smokyBlack,
                            ),
                            child: const Icon(
                              FluentIcons.delete,
                              size: 15,
                            ),
                          ),
                        )
                  : GestureDetector(
                      onTap: () async {
                        FilePickerResult? result =
                            await FilePicker.platform.pickFiles(
                          type: FileType.image,
                        );

                        if (result != null) {
                          if (index >= 0 && index < storeImageList.length) {
                            storeImageList[index] =
                                (File(result.files.single.path!));
                          } else {
                            storeImageList.add(File(result.files.single.path!));
                          }
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColor.smokyBlack,
                        ),
                        child: const Icon(
                          FluentIcons.edit,
                          size: 15,
                        ),
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }

  RxList<String> imageIdList = <String>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getData();
    nameController.text = business.businessName ?? "";
    contactController.text = business.contactNumber ?? "";
    addressController.text = business.address ?? "";
    stateController.text = business.state ?? "";
    pinCodeController.text = business.pincode ?? "";
    if ((business.offDays ?? "").isEmpty) {
      selectedOffDays.value = daysOfWeek.last;
    } else {
      selectedOffDays.value = business.offDays ?? "";
    }
    areaController.text = "${business.areaSqures ?? ""}";
    openTimeController.text = business.openTime ?? "";
    closeTimeController.text = business.closeTime ?? "";
    descriptionController.text = business.description ?? "";
    storeImageList.value = List.generate(
      6,
      (index) => null,
    );
  }

  checkValidation({required BuildContext ctx}) {
    if (imageFile.value == null &&
        (business.mainImage?.data?.data ?? []).isImage()) {
      ShowToast.toast(
        msg: "Please select main image",
        ctx: ctx,
      );
    }

    if (nameController.text.isEmpty) {
      nameError.value = "Please enter name";
    }

    if (contactController.text.isEmpty) {
      contactError.value = "Please enter contact number";
    } else if (!RegExp(r'^[0-9]{10}$').hasMatch(contactController.text)) {
      contactError.value = "Please enter valid contact number";
    }

    if (addressController.text.isEmpty) {
      addressError.value = "Please enter address";
    }
    if (selectedCity.value == null) {
      cityError.value = "Please select city";
    }

    if (stateController.text.isEmpty) {
      stateError.value = "Please enter state";
    }
    if (pinCodeController.text.isEmpty) {
      pinCodeError.value = "Please enter pincode";
    } else if (!RegExp(r'^[0-9]{6}$').hasMatch(pinCodeController.text)) {
      pinCodeError.value = "Please enter valid pincode";
    }
    if (selectedCategory.value == null) {
      categoryError.value = "Please select category";
    }
    if (checkMainImage() &&
        pinCodeError.value == null &&
        stateError.value == null &&
        cityError.value == null &&
        addressError.value == null &&
        nameError.value == null &&
        categoryError.value == null &&
        contactError.value == null) {
      p.nextPage(
        duration: const Duration(seconds: 1),
        curve: Curves.linear,
      );
    }
  }

  bool checkMainImage() {
    if (imageFile.value != null) {
      return true;
    }
    if (!(business.mainImage?.data?.data ?? []).isImage()) {
      return true;
    }
    return false;
  }

  checkValidation1({required BuildContext ctx}) {
    openTimeError.value = null;
    closeTimeError.value = null;

    if (areaController.text.isEmpty) {
      areaError.value = "Please enter area in SQFT";
    } else if (!GetUtils.isNumericOnly(areaController.text)) {
      areaError.value = "Please enter valid value Ex: 999";
    }
    if (selectedCategory.value == null) {
      categoryError.value = "Please select category";
    }
    if (selectedOffDays.value == null) {
      offDaysError.value = "Please select off days";
    }
    if (openTimeController.text.isEmpty) {
      openTimeError.value = "Please select open time";
    }
    if (closeTimeController.text.isEmpty) {
      closeTimeError.value = "Please select close time";
    }
    if (descriptionController.text.isEmpty) {
      descriptionError.value = "Please enter business description";
    } else if (descriptionController.text.length < 50) {
      descriptionError.value = "Description is too short";
    }

    if (areaError.value == null &&
        categoryError.value == null &&
        offDaysError.value == null &&
        closeTimeError.value == null &&
        descriptionError.value == null) {
      if ((business.storeImages?.isEmpty ?? true) && checkSelectedImages()) {
        ShowToast.toast(
          msg: "Please select atleast 3 store images",
          ctx: ctx,
        );
      } else {
        isProcess.value = true;
        callUpdateBusinessApi(ctx: ctx);
      }
    }
  }

  callUpdateBusinessApi({
    required BuildContext ctx,
  }) async {
    try {
      Map<String, dynamic> mm = {};
      mm = {
        "businessName": nameController.text,
        "address": addressController.text,
        "state": stateController.text,
        "city": selectedCity.value,
        "pincode": pinCodeController.text,
        "category": selectedCategory.value,
        "openTime": openTimeController.text,
        "closeTime": closeTimeController.text,
        "areaSqures": areaController.text,
        "Description": descriptionController.text,
      };

      if (selectedOffDays.value != daysOfWeek.last) {
        mm['offDays'] = "${selectedOffDays.value}";
      }
      var response = await ApiService.putApi(
        Apis.updateBusiness(bId: business.sId ?? ""),
        ctx,
        body: mm,
      );

      if (response != null) {
        ShowToast.toast(
          msg: response['message'] ?? "Business details update successfully",
          ctx: ctx,
        );
        if (imageFile.value != null || !checkSelectedImages()) {
          updateStoreImages(ctx: ctx);
        } else {
          Navigator.pop(ctx, true);
        }
      }
    } catch (e) {
      ShowToast.toast(
        msg: "$e",
        ctx: ctx,
      );
      isProcess.value = false;
    }
  }

  updateStoreImages({
    required BuildContext ctx,
  }) async {
    try {
      List<String> imageParam = [];
      List<String> imagePath = [];

      if (imageFile.value != null) {
        imageParam.add("mainImage");
        imagePath.add(imageFile.value?.path ?? "");

        if (!checkSelectedImages()) {
          for (var e in storeImageList) {
            if (e != null) {
              imageParam.add("storeImages");
              imagePath.add(e.path);
            }
          }
        }
      } else {
        for (var e in storeImageList) {
          if (e != null) {
            imageParam.add("storeImages");
            imagePath.add(e.path);
          }
        }
      }
      var response = await ApiService.multipartApi(
        Apis.updateImages(bId: business.sId ?? ""),
        ctx,
        imageParam,
        imagePath,
        method: 'PUT',
      );

      if (response != null) {
        ShowToast.toast(
          msg: response['message'] ?? "Images updated successfully",
          ctx: ctx,
        );

        Navigator.pop(ctx, true);
        isProcess.value = false;
      } else {
        isProcess.value = false;
      }
    } catch (e) {
      isProcess.value = false;
    }
  }

  bool checkSelectedImages() {
    bool error = true;
    for (var e in storeImageList) {
      if (e != null) {
        error = false;
      }
    }
    return error;
  }

  deleteMultipleImage({required BuildContext ctx}) async {
    try {
      var response = await ApiService.deleteApiBody(
        Apis.deleteImages(bId: business.sId ?? ""),
        ctx,
        {
          "menuImages": [],
          "storeImages": imageIdList,
        },
      );

      if (response != null) {
        ShowToast.toast(
          msg: response['message'] ?? "Images delete successfully",
          ctx: ctx,
        );
        List<MainImageId> idd = List.from(business.storeImages!);
        for (var e in business.storeImages!) {
          if (imageIdList.contains((e.sId ?? ""))) {
            idd.remove(e);
          }
        }
        business.storeImages = idd;
        imageIdList.clear();
      }
      isDelete.value = false;
      isProcess.value = false;
    } catch (e) {
      ShowToast.toast(
        msg: "$e",
        ctx: ctx,
      );
      isDelete.value = false;
      isProcess.value = false;
    }
  }
}
