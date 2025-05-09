import '../../utils/imports.dart';

class ManageCategoryController extends GetxController {
  final BuildContext ctx;

  ManageCategoryController({required this.ctx});

  @override
  void onInit() {
    super.onInit();
    getCategory();
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

  RxBool isProcess = false.obs;
  RxString id = "".obs;

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
          // ignore: use_build_context_synchronously
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

  TextEditingController nameController = TextEditingController();
  RxString nameError = "".obs;

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
                              ? 'Update category'
                              : 'Add category',
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

  clearFields() {
    nameController.text = "";
    nameError.value = "";
    categoryIconFile.value = null;
    categoryImageFile.value = null;
  }

  clearError() {
    nameError.value = "";
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
}
