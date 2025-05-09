import 'package:pro_deals_admin/utils/imports.dart';

class ManageCmsController extends GetxController {
  final BuildContext ctx;

  ManageCmsController({required this.ctx});

  RxInt currentIndex = 0.obs;
  RxBool isProcess = false.obs;
  RxString id = "".obs;

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

  List<String> role = [
    "Staff",
    "Other",
  ];
  Rxn<String?> selectedRole = Rxn<String?>();
  RxString roleError = "".obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAllData();
  }

  getAllData() async {
    await getCMS();
    await getCity();
    await getFoodType();
    await getCategory();
  }

  RxList<StaffListModel> staffList = <StaffListModel>[].obs;
  RxBool isStaffLoaded = false.obs;
  RxBool isStaffError = false.obs;

  getCMS() async {
    try {
      var response = await ApiService.getApi(
        Apis.getAllStaff,
        ctx,
      );

      if (response != null) {
        staffList.clear();
        if (response['staff'] is List && response['staff'].isNotEmpty) {
          response['staff']
              .map((e) => staffList.add(StaffListModel.fromJson(e)))
              .toList();
        }
      }
      isStaffLoaded.value = true;
    } catch (e) {
      isStaffError.value = false;

      GFToast.showToast(e.toString(), ctx);
    }
  }

  RxList<FoodTypeListModel> foodTypeList = <FoodTypeListModel>[].obs;
  RxBool isFoodTypeLoaded = false.obs;
  RxBool isFoodTypeError = false.obs;

  getFoodType() async {
    try {
      var response = await ApiService.getApi(
        Apis.getAllFoodType,
        ctx,
      );

      if (response != null) {
        foodTypeList.clear();
        if (response is List && response.isNotEmpty) {
          response
              .map((e) => foodTypeList.add(FoodTypeListModel.fromJson(e)))
              .toList();
        }
      }
      isFoodTypeLoaded.value = true;
    } catch (e) {
      isFoodTypeError.value = false;

      GFToast.showToast(e.toString(), ctx);
    }
  }

  RxList<CityListModel> cityList = <CityListModel>[].obs;
  RxBool isCityLoaded = false.obs;
  RxBool isCityError = false.obs;

  getCity() async {
    try {
      var response = await ApiService.getApi(
        Apis.getAllCity,
        ctx,
      );

      if (response != null) {
        cityList.clear();
        if (response['citys'] is List && response['citys'].isNotEmpty) {
          response['citys']
              .map((e) => cityList.add(CityListModel.fromJson(e)))
              .toList();
        }
      }
      isCityLoaded.value = true;
    } catch (e) {
      isCityError.value = false;

      GFToast.showToast(e.toString(), ctx);
    }
  }

  RxList<CategoryListModel> categoryList = <CategoryListModel>[].obs;
  RxBool isCategoryLoaded = false.obs;
  RxBool isCategoryError = false.obs;

  getCategory() async {
    try {
      var response = await ApiService.getApi(
        Apis.getAllCategory,
        ctx,
      );

      if (response != null) {
        categoryList.clear();
        if (response is List && response.isNotEmpty) {
          response
              .map((e) => categoryList.add(CategoryListModel.fromJson(e)))
              .toList();
        }
      }
      isCategoryLoaded.value = true;
    } catch (e) {
      isCategoryError.value = false;

      GFToast.showToast(e.toString(), ctx);
    }
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  RxString nameError = "".obs;
  RxString emailError = "".obs;
  RxString phoneError = "".obs;

  showStaffAddUpdateDialog({
    required String title,
    required BuildContext ctx,
    String isEdit = "",
  }) {
    showDialog(
      context: ctx,
      builder: (context) {
        return FluentTheme(
          data: FluentThemeData.light(),
          child: ContentDialog(
            title: Text(
              title,
              style: AppTextStyle.semiBoldStyle(
                color: AppColor.black,
                size: 18,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => TextBoxCustom(
                    controller: nameController,
                    placeholder: "Enter name",
                    errorText: nameError.value.isEmpty ? null : nameError.value,
                    onChange: (value) {
                      if (value.isNotEmpty && nameError.value.isNotEmpty) {
                        nameError.value = "";
                      }
                    },
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.25),
                      ),
                    ),
                  ),
                ),
                const Gap(10),
                Obx(
                  () => TextBoxCustom(
                    controller: phoneController,
                    placeholder: "Enter phone number",
                    errorText:
                        phoneError.value.isEmpty ? null : phoneError.value,
                    onChange: (value) {
                      if (value.isNotEmpty && phoneError.value.isNotEmpty) {
                        phoneError.value = "";
                      }
                    },
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.25),
                      ),
                    ),
                  ),
                ),
                const Gap(10),
                Obx(
                  () => TextBoxCustom(
                    controller: emailController,
                    placeholder: "Enter email",
                    readOnly: isEdit.isNotEmpty,
                    onTap: () {
                      if (isEdit.isNotEmpty) {
                        ShowToast.toast(
                          msg: "You can't edit email address",
                          ctx: ctx,
                        );
                      }
                    },
                    errorText:
                        emailError.value.isEmpty ? null : emailError.value,
                    onChange: (value) {
                      if (value.isNotEmpty && emailError.value.isNotEmpty) {
                        emailError.value = "";
                      }
                    },
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.25),
                      ),
                    ),
                  ),
                ),
                const Gap(10),
                isEdit.isNotEmpty
                    ? const Gap(0)
                    : Obx(
                        () => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FluentTheme(
                              data: FluentThemeData.light(),
                              child: ComboBox<String>(
                                value: selectedRole.value,
                                style: AppTextStyle.mediumStyle(
                                  color: Colors.black,
                                  size: 15,
                                ),
                                items: role.map((e) {
                                  return ComboBoxItem(
                                    value: e,
                                    child: Text(e),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  if (value == null) return;
                                  selectedRole.value = value;
                                },
                              ),
                            ),
                            if (roleError.value.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  roleError.value,
                                  style: AppTextStyle.regularStyle(
                                    color: Colors.red,
                                    size: 12,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
              ],
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
              Obx(
                () => isProcess.value
                    ? CustomCircularIndicator.indicator(
                        color1: Colors.grey.withOpacity(0.5),
                        color: AppColor.black,
                      )
                    : Button(
                        style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.resolveWith((states) {
                            if (states.isHovered) {
                              return AppColor.btnGreenColor.withOpacity(0.5);
                            }
                            return AppColor.btnGreenColor;
                          }),
                        ),
                        child: Text(
                          isEdit.isNotEmpty ? 'Update staff' : 'Add staff',
                          style: AppTextStyle.mediumStyle(
                            color: AppColor.white,
                            size: 15,
                          ),
                        ),
                        onPressed: () {
                          clearError();
                          if (isEdit.isNotEmpty) {
                            if (nameController.text.isEmpty ||
                                emailController.text.isEmpty ||
                                phoneController.text.isEmpty ||
                                !GetUtils.isEmail(emailController.text) ||
                                !RegExp(r'^[0-9]{10}$')
                                    .hasMatch(phoneController.text)) {
                              if (nameController.text.isEmpty) {
                                nameError.value = "Please enter name";
                              }
                              if (phoneController.text.isEmpty) {
                                phoneError.value = "Please enter phone number";
                              } else if (!RegExp(r'^[0-9]{10}$')
                                  .hasMatch(phoneController.text)) {
                                phoneError.value =
                                    "Please enter valid 10 digit phone number";
                              }
                              if (emailController.text.isEmpty) {
                                emailError.value = "Please enter email address";
                              } else if (!GetUtils.isEmail(
                                  emailController.text)) {
                                emailError.value =
                                    "Please enter valid email address";
                              }
                            } else {
                              isProcess.value = true;
                              updateApiCall(
                                ctx: ctx,
                                body: {
                                  "name": nameController.text,
                                  "phone": phoneController.text,
                                },
                                url: Apis.updateStaff(
                                  uId: isEdit,
                                ),
                                message: "Staff updated successfully.",
                                onCall: () {
                                  getCMS();
                                },
                              );
                            }
                          } else {
                            if (nameController.text.isEmpty ||
                                emailController.text.isEmpty ||
                                phoneController.text.isEmpty ||
                                selectedRole.value == null ||
                                !GetUtils.isEmail(emailController.text) ||
                                !RegExp(r'^[0-9]{10}$')
                                    .hasMatch(phoneController.text)) {
                              if (nameController.text.isEmpty) {
                                nameError.value = "Please enter name";
                              }
                              if (selectedRole.value == null) {
                                roleError.value = "Please select role";
                              }
                              if (phoneController.text.isEmpty) {
                                phoneError.value = "Please enter phone number";
                              } else if (!RegExp(r'^[0-9]{10}$')
                                  .hasMatch(phoneController.text)) {
                                phoneError.value =
                                    "Please enter valid 10 digit phone number";
                              }
                              if (emailController.text.isEmpty) {
                                emailError.value = "Please enter email address";
                              } else if (!GetUtils.isEmail(
                                  emailController.text)) {
                                emailError.value =
                                    "Please enter valid email address";
                              }
                            } else {
                              isProcess.value = true;
                              addApiCall(
                                ctx: ctx,
                                body: {
                                  "name": nameController.text,
                                  "phone": phoneController.text,
                                  "email": emailController.text,
                                  "role":
                                      (selectedRole.value ?? "").toLowerCase()
                                },
                                url: Apis.addStaff,
                                message: "Staff added successfully.",
                                onCall: () {
                                  getCMS();
                                },
                              );
                            }
                          }
                        },
                      ),
              ),
            ],
          ),
        );
      },
      barrierDismissible: true,
    ).then(
      (value) => clearFields(),
    );
  }

  clearFields() {
    nameController.text = "";
    emailController.text = "";
    phoneController.text = "";
    nameError.value = "";
    emailError.value = "";
    phoneError.value = "";
    selectedRole.value = null;
    selectedFoodType.value = null;
    foodTypeImageFile.value = null;
    foodTypeError.value = "";
    categoryIconFile.value = null;
    categoryImageFile.value = null;
  }

  updateApiCall({
    required Uri url,
    required Map<String, String> body,
    required VoidCallback onCall,
    required String message,
    required BuildContext ctx,
    bool isImage = false,
    dynamic imagePath,
    dynamic imageParam,
    dynamic method,
  }) async {
    try {
      var response;

      if (isImage) {
        response = await ApiService.multipartApi(
          url,
          ctx,
          imageParam,
          imagePath,
          method: method,
          body: body,
        );
      } else {
        response = await ApiService.putApi(
          url,
          ctx,
          body: body,
        );
      }

      if (response != null) {
        ShowToast.toast(
          msg: response['message'] ?? message,
          ctx: ctx,
        );
        Navigator.pop(ctx);
        onCall();
      }
      isProcess.value = false;
    } catch (e) {
      isProcess.value = false;

      GFToast.showToast(e.toString(), ctx);
    }
  }

  addApiCall({
    required Uri url,
    required Map<String, String> body,
    required VoidCallback onCall,
    required String message,
    required BuildContext ctx,
  }) async {
    try {
      var response = await ApiService.postApi(
        url,
        ctx,
        body: body,
      );

      if (response != null) {
        ShowToast.toast(
          msg: response['message'] ?? message,
          ctx: ctx,
        );
        Navigator.pop(ctx);
        onCall();
      }
      isProcess.value = false;
    } catch (e) {
      isProcess.value = false;

      GFToast.showToast(e.toString(), ctx);
    }
  }

  showDeleteDialog({
    required BuildContext ctx,
    required String title,
    required String id,
    required String content,
    required Uri url,
    required String message,
    required VoidCallback onCall,
  }) {
    showDialog(
      context: ctx,
      builder: (context) {
        return FluentTheme(
          data: FluentThemeData.light().copyWith(),
          child: ContentDialog(
            title: Text(
              title,
              style: AppTextStyle.semiBoldStyle(
                color: AppColor.black,
                size: 18,
              ),
            ),
            content: Text(
              content,
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
                  this.id.value = id;
                  isProcess.value = true;
                  deleteApiCall(
                    url: url,
                    onCall: onCall,
                    message: message,
                    ctx: ctx,
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  deleteApiCall({
    required Uri url,
    required VoidCallback onCall,
    required String message,
    required BuildContext ctx,
  }) async {
    try {
      var response = await ApiService.deleteApi(
        url,
        ctx,
      );

      if (response != null) {
        ShowToast.toast(
          msg: response['message'] ?? message,
          ctx: ctx,
        );
        onCall();
      }
      isProcess.value = false;
    } catch (e) {
      isProcess.value = false;

      GFToast.showToast(e.toString(), ctx);
    }
  }

  clearError() {
    nameError.value = "";
    emailError.value = "";
    phoneError.value = "";
    nameError.value = "";
    emailError.value = "";
    phoneError.value = "";
    foodTypeError.value = "";
  }

  showDetailDialog({
    required BuildContext ctx,
    required String title,
    required Widget content,
  }) {
    showDialog(
      context: ctx,
      barrierDismissible: true,
      builder: (context) {
        return FluentTheme(
          data: FluentThemeData.light().copyWith(),
          child: ContentDialog(
            title: Text(
              title,
              style: AppTextStyle.semiBoldStyle(
                color: AppColor.black,
                size: 22,
              ),
            ),
            content: content,
            actions: [
              Button(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.resolveWith((states) {
                    if (states.isHovered) {
                      return AppColor.btnGreenColor.withOpacity(0.5);
                    }
                    return AppColor.btnGreenColor;
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
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget showStaffDetail({required StaffListModel data}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: rowWidget(
                title: "Staff id",
                value: data.staffId ?? "",
              ),
            ),
            Expanded(
              child: rowWidget(
                title: "Name",
                value: data.name ?? "",
              ),
            ),
          ],
        ),
        const Gap(10),
        rowWidget(
          title: "Email",
          value: data.email ?? "",
        ),
        const Gap(10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: rowWidget(
                title: "Phone",
                value: data.phone ?? "",
              ),
            ),
            Expanded(
              child: rowWidget(
                title: "Role",
                value: data.role ?? "",
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget rowWidget({
    required String title,
    required String value,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyle.semiBoldStyle(
            size: 20,
            color: AppColor.tableRowTextColor,
          ),
        ),
        Text(
          value,
          style: AppTextStyle.regularStyle(
            size: 18,
            color: AppColor.tableRowTextColor,
          ),
        ),
      ],
    );
  }

  showCityAddUpdateDialog({
    required String title,
    required BuildContext ctx,
    String isEdit = "",
  }) {
    showDialog(
      context: ctx,
      builder: (context) {
        return FluentTheme(
          data: FluentThemeData.light(),
          child: ContentDialog(
            title: Text(
              title,
              style: AppTextStyle.semiBoldStyle(
                color: AppColor.black,
                size: 18,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => TextBoxCustom(
                    controller: nameController,
                    placeholder: "Enter city name",
                    errorText: nameError.value.isEmpty ? null : nameError.value,
                    onChange: (value) {
                      if (value.isNotEmpty && nameError.value.isNotEmpty) {
                        nameError.value = "";
                      }
                    },
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.25),
                      ),
                    ),
                  ),
                ),
              ],
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
              Obx(
                () => isProcess.value
                    ? CustomCircularIndicator.indicator(
                        color1: Colors.grey.withOpacity(0.5),
                        color: AppColor.black,
                      )
                    : Button(
                        style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.resolveWith((states) {
                            if (states.isHovered) {
                              return AppColor.btnGreenColor.withOpacity(0.5);
                            }
                            return AppColor.btnGreenColor;
                          }),
                        ),
                        child: Text(
                          isEdit.isNotEmpty ? 'Update city' : 'Add city',
                          style: AppTextStyle.mediumStyle(
                            color: AppColor.white,
                            size: 15,
                          ),
                        ),
                        onPressed: () {
                          clearError();
                          if (nameController.text.isEmpty) {
                            nameError.value = "Please enter city name";
                          } else {
                            if (isEdit.isNotEmpty) {
                              isProcess.value = true;
                              updateApiCall(
                                ctx: ctx,
                                body: {
                                  "Cityname": nameController.text,
                                },
                                url: Apis.updateCity(
                                  cId: isEdit,
                                ),
                                message: "City updated successfully.",
                                onCall: () {
                                  getCity();
                                },
                              );
                            } else {
                              isProcess.value = true;
                              addApiCall(
                                ctx: ctx,
                                body: {
                                  "Cityname": nameController.text,
                                },
                                url: Apis.addCity,
                                message: "City added successfully.",
                                onCall: () {
                                  getCity();
                                },
                              );
                            }
                          }
                        },
                      ),
              ),
            ],
          ),
        );
      },
      barrierDismissible: true,
    ).then(
      (value) => clearFields(),
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

  Rxn<File?> foodTypeImageFile = Rxn<File?>();
  Rxn<String?> selectedFoodType = Rxn<String?>();
  RxString foodTypeError = "".obs;

  showFoodTypeAddUpdateDialog({
    required String title,
    required BuildContext ctx,
    String isEdit = "",
    List<int>? imageData,
  }) {
    showDialog(
      context: ctx,
      builder: (context) {
        return FluentTheme(
          data: FluentThemeData.light(),
          child: ContentDialog(
            title: Text(
              title,
              style: AppTextStyle.semiBoldStyle(
                color: AppColor.black,
                size: 18,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Food type image',
                  style: AppTextStyle.mediumStyle(
                    color: AppColor.black,
                    size: 15,
                  ),
                ),
                const Gap(10),
                Obx(
                  () => Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: foodTypeImageFile.value == null
                            ? imageData != null && !imageData.isImage()
                                ? Image.memory(
                                    Uint8List.fromList(imageData),
                                    fit: BoxFit.cover,
                                    height: 120,
                                    width: 120,
                                  )
                                : Image.asset(
                                    'assets/images/default_image.png',
                                    fit: BoxFit.cover,
                                    height: 120,
                                    width: 120,
                                  )
                            : Image.file(
                                foodTypeImageFile.value!,
                                height: 120,
                                width: 120,
                                fit: BoxFit.cover,
                              ),
                      ),
                      Positioned(
                        bottom: 5,
                        right: 5,
                        child: GestureDetector(
                          onTap: () async {
                            FilePickerResult? result =
                                await FilePicker.platform.pickFiles(
                              type: FileType.image,
                            );

                            if (result != null) {
                              foodTypeImageFile.value =
                                  File(result.files.single.path!);
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
                              color: AppColor.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const Gap(15),
                Obx(
                  () => TextBoxCustom(
                    controller: nameController,
                    placeholder: "Enter food type name",
                    errorText: nameError.value.isEmpty ? null : nameError.value,
                    onChange: (value) {
                      if (value.isNotEmpty && nameError.value.isNotEmpty) {
                        nameError.value = "";
                      }
                    },
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.25),
                      ),
                    ),
                  ),
                ),
                const Gap(15),
                Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FluentTheme(
                        data: FluentThemeData.light(),
                        child: ComboBox<String>(
                          value: selectedFoodType.value,
                          style: AppTextStyle.mediumStyle(
                            color: Colors.black,
                            size: 15,
                          ),
                          placeholder: const Text("Please select city"),
                          items: cityList
                              .map(
                                (element) => element.cityname ?? "",
                              )
                              .toList()
                              .map((e) {
                            return ComboBoxItem(
                              value: e,
                              child: Text(e),
                            );
                          }).toList(),
                          onChanged: (value) {
                            if (value == null) return;
                            selectedFoodType.value = value;
                          },
                        ),
                      ),
                      if (foodTypeError.value.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            foodTypeError.value,
                            style: AppTextStyle.regularStyle(
                              color: Colors.red,
                              size: 12,
                            ),
                          ),
                        ),
                    ],
                  ),
                )
              ],
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
              Obx(
                () => isProcess.value
                    ? CustomCircularIndicator.indicator(
                        color1: Colors.grey.withOpacity(0.5),
                        color: AppColor.black,
                      )
                    : Button(
                        style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.resolveWith((states) {
                            if (states.isHovered) {
                              return AppColor.btnGreenColor.withOpacity(0.5);
                            }
                            return AppColor.btnGreenColor;
                          }),
                        ),
                        child: Text(
                          isEdit.isNotEmpty
                              ? 'Update food type'
                              : 'Add food type',
                          style: AppTextStyle.mediumStyle(
                            color: AppColor.white,
                            size: 15,
                          ),
                        ),
                        onPressed: () {
                          clearError();
                          if (isEdit.isNotEmpty) {
                            if (selectedFoodType.value == null ||
                                nameController.text.isEmpty) {
                              if (nameController.text.isEmpty) {
                                nameError.value = "Please enter food type name";
                              }

                              if (foodTypeImageFile.value == null) {
                                ShowToast.toast(
                                  msg: "Please select image",
                                  ctx: ctx,
                                );
                              }
                              if (selectedFoodType.value == null) {
                                foodTypeError.value = "Please select city";
                              }
                            } else {
                              if ((imageData ?? []).isImage()) {
                                if (foodTypeImageFile.value == null) {
                                  ShowToast.toast(
                                    msg: "Please select image",
                                    ctx: ctx,
                                  );
                                }
                              }
                              isProcess.value = true;
                              String s1 = "";
                              String s2 = "";
                              if (foodTypeImageFile.value != null) {
                                s1 = 'image';
                                s2 = foodTypeImageFile.value?.path ?? "";
                              }
                              updateApiCall(
                                ctx: ctx,
                                body: {
                                  "foodType": nameController.text,
                                  "city": "${selectedFoodType.value}"
                                },
                                url: Apis.updateFoodType(cId: isEdit),
                                message: "FoodType updated successfully.",
                                onCall: () {
                                  getFoodType();
                                },
                                isImage: true,
                                method: 'PUT',
                                imageParam: s1,
                                imagePath: s2,
                              );
                            }
                          } else {
                            if (selectedFoodType.value == null ||
                                foodTypeImageFile.value == null ||
                                nameController.text.isEmpty) {
                              if (nameController.text.isEmpty) {
                                nameError.value = "Please enter food type name";
                              }

                              if (foodTypeImageFile.value == null) {
                                ShowToast.toast(
                                  msg: "Please select image",
                                  ctx: ctx,
                                );
                              }
                              if (selectedFoodType.value == null) {
                                foodTypeError.value = "Please select city";
                              }
                            } else {
                              isProcess.value = true;
                              updateApiCall(
                                ctx: ctx,
                                body: {
                                  "foodType": nameController.text,
                                  "city": "${selectedFoodType.value}"
                                },
                                url: Apis.addFoodType,
                                message: "FoodType added successfully.",
                                onCall: () {
                                  getFoodType();
                                },
                                isImage: true,
                                method: 'POST',
                                imageParam: 'image',
                                imagePath: foodTypeImageFile.value?.path ?? "",
                              );
                            }
                          }
                        },
                      ),
              ),
            ],
          ),
        );
      },
      barrierDismissible: true,
    ).then(
      (value) => clearFields(),
    );
  }

  Rxn<File?> categoryIconFile = Rxn<File?>();
  Rxn<File?> categoryImageFile = Rxn<File?>();

  showCategoryAddUpdateDialog({
    required String title,
    required BuildContext ctx,
    String isEdit = "",
    List<List<int>>? imageData,
  }) {
    showDialog(
      context: ctx,
      builder: (context) {
        return FluentTheme(
          data: FluentThemeData.light(),
          child: ContentDialog(
            title: Text(
              title,
              style: AppTextStyle.semiBoldStyle(
                color: AppColor.black,
                size: 18,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Obx(
                      () => Column(
                        children: [
                          Text(
                            'Food type image',
                            style: AppTextStyle.mediumStyle(
                              color: AppColor.black,
                              size: 15,
                            ),
                          ),
                          const Gap(10),
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: categoryImageFile.value == null
                                    ? imageData != null &&
                                            !imageData.first.isImage()
                                        ? Image.memory(
                                            Uint8List.fromList(imageData.first),
                                            fit: BoxFit.cover,
                                            height: 120,
                                            width: 120,
                                          )
                                        : Image.asset(
                                            'assets/images/default_image.png',
                                            fit: BoxFit.cover,
                                            height: 120,
                                            width: 120,
                                          )
                                    : Image.file(
                                        categoryImageFile.value!,
                                        height: 120,
                                        width: 120,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                              Positioned(
                                bottom: 5,
                                right: 5,
                                child: GestureDetector(
                                  onTap: () async {
                                    FilePickerResult? result =
                                        await FilePicker.platform.pickFiles(
                                      type: FileType.image,
                                    );

                                    if (result != null) {
                                      categoryImageFile.value =
                                          File(result.files.single.path!);
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
                                      color: AppColor.white,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Obx(
                      () => Column(
                        children: [
                          Text(
                            'Food type icon',
                            style: AppTextStyle.mediumStyle(
                              color: AppColor.black,
                              size: 15,
                            ),
                          ),
                          const Gap(10),
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: categoryIconFile.value == null
                                    ? imageData != null &&
                                            !imageData.last.isImage()
                                        ? Image.memory(
                                            Uint8List.fromList(imageData.last),
                                            fit: BoxFit.cover,
                                            height: 120,
                                            width: 120,
                                          )
                                        : Image.asset(
                                            'assets/images/default_image.png',
                                            fit: BoxFit.cover,
                                            height: 120,
                                            width: 120,
                                          )
                                    : Image.file(
                                        categoryIconFile.value!,
                                        height: 120,
                                        width: 120,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                              Positioned(
                                bottom: 5,
                                right: 5,
                                child: GestureDetector(
                                  onTap: () async {
                                    FilePickerResult? result =
                                        await FilePicker.platform.pickFiles(
                                      type: FileType.image,
                                    );

                                    if (result != null) {
                                      categoryIconFile.value =
                                          File(result.files.single.path!);
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
                                      color: AppColor.white,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
                const Gap(15),
                Obx(
                  () => TextBoxCustom(
                    controller: nameController,
                    placeholder: "Enter category name",
                    errorText: nameError.value.isEmpty ? null : nameError.value,
                    onChange: (value) {
                      if (value.isNotEmpty && nameError.value.isNotEmpty) {
                        nameError.value = "";
                      }
                    },
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.25),
                      ),
                    ),
                  ),
                )
              ],
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
              Obx(
                () => isProcess.value
                    ? CustomCircularIndicator.indicator(
                        color1: Colors.grey.withOpacity(0.5),
                        color: AppColor.black,
                      )
                    : Button(
                        style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.resolveWith((states) {
                            if (states.isHovered) {
                              return AppColor.btnGreenColor.withOpacity(0.5);
                            }
                            return AppColor.btnGreenColor;
                          }),
                        ),
                        child: Text(
                          isEdit.isNotEmpty
                              ? 'Update food type'
                              : 'Add food type',
                          style: AppTextStyle.mediumStyle(
                            color: AppColor.white,
                            size: 15,
                          ),
                        ),
                        onPressed: () {
                          clearError();

                          if (isEdit.isNotEmpty) {
                            if ((categoryImageFile.value == null &&
                                    (imageData ?? []).first.isImage()) ||
                                (categoryIconFile.value == null &&
                                    (imageData ?? []).last.isImage()) ||
                                nameController.text.isEmpty) {
                              if (nameController.text.isEmpty) {
                                nameError.value = "Please enter food type name";
                              }

                              if (categoryImageFile.value == null) {
                                ShowToast.toast(
                                  msg: "Please select category image",
                                  ctx: ctx,
                                );
                              }

                              if (categoryIconFile.value == null) {
                                ShowToast.toast(
                                  msg: "Please select category icon",
                                  ctx: ctx,
                                );
                              }
                            } else {
                              isProcess.value = true;
                              List<String> s1 = [];
                              List<String> s2 = [];
                              if (categoryImageFile.value != null) {
                                s1.add('image');
                                s2.add(categoryImageFile.value?.path ?? "");
                              }
                              if (categoryIconFile.value != null) {
                                s1.add('icon');
                                s2.add(categoryIconFile.value?.path ?? "");
                              }
                              updateApiCall(
                                ctx: ctx,
                                body: {
                                  "category": nameController.text,
                                },
                                url: Apis.updateCategory(cId: isEdit),
                                message: "Category updated successfully.",
                                onCall: () {
                                  getCategory();
                                },
                                isImage: true,
                                method: 'PUT',
                                imageParam: s1.isEmpty ? "" : s1,
                                imagePath: s2.isEmpty ? "" : s2,
                              );
                            }
                          } else {
                            if (categoryImageFile.value == null ||
                                categoryIconFile.value == null ||
                                nameController.text.isEmpty) {
                              if (nameController.text.isEmpty) {
                                nameError.value = "Please enter category name";
                              }

                              if (categoryImageFile.value == null) {
                                ShowToast.toast(
                                  msg: "Please select category image",
                                  ctx: ctx,
                                );
                              }

                              if (categoryIconFile.value == null) {
                                ShowToast.toast(
                                  msg: "Please select category icon",
                                  ctx: ctx,
                                );
                              }
                            } else {
                              isProcess.value = true;
                              updateApiCall(
                                ctx: ctx,
                                body: {
                                  "category": nameController.text,
                                },
                                url: Apis.addCategory,
                                message: "Category added successfully.",
                                onCall: () {
                                  getCategory();
                                },
                                isImage: true,
                                method: 'POST',
                                imageParam: ['icon', 'image'],
                                imagePath: [
                                  (categoryIconFile.value?.path ?? ""),
                                  (categoryImageFile.value?.path ?? "")
                                ],
                              );
                            }
                          }
                        },
                      ),
              ),
            ],
          ),
        );
      },
      barrierDismissible: true,
    ).then(
      (value) => clearFields(),
    );
  }
}
