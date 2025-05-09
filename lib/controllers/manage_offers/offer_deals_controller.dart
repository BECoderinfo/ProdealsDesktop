import 'package:pro_deals_admin/utils/imports.dart';
import 'package:pro_deals_admin/widgets/custom_date_picker.dart';

class ManageOfferDealsController extends GetxController {
  final BuildContext ctx;

  ManageOfferDealsController({required this.ctx});

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getData();
  }

  getData() async {
    await getOffers();
    await getBusiness();
  }

  Rxn<AllBusinessModel?> selectedBusiness = Rxn<AllBusinessModel?>();
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

  getOffers() async {
    try {
      var response = await ApiService.getApi(
        Apis.getAllOffer,
        ctx,
      );

      print(response);

      if (response != null) {
        allOffer.clear();
        if (response['offers'] is List || response['offers'].isNotEmpty) {
          response['offers']
              .map((e) => allOffer.add(OfferListModel.fromJson(e)))
              .toList();
        }
        isLoaded.value = true;
      } else {
        isError.value = true;
      }
    } catch (e) {
      isError.value = false;

      GFToast.showToast(e.toString(), ctx);
    }
  }

  RxBool isLoaded = false.obs;
  RxBool isError = false.obs;
  RxBool isProcess = false.obs;
  RxString oId = "".obs;

  RxList<OfferListModel> allOffer = <OfferListModel>[].obs;

  deleteOffer({required int i}) async {
    oId.value = allOffer[i].sId ?? "";
    try {
      var response = await ApiService.deleteApi(
        Apis.deleteOffer(oId: oId.value),
        ctx,
      );

      if (response != null) {
        allOffer.removeAt(i);
        ShowToast.toast(
          msg: response['message'] ?? "Offer deleted successfully.",
          ctx: ctx,
        );
        oId.value = "";
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
              'Delete Offer?',
              style: AppTextStyle.semiBoldStyle(
                color: AppColor.black,
                size: 18,
              ),
            ),
            content: Text(
              'Are you sure you want to delete this offer? This action cannot be undone.',
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

  TextEditingController descriptionController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  TextEditingController discountValueController = TextEditingController();
  TextEditingController expiryDateController = TextEditingController();
  RxString descriptionError = "".obs;
  RxString discountValueError = "".obs;
  RxString productPriceError = "".obs;
  RxString selectedBusinessError = "".obs;
  RxString expiryDateError = "".obs;
  List<String> typeList = [
    'Amount',
    'Percentage',
  ];
  List<String> validDays = [
    'All days',
    'Custom',
  ];
  List<String> daysList = [
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
  ];
  Rxn<String?> selectedOfferType = Rxn<String?>();
  RxString selectedOfferTypeError = "".obs;
  Rxn<String?> selectedValidDays = Rxn<String?>();
  RxString selectedValidDaysError = "".obs;
  Rxn<String?> selectedDays1 = Rxn<String?>();
  RxString selectedDays1Error = "".obs;
  Rxn<String?> selectedDays2 = Rxn<String?>();
  RxString selectedDays2Error = "".obs;

  showAddUpdateDialog({
    required BuildContext ctx,
    required String title,
    bool isEdit = false,
    OfferListModel? offer,
  }) {
    if (isEdit) {
      descriptionController.text = offer?.description ?? "";
      if (typeList.contains(offer?.offertype)) {
        selectedOfferType.value = offer?.offertype;
      }
      productPriceController.text = offer?.productPrice ?? "";
      discountValueController.text = offer?.offerPrice ?? "";
      expiryDateController.text = (offer?.expiryDate ?? "").substring(0, 10);
      setValidData(validOn: offer?.validOn ?? "");
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
                    placeholder: "Enter offer description",
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
                isEdit ? const Gap(0) : const Gap(15),
                isEdit
                    ? const Gap(0)
                    : Obx(
                        () => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FluentTheme(
                              data: FluentThemeData.light(),
                              child: ComboBox<AllBusinessModel>(
                                value: selectedBusiness.value,
                                style: AppTextStyle.mediumStyle(
                                  color: Colors.black,
                                  size: 15,
                                ),
                                placeholder:
                                    const Text("Please select business"),
                                items: allBusiness.map((e) {
                                  return ComboBoxItem(
                                    value: e,
                                    child: Text(e.businessName ?? ""),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  if (value == null) return;
                                  selectedBusiness.value = value;
                                  selectedBusinessError.value = "";
                                },
                              ),
                            ),
                            if (selectedBusinessError.value.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  selectedBusinessError.value,
                                  style: AppTextStyle.regularStyle(
                                    color: Colors.red,
                                    size: 12,
                                  ),
                                ),
                              ),
                          ],
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
                          value: selectedOfferType.value,
                          style: AppTextStyle.mediumStyle(
                            color: Colors.black,
                            size: 15,
                          ),
                          placeholder: const Text("Please select offer type"),
                          items: typeList.map((e) {
                            return ComboBoxItem(
                              value: e,
                              child: Text(e),
                            );
                          }).toList(),
                          onChanged: (value) {
                            if (value == null) return;
                            selectedOfferType.value = value;
                            selectedOfferTypeError.value = "";
                          },
                        ),
                      ),
                      if (selectedOfferTypeError.value.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            selectedOfferTypeError.value,
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
                  () => selectedOfferType.value != null
                      ? Column(
                          children: [
                            const Gap(15),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: TextBoxCustom(
                                    controller: productPriceController,
                                    placeholder: "Product price",
                                    errorText: productPriceError.value.isEmpty
                                        ? null
                                        : productPriceError.value,
                                    onChange: (value) {
                                      if (value.isNotEmpty &&
                                          productPriceError.value.isNotEmpty) {
                                        productPriceError.value = "";
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
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FluentTheme(
                        data: FluentThemeData.light(),
                        child: ComboBox<String>(
                          value: selectedValidDays.value,
                          style: AppTextStyle.mediumStyle(
                            color: Colors.black,
                            size: 15,
                          ),
                          placeholder: const Text("Select offer valid days"),
                          items: validDays.map((e) {
                            return ComboBoxItem(
                              value: e,
                              child: Text(e),
                            );
                          }).toList(),
                          onChanged: (value) {
                            if (value == null) return;
                            selectedValidDays.value = value;
                            selectedValidDaysError.value = "";
                          },
                        ),
                      ),
                      if (selectedValidDaysError.value.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            selectedValidDaysError.value,
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
                  () => selectedValidDays.value == validDays.last
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Gap(15),
                                  FluentTheme(
                                    data: FluentThemeData.light(),
                                    child: ComboBox<String>(
                                      value: selectedDays1.value,
                                      style: AppTextStyle.mediumStyle(
                                        color: Colors.black,
                                        size: 15,
                                      ),
                                      placeholder:
                                          const Text("Offer start day"),
                                      items: daysList.map((e) {
                                        return ComboBoxItem(
                                          value: e,
                                          child: Text(e),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        if (value == null) return;
                                        selectedDays1.value = value;
                                        selectedDays1Error.value = "";
                                        checkAndSwapValues();
                                      },
                                    ),
                                  ),
                                  if (selectedDays1Error.value.isNotEmpty)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        selectedDays1Error.value,
                                        style: AppTextStyle.regularStyle(
                                          color: Colors.red,
                                          size: 12,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            const Gap(10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Gap(15),
                                  FluentTheme(
                                    data: FluentThemeData.light(),
                                    child: ComboBox<String>(
                                      value: selectedDays2.value,
                                      style: AppTextStyle.mediumStyle(
                                        color: Colors.black,
                                        size: 15,
                                      ),
                                      placeholder: const Text("Offer end day"),
                                      items: daysList.map((e) {
                                        return ComboBoxItem(
                                          value: e,
                                          child: Text(e),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        if (value == null) return;
                                        selectedDays2.value = value;
                                        selectedDays2Error.value = "";
                                        checkAndSwapValues();
                                      },
                                    ),
                                  ),
                                  if (selectedDays2Error.value.isNotEmpty)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        selectedDays2Error.value,
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
                          isEdit ? 'Update offer' : 'Add offer',
                          style: AppTextStyle.mediumStyle(
                            color: AppColor.white,
                            size: 15,
                          ),
                        ),
                        onPressed: () {
                          bool isError = false;
                          if (descriptionController.text.isEmpty) {
                            isError = true;
                            descriptionError.value = "Please enter description";
                          }

                          if (expiryDateController.text.isEmpty) {
                            isError = true;
                            expiryDateError.value =
                                "Please select offer expiry date";
                          }

                          if (selectedOfferType.value == null) {
                            isError = true;
                            selectedOfferTypeError.value =
                                "Please select offer type";
                          } else if (productPriceController.text.isEmpty ||
                              discountValueController.text.isEmpty ||
                              !RegExp(r'^\d+(\.\d+)?$')
                                  .hasMatch(discountValueController.text) ||
                              !RegExp(r'^\d+(\.\d+)?$')
                                  .hasMatch(productPriceController.text)) {
                            isError = true;
                            if (productPriceController.text.isEmpty) {
                              productPriceError.value =
                                  "Please enter product price";
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
                                .hasMatch(productPriceController.text)) {
                              productPriceError.value =
                                  "Please enter valid product price";
                            }
                          } else if (selectedOfferType.value ==
                                  typeList.first &&
                              ((int.tryParse(discountValueController.text) ??
                                      double.parse(
                                          discountValueController.text)) >
                                  (int.tryParse(productPriceController.text) ??
                                      double.parse(
                                          productPriceController.text)))) {
                            isError = true;
                            discountValueError.value = "Invalid discount value";
                            discountValueController.clear();
                          }

                          if (selectedValidDays.value == null) {
                            isError = true;
                            selectedValidDaysError.value =
                                "Please select offer valid days";
                          } else if (selectedValidDays.value ==
                                  validDays.last &&
                              (selectedDays1.value == null ||
                                  selectedDays2.value == null)) {
                            isError = true;
                            if (selectedDays1.value == null) {
                              selectedDays1Error.value =
                                  "Please select offer start day";
                            }
                            if (selectedDays2.value == null) {
                              selectedDays2Error.value =
                                  "Please select offer end day";
                            }
                          }

                          if (!isEdit && selectedBusiness.value == null) {
                            selectedBusinessError.value =
                                "Please select business";
                          }

                          if (!isError) {
                            isProcess.value = true;
                            if (isEdit) {
                              callUpdateApi(
                                ctx: ctx,
                                id: offer?.sId ?? "",
                              );
                            } else {
                              callAddApi(
                                ctx: ctx,
                                bId: selectedBusiness.value?.sId ?? "",
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
    ).then(
      (value) => clearValue(),
    );
  }

  clearValue() {
    descriptionController.clear();
    productPriceController.clear();
    discountValueController.clear();
    expiryDateController.clear();
    descriptionError.value = "";
    discountValueError.value = "";
    productPriceError.value = "";
    selectedBusinessError.value = "";
    expiryDateError.value = "";
    selectedOfferType.value = null;
    selectedOfferTypeError.value = "";
    selectedValidDays.value = null;
    selectedValidDaysError.value = "";
    selectedDays1.value = null;
    selectedDays1Error.value = "";
    selectedDays2.value = null;
    selectedDays2Error.value = "";
    selectedBusiness.value = null;
    isProcess.value = false;
  }

  void checkAndSwapValues() {
    if (selectedDays1.value != null && selectedDays2.value != null) {
      int startIndex = daysList.indexOf(selectedDays1.value ?? "");
      int endIndex = daysList.indexOf(selectedDays2.value ?? "");

      if (endIndex < startIndex) {
        String temp = selectedDays1.value ?? "";
        selectedDays1.value = selectedDays2.value;
        selectedDays2.value = temp;
      }
    }
  }

  callUpdateApi({required BuildContext ctx, required String id}) async {
    try {
      String s = getValidDays();
      var response = await ApiService.putApi(
        Apis.updateOffer(oId: id),
        ctx,
        body: {
          "offertype": "${selectedOfferType.value}",
          "productPrice": productPriceController.text,
          "validOn": s,
          "offerPrice": discountValueController.text,
          "description": descriptionController.text,
          "expiryDate": expiryDateController.text,
        },
      );

      if (response != null) {
        ShowToast.toast(
          msg: response['message'] ?? "Offer updated successfully.",
          ctx: ctx,
        );
        Navigator.pop(ctx);
        getOffers();
      }
      isProcess.value = false;
    } catch (e) {
      isProcess.value = false;

      GFToast.showToast(e.toString(), ctx);
    }
  }

  callAddApi({required BuildContext ctx, required String bId}) async {
    try {
      String s = getValidDays();
      var response = await ApiService.postApi(
        Apis.addOffer,
        ctx,
        body: {
          "businessId": bId,
          "offertype": "${selectedOfferType.value}",
          "productPrice": productPriceController.text,
          "validOn": s,
          "offerPrice": discountValueController.text,
          "description": descriptionController.text,
          "expiryDate": expiryDateController.text,
        },
      );

      if (response != null) {
        ShowToast.toast(
          msg: response['message'] ?? "Offer added successfully.",
          ctx: ctx,
        );
        Navigator.pop(ctx);
        getOffers();
      }
      isProcess.value = false;
    } catch (e) {
      isProcess.value = false;

      GFToast.showToast(e.toString(), ctx);
    }
  }

  String getValidDays() {
    if (selectedValidDays.value == validDays.first) {
      return "All days";
    } else if (selectedDays1.value == selectedDays2.value) {
      return "${selectedDays1.value}".toLowerCase();
    } else {
      return "${selectedDays1.value}-${selectedDays2.value}".toLowerCase();
    }
  }

  setValidData({required String validOn}) {
    if (validOn.isEmpty) return;

    if (validOn.toLowerCase() == validDays.first.toLowerCase()) {
      selectedValidDays.value = validDays.first;
    } else {
      selectedValidDays.value = validDays.last;

      if (validOn.contains("-")) {
        selectedDays1.value = validOn.split("-").first.capitalizeFirst;
        selectedDays2.value = validOn.split("-").last.capitalizeFirst;
      } else {
        selectedDays1.value = validOn.capitalizeFirst;
        selectedDays2.value = validOn.capitalizeFirst;
      }
    }
  }

  viewDetailDialog({
    required BuildContext ctx,
    required OfferListModel offer,
  }) {
    showDialog(
      context: ctx,
      builder: (context) {
        return FluentTheme(
          data: FluentThemeData.light().copyWith(),
          child: ContentDialog(
            title: Text(
              "View offer details",
              style: AppTextStyle.semiBoldStyle(
                color: AppColor.black,
                size: 22,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                rowWidget(
                  title: "Offer description",
                  value: offer.description ?? "",
                ),
                const Gap(10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Product price: ${offer.productPrice ?? ""} ₹",
                      style: AppTextStyle.semiBoldStyle(
                        size: 18,
                        color: AppColor.tableRowTextColor,
                      ),
                    ),
                    Text(
                      "Discount value: ${offer.offerPrice ?? ""} ${offer.offertype == typeList.first ? '₹' : '%'}",
                      style: AppTextStyle.semiBoldStyle(
                        size: 18,
                        color: AppColor.tableRowTextColor,
                      ),
                    ),
                    Text(
                      "Payment amount: ${offer.paymentAmount ?? ""} ₹",
                      style: AppTextStyle.semiBoldStyle(
                        size: 18,
                        color: AppColor.tableRowTextColor,
                      ),
                    ),
                  ],
                ),
                const Gap(10),
                Row(
                  children: [
                    Expanded(
                      child: rowWidget(
                        title: "Valid on",
                        value: offer.validOn ?? "",
                      ),
                    ),
                    Expanded(
                      child: rowWidget(
                        title: "Used by",
                        value: "${offer.usedBy ?? "0"} users",
                      ),
                    ),
                  ],
                )
              ],
            ),
            actions: [
              offer.isActive ?? false
                  ? Button(
                      style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                          AppColor.btnRedColor,
                        ),
                      ),
                      onPressed: () {
                        manageOffer(
                          ctx: ctx,
                          id: offer.sId ?? "",
                          param: 0,
                        );
                      },
                      child: Text(
                        'Disable offer',
                        style: AppTextStyle.mediumStyle(
                          color: AppColor.white,
                          size: 15,
                        ),
                      ),
                    )
                  : Button(
                      style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                          AppColor.btnGreenColor,
                        ),
                      ),
                      onPressed: () {
                        manageOffer(
                          ctx: ctx,
                          id: offer.sId ?? "",
                          param: 1,
                        );
                      },
                      child: Text(
                        'Enable offer',
                        style: AppTextStyle.mediumStyle(
                          color: AppColor.white,
                          size: 15,
                        ),
                      ),
                    ),
              Button(
                style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                    AppColor.btnGreenColor,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Ok',
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

  manageOffer(
      {required BuildContext ctx,
      required String id,
      required int param}) async {
    isProcess.value = true;
    try {
      var response = await ApiService.putApi(
        Apis.manageOffer(oId: id),
        ctx,
        body: {
          "isActive": param,
        },
      );

      if (response != null) {
        ShowToast.toast(
          msg: response['message'] ??
              "Offer ${param == 0 ? 'disabled' : 'enabled'} successfully.",
          ctx: ctx,
        );
        Navigator.pop(ctx);
        getOffers();
      }
      isProcess.value = false;
    } catch (e) {
      isProcess.value = false;

      GFToast.showToast(e.toString(), ctx);
    }
  }
}
