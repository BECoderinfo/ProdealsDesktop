import '../../utils/imports.dart';

class ManageFoodTypeController extends GetxController {
  final BuildContext ctx;

  ManageFoodTypeController({required this.ctx});

  RxBool isProcess = false.obs;
  RxString id = "".obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getFoodType();
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
      getCity();
    } catch (e) {
      isFoodTypeError.value = false;

      GFToast.showToast(e.toString(), ctx);
    }
  }

  clearFields() {
    nameController.text = "";
    nameError.value = "";
    selectedFoodType.value = null;
    foodTypeImageFile.value = null;
    foodTypeError.value = "";
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
    foodTypeError.value = "";
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

  TextEditingController nameController = TextEditingController();
  RxString nameError = "".obs;

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

  RxList<CityListModel> cityList = <CityListModel>[].obs;

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
    } catch (e) {}
  }
}
