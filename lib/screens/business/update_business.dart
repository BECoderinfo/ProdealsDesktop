import 'package:pro_deals_admin/utils/imports.dart';
import 'package:flutter/material.dart' show Icons;

class UpdateBusiness extends GetView<UpdateBusinessController> {
  final AllBusinessModel business;

  const UpdateBusiness({
    super.key,
    required this.business,
  });

  @override
  Widget build(BuildContext context) {
    double hit = MediaQuery.of(context).size.height;
    double wid = MediaQuery.of(context).size.width;
    return GetBuilder<UpdateBusinessController>(
      init: UpdateBusinessController(
        ctx: context,
        business: business,
      ),
      builder: (controller) {
        return NavigationView(
          key: controller.updateBusinessKey,
          appBar: NavigationAppBar(
            backgroundColor: AppColor.bgColor,
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon: const Icon(
                FluentIcons.back,
                size: 15.0,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              "Update Business",
              style: AppTextStyle.mediumStyle(
                color: AppColor.white,
                size: 20,
              ),
            ),
          ),
          content: Container(
            height: hit,
            width: wid,
            color: AppColor.white,
            child: PageView(
              controller: controller.p,
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    children: [
                      Container(
                        width: wid / 3,
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: AppColor.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(0, 2),
                              blurRadius: 4,
                              color: AppColor.black.withOpacity(0.5),
                            )
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Business Information',
                                  style: AppTextStyle.boldStyle(
                                    color: AppColor.smokyBlack,
                                    size: 22,
                                  ),
                                ),
                              ],
                            ),
                            const Gap(10),
                            controller.summaryWidget(
                              title: "Main Image",
                              content: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Obx(
                                    () => CircleAvatar(
                                      radius: 55,
                                      backgroundColor:
                                          AppColor.primary.withOpacity(0.5),
                                      child: Stack(
                                        children: [
                                          (controller.imageFile.value != null)
                                              ? ClipOval(
                                                  child: Image.file(
                                                    controller.imageFile.value!,
                                                    fit: BoxFit.cover,
                                                    height: 110,
                                                    width: 110,
                                                  ),
                                                )
                                              : !(business.mainImage?.data
                                                              ?.data ??
                                                          [])
                                                      .isImage()
                                                  ? ClipOval(
                                                      child: Image.memory(
                                                        Uint8List.fromList(
                                                            business.mainImage!
                                                                .data!.data!),
                                                        fit: BoxFit.cover,
                                                        height: 110,
                                                        width: 110,
                                                      ),
                                                    )
                                                  : const Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Icon(
                                                        Icons.person,
                                                        color:
                                                            AppColor.smokyBlack,
                                                      ),
                                                    ),
                                          Positioned(
                                            bottom: 5,
                                            right: 5,
                                            child: GestureDetector(
                                              onTap: () async {
                                                FilePickerResult? result =
                                                    await FilePicker.platform
                                                        .pickFiles(
                                                  type: FileType.image,
                                                );

                                                if (result != null) {
                                                  controller.imageFile.value =
                                                      File(result
                                                          .files.single.path!);
                                                }
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(8),
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
                                  )
                                ],
                              ),
                            ),
                            const Gap(10),
                            controller.summaryWidget(
                              title: "Business name",
                              content: Column(
                                children: [
                                  const Gap(5),
                                  Obx(
                                    () => TextBoxCustom(
                                      placeholder: "Business name",
                                      controller: controller.nameController,
                                      errorText: controller.nameError.value,
                                      onChange: (value) {
                                        if (value.isNotEmpty &&
                                            controller.nameError.value !=
                                                null) {
                                          controller.nameError.value = null;
                                        }
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const Gap(10),
                            controller.summaryWidget(
                              title: "Business contact number",
                              content: Column(
                                children: [
                                  const Gap(5),
                                  Obx(
                                    () => TextBoxCustom(
                                      placeholder: "Contact number",
                                      controller: controller.contactController,
                                      errorText: controller.contactError.value,
                                      onChange: (value) {
                                        if (value.isNotEmpty &&
                                            controller.contactError.value !=
                                                null) {
                                          controller.contactError.value = null;
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Gap(10),
                            controller.summaryWidget(
                              title: "Business Category",
                              content: Column(
                                children: [
                                  const Gap(5),
                                  Obx(
                                    () => controller.isLoaded.value
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Gap(5),
                                              FluentTheme(
                                                data: FluentThemeData.light(),
                                                child: ComboBox<String>(
                                                  value: controller
                                                      .selectedCategory.value,
                                                  style:
                                                      AppTextStyle.mediumStyle(
                                                    color: Colors.black,
                                                    size: 15,
                                                  ),
                                                  placeholder: const Text(
                                                      "Select Category"),
                                                  items: controller.category
                                                      .map((e) {
                                                    return ComboBoxItem(
                                                      value: e,
                                                      child: Text(e),
                                                    );
                                                  }).toList(),
                                                  onChanged: (value) {
                                                    if (value == null) return;
                                                    controller.selectedCategory
                                                        .value = value;
                                                    if (controller.categoryError
                                                            .value !=
                                                        null) {
                                                      controller.categoryError
                                                          .value = null;
                                                    }
                                                  },
                                                ),
                                              ),
                                              if (controller
                                                      .categoryError.value !=
                                                  null)
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8.0),
                                                  child: Text(
                                                    controller.categoryError
                                                            .value ??
                                                        "",
                                                    style: AppTextStyle
                                                        .regularStyle(
                                                      color: Colors.red,
                                                      size: 12,
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          )
                                        : CustomCircularIndicator.indicator(
                                            color1:
                                                Colors.white.withOpacity(0.25),
                                            color: AppColor.primary,
                                          ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: wid / 3,
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: AppColor.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(0, 2),
                              blurRadius: 4,
                              color: AppColor.black.withOpacity(0.5),
                            )
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Business Address Information',
                                  style: AppTextStyle.boldStyle(
                                    color: AppColor.smokyBlack,
                                    size: 22,
                                  ),
                                ),
                              ],
                            ),
                            const Gap(10),
                            controller.summaryWidget(
                              title: "Address",
                              content: Column(
                                children: [
                                  const Gap(5),
                                  Obx(
                                    () => TextBoxCustom(
                                      controller: controller.addressController,
                                      placeholder: "Address",
                                      errorText: controller.addressError.value,
                                      onChange: (value) {
                                        if (value.isNotEmpty &&
                                            controller.addressError.value !=
                                                null) {
                                          controller.addressError.value = null;
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Gap(10),
                            controller.summaryWidget(
                              title: "City name",
                              content: Obx(
                                () => controller.isLoaded.value
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Gap(5),
                                          FluentTheme(
                                            data: FluentThemeData.light(),
                                            child: ComboBox<String>(
                                              value:
                                                  controller.selectedCity.value,
                                              style: AppTextStyle.mediumStyle(
                                                color: Colors.black,
                                                size: 15,
                                              ),
                                              placeholder:
                                                  const Text("Select city"),
                                              items: controller.city.map((e) {
                                                return ComboBoxItem(
                                                  value: e,
                                                  child: Text(e),
                                                );
                                              }).toList(),
                                              onChanged: (value) {
                                                if (value == null) return;
                                                controller.selectedCity.value =
                                                    value;
                                                if (controller
                                                        .cityError.value !=
                                                    null) {
                                                  controller.cityError.value =
                                                      null;
                                                }
                                              },
                                            ),
                                          ),
                                          if (controller.cityError.value !=
                                              null)
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0),
                                              child: Text(
                                                controller.cityError.value ??
                                                    "",
                                                style:
                                                    AppTextStyle.regularStyle(
                                                  color: Colors.red,
                                                  size: 12,
                                                ),
                                              ),
                                            ),
                                        ],
                                      )
                                    : CustomCircularIndicator.indicator(
                                        color1: Colors.white.withOpacity(0.25),
                                        color: AppColor.primary,
                                      ),
                              ),
                            ),
                            const Gap(10),
                            controller.summaryWidget(
                              title: "State name",
                              content: Column(
                                children: [
                                  const Gap(5),
                                  Obx(
                                    () => TextBoxCustom(
                                      controller: controller.stateController,
                                      placeholder: "State name",
                                      errorText: controller.stateError.value,
                                      onChange: (value) {
                                        if (value.isNotEmpty &&
                                            controller.stateError.value !=
                                                null) {
                                          controller.stateError.value = null;
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Gap(10),
                            controller.summaryWidget(
                              title: "Pin code",
                              content: Column(
                                children: [
                                  const Gap(5),
                                  Obx(
                                    () => TextBoxCustom(
                                      controller: controller.pinCodeController,
                                      placeholder: "Ex: 000000",
                                      errorText: controller.pinCodeError.value,
                                      onChange: (value) {
                                        if (value.isNotEmpty &&
                                            controller.pinCodeError.value !=
                                                null) {
                                          controller.pinCodeError.value = null;
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Gap(20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                FilledButton(
                                  onPressed: () {
                                    controller.checkValidation(ctx: context);
                                  },
                                  style: ButtonStyle(
                                    backgroundColor: WidgetStateProperty.all(
                                      AppColor.btnGreenColor,
                                    ),
                                  ),
                                  child: Text(
                                    'Next',
                                    style: AppTextStyle.mediumStyle(
                                      color: AppColor.white,
                                      size: 17,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    children: [
                      Container(
                        width: wid / 3,
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: AppColor.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(0, 2),
                              blurRadius: 4,
                              color: AppColor.black.withOpacity(0.5),
                            )
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Business Profession Profile',
                                  style: AppTextStyle.boldStyle(
                                    color: AppColor.smokyBlack,
                                    size: 22,
                                  ),
                                ),
                              ],
                            ),
                            const Gap(10),
                            controller.summaryWidget(
                              title: "Area in SQFT",
                              content: Column(
                                children: [
                                  const Gap(5),
                                  Obx(
                                    () => TextBoxCustom(
                                      controller: controller.areaController,
                                      placeholder: "Ex: 000",
                                      errorText: controller.areaError.value,
                                      onChange: (value) {
                                        if (value.isNotEmpty &&
                                            controller.areaError.value !=
                                                null) {
                                          if (!GetUtils.isNumericOnly(value)) {
                                            return;
                                          }
                                          controller.areaError.value = null;
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Gap(10),
                            Row(
                              children: [
                                Expanded(
                                  child: controller.summaryWidget(
                                    title: "Open time",
                                    content: Column(
                                      children: [
                                        const Gap(5),
                                        Obx(
                                          () => TextBoxCustom(
                                            onTap: () async {
                                              controller.timePickerDialog(
                                                ctx: context,
                                                type: 1,
                                                title: "Open time",
                                              );
                                            },
                                            readOnly: true,
                                            controller:
                                                controller.openTimeController,
                                            placeholder: "00:00 AA",
                                            errorText:
                                                controller.openTimeError.value,
                                            onChange: (value) {},
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const Gap(20),
                                Expanded(
                                  child: controller.summaryWidget(
                                    title: "Close time",
                                    content: Column(
                                      children: [
                                        const Gap(5),
                                        Obx(
                                          () => TextBoxCustom(
                                            onTap: () {
                                              controller.timePickerDialog(
                                                ctx: context,
                                                type: 2,
                                                title: "Close time",
                                              );
                                            },
                                            readOnly: true,
                                            controller:
                                                controller.closeTimeController,
                                            placeholder: "00:00 BB",
                                            errorText:
                                                controller.closeTimeError.value,
                                            onChange: (value) {},
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Gap(10),
                            controller.summaryWidget(
                              title: "Close days",
                              content: Obx(
                                () => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Gap(5),
                                    FluentTheme(
                                      data: FluentThemeData.light(),
                                      child: ComboBox<String>(
                                        value: controller.selectedOffDays.value,
                                        style: AppTextStyle.mediumStyle(
                                          color: Colors.black,
                                          size: 15,
                                        ),
                                        placeholder:
                                            const Text("Select close days"),
                                        items: controller.daysOfWeek.map((e) {
                                          return ComboBoxItem(
                                            value: e,
                                            child: Text(e),
                                          );
                                        }).toList(),
                                        onChanged: (value) {
                                          if (value == null) return;
                                          controller.selectedOffDays.value =
                                              value;
                                          if (controller.offDaysError.value !=
                                              null) {
                                            controller.offDaysError.value =
                                                null;
                                          }
                                        },
                                      ),
                                    ),
                                    if (controller.offDaysError.value != null)
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Text(
                                          controller.offDaysError.value ?? "",
                                          style: AppTextStyle.regularStyle(
                                            color: Colors.red,
                                            size: 12,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                            const Gap(10),
                            controller.summaryWidget(
                              title: "Description",
                              content: Column(
                                children: [
                                  const Gap(5),
                                  Obx(
                                    () => TextBoxCustom(
                                      controller:
                                          controller.descriptionController,
                                      placeholder: "Enter description",
                                      errorText:
                                          controller.descriptionError.value,
                                      maxline: 5,
                                      onChange: (value) {
                                        if (value.isNotEmpty &&
                                            controller.descriptionError.value !=
                                                null) {
                                          controller.descriptionError.value =
                                              null;
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        width: 381,
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: AppColor.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(0, 2),
                              blurRadius: 4,
                              color: AppColor.black.withOpacity(0.5),
                            )
                          ],
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Business Images',
                                  style: AppTextStyle.boldStyle(
                                    color: AppColor.smokyBlack,
                                    size: 22,
                                  ),
                                ),
                              ],
                            ),
                            const Gap(10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                controller.imagePickerWidget(index: 0),
                                const Gap(10),
                                controller.imagePickerWidget(index: 1),
                                const Gap(10),
                                controller.imagePickerWidget(index: 2),
                              ],
                            ),
                            const Gap(10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                controller.imagePickerWidget(index: 3),
                                const Gap(10),
                                controller.imagePickerWidget(index: 4),
                                const Gap(10),
                                controller.imagePickerWidget(index: 5),
                              ],
                            ),
                            const Gap(20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Obx(
                                  () => controller.isProcess.value
                                      ? CustomCircularIndicator.indicator(
                                          color: AppColor.primary,
                                          color1:
                                              Colors.white.withOpacity(0.25),
                                        )
                                      : controller.isDelete.value
                                          ? controller.imageIdList.isEmpty
                                              ? const Gap(0)
                                              : Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    FilledButton(
                                                      onPressed: () {
                                                        controller.isDelete
                                                            .value = false;
                                                        controller.imageIdList
                                                            .clear();
                                                      },
                                                      style: ButtonStyle(
                                                        backgroundColor:
                                                            WidgetStateProperty
                                                                .all(
                                                          AppColor
                                                              .btnGreenColor,
                                                        ),
                                                      ),
                                                      child: Text(
                                                        'Cancel',
                                                        style: AppTextStyle
                                                            .mediumStyle(
                                                          color: AppColor.white,
                                                          size: 17,
                                                        ),
                                                      ),
                                                    ),
                                                    const Gap(10),
                                                    FilledButton(
                                                      onPressed: () {
                                                        controller.isProcess
                                                            .value = true;
                                                        controller
                                                            .deleteMultipleImage(
                                                          ctx: context,
                                                        );
                                                      },
                                                      style: ButtonStyle(
                                                        backgroundColor:
                                                            WidgetStateProperty
                                                                .all(
                                                          AppColor.btnRedColor,
                                                        ),
                                                      ),
                                                      child: Text(
                                                        'Delete Images',
                                                        style: AppTextStyle
                                                            .mediumStyle(
                                                          color: AppColor.white,
                                                          size: 17,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                          : FilledButton(
                                              onPressed: () {
                                                controller.checkValidation1(
                                                    ctx: context);
                                              },
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    WidgetStateProperty.all(
                                                  AppColor.btnGreenColor,
                                                ),
                                              ),
                                              child: Text(
                                                'Update Business',
                                                style: AppTextStyle.mediumStyle(
                                                  color: AppColor.white,
                                                  size: 17,
                                                ),
                                              ),
                                            ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
