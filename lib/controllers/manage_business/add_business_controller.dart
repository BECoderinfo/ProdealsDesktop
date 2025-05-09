import 'package:pro_deals_admin/utils/imports.dart';

class AddBusinessController extends GetxController {
  final BuildContext ctx;

  AddBusinessController({required this.ctx});

  final createBusinessKey = GlobalKey(debugLabel: 'Create Business');

  PageController p = PageController();

  RxBool isProcess = false.obs;

  Rxn<File?> imageFile = Rxn<File?>();
  Rxn<File?> proofFile = Rxn<File?>();
  Rxn<File?> voterIdFile = Rxn<File?>();
  Rxn<File?> gvtIdFile = Rxn<File?>();
  RxList<File?> storeImageList = <File?>[].obs;

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
    await userFetch();
    isLoaded.value = true;
  }

  RxList<String> city = <String>[].obs;
  RxList<String> category = <String>[].obs;
  RxList<UserModel> userList = <UserModel>[].obs;
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
  Rxn<String?> selectedUser = Rxn<String?>();
  Rxn<String?> selectedCategory = Rxn<String?>();
  TextEditingController nameController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  TextEditingController gstController = TextEditingController();
  TextEditingController panController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController openTimeController = TextEditingController();
  TextEditingController closeTimeController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  Rxn<String?> offDaysError = Rxn<String?>();
  Rxn<String?> cityError = Rxn<String?>();
  Rxn<String?> userError = Rxn<String?>();
  Rxn<String?> categoryError = Rxn<String?>();
  Rxn<String?> nameError = Rxn<String?>();
  Rxn<String?> contactError = Rxn<String?>();
  Rxn<String?> addressError = Rxn<String?>();
  Rxn<String?> stateError = Rxn<String?>();
  Rxn<String?> pinCodeError = Rxn<String?>();
  Rxn<String?> gstError = Rxn<String?>();
  Rxn<String?> panError = Rxn<String?>();
  Rxn<String?> areaError = Rxn<String?>();
  Rxn<String?> openTimeError = Rxn<String?>();
  Rxn<String?> closeTimeError = Rxn<String?>();
  Rxn<String?> descriptionError = Rxn<String?>();

  RxBool isLoaded = false.obs;

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

  createBusinessApiCall() async {
    try {
      bool s = await adminAssignBusiness();

      if (!s) {
        ShowToast.toast(
          msg: "Something went wrong. Please try again.",
          ctx: ctx,
        );
        return;
      }
      int i = userList.indexWhere(
        (element) => element.userName == selectedUser.value?.split(" | ").first,
      );
      int i1 = userList.indexWhere(
        (element) => element.phone == selectedUser.value?.split(" | ").last,
      );

      String uId = "";
      if (i == i1) {
        uId = userList[i].id ?? "";
      } else {
        ShowToast.toast(
          msg: "Something went wrong. Please try again.",
          ctx: ctx,
        );
        return;
      }
      Map<String, String> mm = {};
      mm = {
        'userId': uId,
        'businessName': nameController.text,
        'contactNumber': contactController.text,
        'address': addressController.text,
        'state': stateController.text,
        'city': "${selectedCity.value}",
        'pincode': pinCodeController.text,
        'gstNumber': gstController.text,
        'panNumber': panController.text,
        'openTime': openTimeController.text.toLowerCase(),
        'closeTime': closeTimeController.text.toLowerCase(),
        'Description': descriptionController.text,
        'areaSqures': areaController.text,
        'category': '${selectedCategory.value}',
      };

      if (selectedOffDays.value != daysOfWeek.last) {
        mm['offDays'] = "${selectedOffDays.value}";
      }

      var response = await ApiService.multipartApi(
        Apis.createBusiness,
        ctx,
        'proofImage',
        '${proofFile.value?.path}',
        body: mm,
      );

      if (response != null) {
        uploadMainStoreImage(
          bId: response['business']['_id'] ?? "",
        );
      } else {
        isProcess.value = false;
      }
    } catch (e) {
      isProcess.value = false;
    }
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

  userFetch() async {
    try {
      var response = await ApiService.getApi(
        Apis.viewAllUser,
        ctx,
      );

      if (response != null) {
        userList.clear();
        if (response['users'] is List || response['users'].isNotEmpty) {
          response['users']
              .map((e) => userList.add(UserModel.fromJson(e)))
              .toList();
        }
      }
    } catch (e) {}
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getData();
  }

  checkValidation({required BuildContext ctx}) {
    if (imageFile.value == null) {
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
    if (selectedUser.value == null) {
      userError.value = "Please select user";
    }
    if (stateController.text.isEmpty) {
      stateError.value = "Please enter state";
    }
    if (pinCodeController.text.isEmpty) {
      pinCodeError.value = "Please enter pincode";
    } else if (!RegExp(r'^[0-9]{6}$').hasMatch(pinCodeController.text)) {
      pinCodeError.value = "Please enter valid pincode";
    }

    if (imageFile.value != null &&
        pinCodeError.value == null &&
        stateError.value == null &&
        cityError.value == null &&
        userError.value == null &&
        addressError.value == null &&
        nameError.value == null &&
        contactError.value == null) {
      p.nextPage(
        duration: const Duration(seconds: 1),
        curve: Curves.linear,
      );
    }
  }

  checkValidation1({required BuildContext ctx}) {
    openTimeError.value = null;
    closeTimeError.value = null;
    if (proofFile.value == null) {
      ShowToast.toast(
        msg: "Please select proof image",
        ctx: ctx,
      );
    }

    if (gstController.text.isEmpty) {
      gstError.value = "Please enter gst number";
    } else if (!gstController.text.isValidGSTNo()) {
      gstError.value = "Please enter valid GST number. Ex: 22ABCDE0000A0ZA";
    } else if (panController.text == '22AAAAA0000A0ZA') {
      gstError.value = "Please enter valid GST number. Ex: 22ABCDE0000A0ZA";
    }
    if (panController.text.isEmpty) {
      panError.value = "Please enter pan number";
    } else if (!panController.text.isValidPanCardNo()) {
      panError.value = "Please enter valid PAN number. Ex: ABCDE0000A";
    } else if (panController.text == 'ABCDE0000A') {
      panError.value = "Please enter valid PAN number. Ex: ABCDE0000A";
    }

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

    if (proofFile.value != null &&
        gstError.value == null &&
        panError.value == null &&
        areaError.value == null &&
        categoryError.value == null &&
        offDaysError.value == null &&
        closeTimeError.value == null &&
        descriptionError.value == null) {
      p.nextPage(
        duration: const Duration(seconds: 1),
        curve: Curves.linear,
      );
    }
  }

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
                      (index >= 0 && index < storeImageList.length)
                  ? Image.file(
                      storeImageList[index]!,
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
              child: GestureDetector(
                onTap: () async {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles(
                    type: FileType.image,
                  );

                  if (result != null) {
                    if (index >= 0 && index < storeImageList.length) {
                      storeImageList[index] = (File(result.files.single.path!));
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

  checkValidation3({required BuildContext ctx}) {
    if (gvtIdFile.value == null || voterIdFile.value == null) {
      if (gvtIdFile.value == null && voterIdFile.value == null) {
        ShowToast.toast(
          msg: "Please select document image",
          ctx: ctx,
        );
      } else if (gvtIdFile.value == null) {
        ShowToast.toast(
          msg: "Please select government id image",
          ctx: ctx,
        );
      } else if (voterIdFile.value == null) {
        ShowToast.toast(
          msg: "Please select voter id image",
          ctx: ctx,
        );
      }
    } else if (storeImageList.isEmpty || storeImageList.length == 1) {
      ShowToast.toast(
        msg: "Please select atleast 3 store images",
        ctx: ctx,
      );
    } else {
      isProcess.value = true;
      createBusinessApiCall();
    }
  }

  uploadMainStoreImage({required String bId}) async {
    try {
      var response = await ApiService.multipartApi(
        Apis.mainStoreImageUpload(bId: bId),
        ctx,
        'mainImage',
        '${imageFile.value?.path}',
      );

      if (response != null) {
        uploadVoterIdImage(
          bId: bId,
        );
      } else {
        isProcess.value = false;
      }
    } catch (e) {
      isProcess.value = false;
    }
  }

  uploadVoterIdImage({required String bId}) async {
    try {
      var response = await ApiService.multipartApi(
        Apis.voterIdImageUpload(bId: bId),
        ctx,
        'waterIdImage',
        '${voterIdFile.value?.path}',
      );

      if (response != null) {
        uploadGvtIdImage(
          bId: bId,
        );
      } else {
        isProcess.value = false;
      }
    } catch (e) {
      isProcess.value = false;
    }
  }

  uploadGvtIdImage({required String bId}) async {
    try {
      var response = await ApiService.multipartApi(
        Apis.gvtIdImageUpload(bId: bId),
        ctx,
        'govermentIdImage',
        '${gvtIdFile.value?.path}',
      );

      if (response != null) {
        uploadImages(bId: bId);
      } else {
        isProcess.value = false;
      }
    } catch (e) {
      isProcess.value = false;
    }
  }

  Future<bool> uploadStoreImage({
    required String bId,
    required String path,
  }) async {
    try {
      var response = await ApiService.multipartApi(
        Apis.storeImageUpload(bId: bId),
        ctx,
        'storeImage',
        path,
      );

      if (response != null) {
        return true;
      } else {
        isProcess.value = false;
      }
      return false;
    } catch (e) {
      isProcess.value = false;
      return false;
    }
  }

  uploadImages({required String bId}) async {
    int i = 0;

    for (var e in storeImageList) {
      dynamic d = await uploadStoreImage(
        bId: bId,
        path: e?.path ?? "",
      );

      if (d is bool && d) {
        i++;
      } else {
        isProcess.value = false;
        break;
      }
    }

    isProcess.value = false;
    if (i == storeImageList.length) {
      Navigator.pop(ctx, true);
    }
  }

  adminAssignBusiness() async {
    try {
      int i = userList.indexWhere(
        (element) => element.userName == selectedUser.value?.split(" | ").first,
      );
      int i1 = userList.indexWhere(
        (element) => element.phone == selectedUser.value?.split(" | ").last,
      );

      String uId = "";
      if (i == i1) {
        uId = userList[i].id ?? "";
      } else {
        ShowToast.toast(
          msg: "Something went wrong. Please try again.",
          ctx: ctx,
        );
        return;
      }
      var response = await ApiService.putApi(
        Apis.adminAssignBusiness(uId: uId),
        ctx,
      );

      if (response != null) {
        return true;
      }
      isProcess.value = false;
      return false;
    } catch (e) {
      isProcess.value = false;
      return false;
    }
  }
}
