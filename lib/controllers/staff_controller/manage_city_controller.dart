// ignore_for_file: use_build_context_synchronously

import '../../utils/imports.dart';

class ManageCityController extends GetxController {
  final BuildContext ctx;

  ManageCityController({required this.ctx});

  RxBool isProcess = false.obs;
  RxString id = "".obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getCity();
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

  TextEditingController nameController = TextEditingController();

  RxString nameError = "".obs;

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

  clearFields() {
    nameController.text = "";
    nameError.value = "";
  }

  clearError() {
    nameError.value = "";
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
}
