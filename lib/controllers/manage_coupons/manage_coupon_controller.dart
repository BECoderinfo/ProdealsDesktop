import 'package:pro_deals_admin/utils/imports.dart';
import 'package:pro_deals_admin/widgets/custom_date_picker.dart';

class ManageCouponController extends GetxController {
  final BuildContext ctx;

  ManageCouponController({required this.ctx});

  RxInt currentIndex = 0.obs;
  int no = -1;

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

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getData();
  }

  getData() async {
    await getAllCoupon();
    await getRedeemedCoupon();
  }

  RxBool isCouponLoaded = false.obs;
  RxBool isCouponError = false.obs;
  RxList<PromoListModel> promoList = <PromoListModel>[].obs;

  getAllCoupon() async {
    try {
      var response = await ApiService.getApi(
        Apis.getAllPromoCode,
        ctx,
      );

      if (response != null) {
        if (response['promocodes'] is List ||
            response['promocodes'].isNotEmpty) {
          promoList.clear();
          response['promocodes']
              .map((e) => promoList.add(PromoListModel.fromJson(e)))
              .toList();
        }
        isCouponLoaded.value = true;
      } else {
        isCouponError.value = true;
      }
    } catch (e) {
      isCouponError.value = false;

      GFToast.showToast(e.toString(), ctx);
    }
  }

  RxBool isRedeemedCouponLoaded = false.obs;
  RxBool isRedeemedCouponError = false.obs;
  RxList<RedeemedPromoListModel> redeemedCouponList =
      <RedeemedPromoListModel>[].obs;

  getRedeemedCoupon() async {
    try {
      var response = await ApiService.getApi(
        Apis.getAllRedeemedPromoCode,
        ctx,
      );

      if (response != null) {
        redeemedCouponList.clear();
        if (response['promocodes'] is List ||
            response['promocodes'].isNotEmpty) {
          response['promocodes']
              .map((e) =>
                  redeemedCouponList.add(RedeemedPromoListModel.fromJson(e)))
              .toList();
        }
        isRedeemedCouponLoaded.value = true;
      } else {
        isRedeemedCouponError.value = true;
      }
    } catch (e) {
      isRedeemedCouponError.value = false;

      GFToast.showToast(e.toString(), ctx);
    }
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

  Widget showRedeemedPromoDetail(
      {required RedeemedPromoListModel data, required int index}) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "User details",
            style: AppTextStyle.semiBoldStyle(
              size: 20,
              color: AppColor.tableRowTextColor,
            ),
          ),
          const Gap(5),
          Row(
            children: [
              Expanded(
                child: rowWidget(
                  title: "Name",
                  value: data.usedBy?[index].userId?.userName ?? "",
                ),
              ),
              const Gap(10),
              Expanded(
                child: rowWidget(
                  title: "Phone",
                  value: data.usedBy?[index].userId?.phone ?? "",
                ),
              ),
            ],
          ),
          const Gap(10),
          rowWidget(
            title: "Email",
            value: data.usedBy?[index].userId?.email ?? "",
          ),
          const Gap(10),
          Text(
            "Promo details",
            style: AppTextStyle.semiBoldStyle(
              size: 20,
              color: AppColor.tableRowTextColor,
            ),
          ),
          const Gap(5),
          Row(
            children: [
              Expanded(
                child: rowWidget(
                  title: "Code",
                  value: data.promocode ?? "",
                ),
              ),
              const Gap(10),
              Expanded(
                child: rowWidget(
                  title: "Used by",
                  value: "${data.usedBy?.length ?? "0"} users.",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget showPromoDetail({
    required PromoListModel data,
  }) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Promo details",
            style: AppTextStyle.semiBoldStyle(
              size: 20,
              color: AppColor.tableRowTextColor,
            ),
          ),
          const Gap(5),
          rowWidget(
            title: "Promocode",
            value: data.promocode ?? "",
          ),
          const Gap(10),
          Row(
            children: [
              Expanded(
                child: rowWidget(
                  title: "Created date",
                  value: DateFormat("dd MMM, yyyy").format(
                      DateTime.parse(data.updatedAt ?? "${DateTime.now()}")
                          .toLocal()),
                ),
              ),
              const Gap(10),
              Expanded(
                child: rowWidget(
                  title: "Expiry date",
                  value: DateFormat("dd MMM, yyyy").format(
                      DateTime.parse(data.expiryDate ?? "${DateTime.now()}")
                          .toLocal()),
                ),
              ),
            ],
          ),
          const Gap(10),
          Row(
            children: [
              Expanded(
                child: rowWidget(
                  title: "Discount value",
                  value:
                      "${data.discount ?? ""} ${data.discount == "Amount" ? '₹' : '%'}",
                ),
              ),
              const Gap(10),
              Expanded(
                child: rowWidget(
                  title: "Minimum order",
                  value: "${data.neededAmount ?? ""} ₹",
                ),
              ),
            ],
          ),
          const Gap(10),
          Text(
            "Usage details",
            style: AppTextStyle.semiBoldStyle(
              size: 20,
              color: AppColor.tableRowTextColor,
            ),
          ),
          const Gap(5),
          rowWidget(
            title: "Used by",
            value: "${data.usedBy?.length ?? "0"} users.",
          ),
        ],
      ),
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
            size: 18,
            color: AppColor.tableRowTextColor,
          ),
        ),
        Text(
          value,
          style: AppTextStyle.regularStyle(
            size: 16,
            color: AppColor.tableRowTextColor,
          ),
        ),
      ],
    );
  }

  TextEditingController descriptionController = TextEditingController();
  TextEditingController discountValueController = TextEditingController();
  TextEditingController orderValueController = TextEditingController();
  TextEditingController expiryDateController = TextEditingController();

  RxString descriptionError = "".obs;
  RxString discountValueError = "".obs;
  RxString orderValueError = "".obs;
  RxString expiryDateError = "".obs;

  RxBool isProcess = false.obs;

  List<String> typeList = [
    'Amount',
    'Percentage',
  ];

  Rxn<String?> selectedValueType = Rxn<String?>();
  RxString selectedValueTypeError = "".obs;

  showAddUpdateDialog({
    required BuildContext ctx,
    required String title,
    bool isEdit = false,
    PromoListModel? promocode,
  }) {
    if (isEdit) {
      descriptionController.text = promocode?.description ?? "";
      if (typeList.contains(promocode?.discountType)) {
        selectedValueType.value = promocode?.discountType;
      }
      discountValueController.text = promocode?.discount ?? "";
      orderValueController.text = promocode?.neededAmount ?? "";
      expiryDateController.text =
          (promocode?.expiryDate ?? "").substring(0, 10);
    }
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
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => TextBoxCustom(
                    controller: descriptionController,
                    placeholder: "Enter promocode description",
                    errorText: descriptionError.value.isEmpty
                        ? null
                        : descriptionError.value,
                    onChange: (value) {
                      if (value.isNotEmpty &&
                          descriptionError.value.isNotEmpty) {
                        descriptionError.value = "";
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
                          value: selectedValueType.value,
                          style: AppTextStyle.mediumStyle(
                            color: Colors.black,
                            size: 15,
                          ),
                          placeholder:
                              const Text("Please select discount type"),
                          items: typeList.map((e) {
                            return ComboBoxItem(
                              value: e,
                              child: Text(e),
                            );
                          }).toList(),
                          onChanged: (value) {
                            if (value == null) return;
                            selectedValueType.value = value;
                            selectedValueTypeError.value = "";
                          },
                        ),
                      ),
                      if (selectedValueTypeError.value.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            selectedValueTypeError.value,
                            style: AppTextStyle.regularStyle(
                              color: Colors.red,
                              size: 12,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                Obx(
                  () => selectedValueType.value != null
                      ? Column(
                          children: [
                            const Gap(15),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: TextBoxCustom(
                                    controller: orderValueController,
                                    placeholder: "Minimum order price",
                                    errorText: orderValueError.value.isEmpty
                                        ? null
                                        : orderValueError.value,
                                    onChange: (value) {
                                      if (value.isNotEmpty &&
                                          orderValueError.value.isNotEmpty) {
                                        orderValueError.value = "";
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
                                Expanded(
                                  child: TextBoxCustom(
                                    controller: discountValueController,
                                    placeholder: "Discount value",
                                    errorText: discountValueError.value.isEmpty
                                        ? null
                                        : discountValueError.value,
                                    onChange: (value) {
                                      if (value.isNotEmpty &&
                                          discountValueError.value.isNotEmpty) {
                                        discountValueError.value = "";
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
                          ],
                        )
                      : const Gap(0),
                ),
                const Gap(15),
                Obx(
                  () => TextBoxCustom(
                    onTap: () async {
                      showDialog<DateTime>(
                        context: context,
                        builder: (context) {
                          return FluentThemeWidget(
                              widget: ContentDialog(
                            title: const Text('Pick a date'),
                            content: DatePicker(
                              startDate: DateTime.now(),
                              selected: DateTime.now(),
                              onChanged: (date) {
                                if (date.toString().substring(0, 10) ==
                                    DateTime.now()
                                        .toString()
                                        .substring(0, 10)) {
                                  expiryDateController.text =
                                      date.toString().substring(0, 10);
                                  Navigator.pop(context);
                                } else if (DateTime.parse(
                                        date.toString().substring(0, 10))
                                    .isAfter(DateTime.parse(DateTime.now()
                                        .toString()
                                        .substring(0, 10)))) {
                                  expiryDateController.text =
                                      date.toString().substring(0, 10);
                                  Navigator.pop(context);
                                } else {
                                  ShowToast.toast(
                                    msg: "Please select future date",
                                    ctx: ctx,
                                  );
                                }
                              },
                            ),
                            actions: [
                              Button(
                                child: const Text('Cancel'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ));
                        },
                      );
                    },
                    readOnly: true,
                    controller: expiryDateController,
                    placeholder: "Select expiry date",
                    errorText: expiryDateError.value.isEmpty
                        ? null
                        : expiryDateError.value,
                    onChange: (value) {
                      if (value.isNotEmpty &&
                          expiryDateError.value.isNotEmpty) {
                        expiryDateError.value = "";
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
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Button(
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
                  ),
                  const Gap(15),
                  Obx(
                    () => isProcess.value
                        ? CustomCircularIndicator.indicator(
                            color1: Colors.grey.withOpacity(0.5),
                            color: AppColor.black,
                          )
                        : Expanded(
                            flex: 2,
                            child: Button(
                              style: ButtonStyle(
                                backgroundColor:
                                    WidgetStateProperty.resolveWith((states) {
                                  if (states.isHovered) {
                                    return AppColor.btnGreenColor
                                        .withOpacity(0.5);
                                  }
                                  return AppColor.btnGreenColor;
                                }),
                              ),
                              child: Text(
                                isEdit ? 'Update promocode' : 'Add promocode',
                                style: AppTextStyle.mediumStyle(
                                  color: AppColor.white,
                                  size: 15,
                                ),
                              ),
                              onPressed: () {
                                clearError();
                                bool isError = false;
                                if (descriptionController.text.isEmpty) {
                                  isError = true;
                                  descriptionError.value =
                                      "Please enter promocode description";
                                }

                                if (expiryDateController.text.isEmpty) {
                                  isError = true;
                                  expiryDateError.value =
                                      "Please select promocode expiry date";
                                }

                                if (selectedValueType.value == null) {
                                  isError = true;
                                  selectedValueTypeError.value =
                                      "Please select discount type";
                                } else if (orderValueController.text.isEmpty ||
                                    discountValueController.text.isEmpty ||
                                    !RegExp(r'^\d+(\.\d+)?$').hasMatch(
                                        discountValueController.text) ||
                                    !RegExp(r'^\d+(\.\d+)?$')
                                        .hasMatch(orderValueController.text)) {
                                  isError = true;
                                  if (orderValueController.text.isEmpty) {
                                    orderValueError.value =
                                        "Please enter order value";
                                  }
                                  if (discountValueController.text.isEmpty) {
                                    discountValueError.value =
                                        "Please enter discount value";
                                  }

                                  if (!RegExp(r'^\d+(\.\d+)?$')
                                      .hasMatch(discountValueController.text)) {
                                    discountValueError.value =
                                        "Please enter valid discount value";
                                  }
                                  if (!RegExp(r'^\d+(\.\d+)?$')
                                      .hasMatch(orderValueController.text)) {
                                    orderValueError.value =
                                        "Please enter valid order value";
                                  }
                                }

                                if (!isError) {
                                  isProcess.value = true;
                                  if (isEdit) {
                                    callUpdateApi(
                                      ctx: ctx,
                                      id: promocode?.sId ?? "",
                                    );
                                  } else {
                                    callAddApi(
                                      ctx: ctx,
                                    );
                                  }
                                }
                              },
                            ),
                          ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    ).then(
      (value) => clearValue(),
    );
  }

  clearError() {
    descriptionError.value = "";
    discountValueError.value = "";
    orderValueError.value = "";
    expiryDateError.value = "";
    selectedValueTypeError.value = "";
  }

  clearValue() {
    descriptionController.clear();
    discountValueController.clear();
    orderValueController.clear();
    expiryDateController.clear();
    descriptionError.value = "";
    discountValueError.value = "";
    orderValueError.value = "";
    expiryDateError.value = "";
    selectedValueType.value = null;
    selectedValueTypeError.value = "";
  }

  RxString id = "".obs;

  deleteOffer({required int i}) async {
    id.value = promoList[i].sId ?? "";
    try {
      var response = await ApiService.deleteApi(
        Apis.deletePromoCode(pId: id.value),
        ctx,
      );

      if (response != null) {
        promoList.removeAt(i);
        ShowToast.toast(
          msg: response['message'] ?? "Promocode deleted successfully.",
          ctx: ctx,
        );
        id.value = "";
      }
      isProcess.value = false;
    } catch (e) {
      isProcess.value = false;

      GFToast.showToast(e.toString(), ctx);
    }
  }

  callAddApi({required BuildContext ctx}) async {
    try {
      var response = await ApiService.postApi(
        Apis.createCode,
        ctx,
        body: {
          "discountType": "${selectedValueType.value}",
          "discount": discountValueController.text,
          "expiryDate": expiryDateController.text,
          "description": descriptionController.text,
          "neededAmount": orderValueController.text
        },
      );

      if (response != null) {
        ShowToast.toast(
          msg: response['message'] ?? "Promocode created successfully.",
          ctx: ctx,
        );
        Navigator.pop(ctx);
        getAllCoupon();
      }
      isProcess.value = false;
    } catch (e) {
      isProcess.value = false;

      GFToast.showToast(e.toString(), ctx);
    }
  }

  showDeleteDialog({
    required BuildContext ctx,
    required int i,
  }) {
    showDialog(
      context: ctx,
      builder: (context) {
        return FluentTheme(
          data: FluentThemeData.light().copyWith(),
          child: ContentDialog(
            title: Text(
              'Delete Promocode?',
              style: AppTextStyle.semiBoldStyle(
                color: AppColor.black,
                size: 18,
              ),
            ),
            content: Text(
              'Are you sure you want to delete this promocode? This action cannot be undone.',
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
                  deleteOffer(i: i);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  callUpdateApi({required BuildContext ctx, required id}) async {
    try {
      var response = await ApiService.putApi(
        Apis.updatePromoCode(pId: id),
        ctx,
        body: {
          "discountType": "${selectedValueType.value}",
          "discount": discountValueController.text,
          "expiryDate": expiryDateController.text,
          "description": descriptionController.text,
          "neededAmount": orderValueController.text
        },
      );

      if (response != null) {
        ShowToast.toast(
          msg: response['message'] ?? "Promo-code updated successfully.",
          ctx: ctx,
        );
        Navigator.pop(ctx);
        getAllCoupon();
      }
      isProcess.value = false;
    } catch (e) {
      isProcess.value = false;

      GFToast.showToast(e.toString(), ctx);
    }
  }
}
