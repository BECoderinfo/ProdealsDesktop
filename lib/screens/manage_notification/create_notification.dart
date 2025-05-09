import 'package:pro_deals_admin/utils/imports.dart';

class CreateNotification extends GetView<CreateNotificationController> {
  const CreateNotification({super.key});

  @override
  Widget build(BuildContext context) {
    double hit = MediaQuery.of(context).size.height;
    double wid = MediaQuery.of(context).size.width;
    return GetBuilder<CreateNotificationController>(
      init: CreateNotificationController(ctx: context),
      builder: (controller) {
        return NavigationView(
          key: controller.createNotificationKey,
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
              "Create new notification",
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
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: wid / 2.5,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(4),
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
                      Text(
                        'Notification title',
                        style: AppTextStyle.mediumStyle(
                          color: AppColor.black,
                          size: 20,
                        ),
                      ),
                      const Gap(5),
                      Obx(
                        () => TextBoxCustom(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey.withOpacity(0.25),
                            ),
                          ),
                          controller: controller.titleController,
                          placeholder: "Enter notification title",
                          errorText: controller.titleError.value.isEmpty
                              ? null
                              : controller.titleError.value,
                          onChange: (value) {
                            if (value.isNotEmpty &&
                                controller.titleError.isNotEmpty) {
                              controller.titleError.value = "";
                            }
                          },
                        ),
                      ),
                      const Gap(15),
                      Text(
                        'Notification description',
                        style: AppTextStyle.mediumStyle(
                          color: AppColor.black,
                          size: 20,
                        ),
                      ),
                      const Gap(5),
                      Obx(
                        () => TextBoxCustom(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey.withOpacity(0.25),
                            ),
                          ),
                          controller: controller.descriptionController,
                          placeholder: "Enter notification description",
                          errorText: controller.descriptionError.value.isEmpty
                              ? null
                              : controller.descriptionError.value,
                          onChange: (value) {
                            if (value.isNotEmpty &&
                                controller.descriptionError.isNotEmpty) {
                              controller.descriptionError.value = "";
                            }
                          },
                        ),
                      ),
                      const Gap(15),
                      Text(
                        'Notification type',
                        style: AppTextStyle.mediumStyle(
                          color: AppColor.black,
                          size: 20,
                        ),
                      ),
                      const Gap(5),
                      Obx(
                        () => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FluentTheme(
                              data: FluentThemeData.light(),
                              child: ComboBox<String>(
                                value: controller.selectedType.value,
                                style: AppTextStyle.mediumStyle(
                                  color: Colors.black,
                                  size: 15,
                                ),
                                placeholder: const Text("Please select type"),
                                items: controller.notificationType.map((e) {
                                  return ComboBoxItem(
                                    value: e,
                                    child: Text(e),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  if (value == null) return;
                                  controller.selectedType.value = value;
                                  controller.comboBoxError.value = "";
                                  controller.selectedOffer.value = null;
                                  controller.selectedBusiness.value = null;
                                  controller.selectedBanner.value = null;
                                },
                              ),
                            ),
                            if (controller.comboBoxError.isNotEmpty &&
                                controller.selectedType.value == null)
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  controller.comboBoxError.value,
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
                        () => (controller.selectedType.value == null ||
                                controller.selectedType.value ==
                                    controller.notificationType.first)
                            ? const Gap(0)
                            : !controller.isLoaded.value
                                ? CustomCircularIndicator.indicator(
                                    color1: Colors.grey.withOpacity(0.5),
                                    color: AppColor.black,
                                  )
                                : controller.selectedType.value ==
                                        controller.notificationType[2]
                                    ? controller.offerList.isEmpty
                                        ? Text(
                                            "Offers not found",
                                            style: AppTextStyle.boldStyle(
                                              size: 18,
                                              color: AppColor.tableRowTextColor,
                                            ),
                                          )
                                        : Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              FluentTheme(
                                                data: FluentThemeData.light(),
                                                child: ComboBox<Offers>(
                                                  value: controller
                                                      .selectedOffer.value,
                                                  style:
                                                      AppTextStyle.mediumStyle(
                                                    color: Colors.black,
                                                    size: 15,
                                                  ),
                                                  items: controller.offerList
                                                      .map((e) {
                                                    return ComboBoxItem(
                                                      value: e,
                                                      child: Text(
                                                          e.description ?? ""),
                                                    );
                                                  }).toList(),
                                                  placeholder: const Text(
                                                      "Please select offer"),
                                                  onChanged: (value) {
                                                    if (value == null) return;
                                                    controller.selectedOffer
                                                        .value = value;
                                                    controller.comboBoxError
                                                        .value = "";
                                                  },
                                                ),
                                              ),
                                              if (controller
                                                  .comboBoxError.isNotEmpty)
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8.0),
                                                  child: Text(
                                                    controller
                                                        .comboBoxError.value,
                                                    style: AppTextStyle
                                                        .regularStyle(
                                                      color: Colors.red,
                                                      size: 12,
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          )
                                    : controller.selectedType.value ==
                                            controller.notificationType[1]
                                        ? controller.allBusiness.isEmpty
                                            ? Text(
                                                "Business not found",
                                                style: AppTextStyle.boldStyle(
                                                  size: 18,
                                                  color: AppColor
                                                      .tableRowTextColor,
                                                ),
                                              )
                                            : Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  FluentTheme(
                                                    data:
                                                        FluentThemeData.light(),
                                                    child: ComboBox<
                                                        AllBusinessModel>(
                                                      value: controller
                                                          .selectedBusiness
                                                          .value,
                                                      style: AppTextStyle
                                                          .mediumStyle(
                                                        color: Colors.black,
                                                        size: 15,
                                                      ),
                                                      items: controller
                                                          .allBusiness
                                                          .map((e) {
                                                        return ComboBoxItem(
                                                          value: e,
                                                          child: Text(
                                                              e.businessName ??
                                                                  ""),
                                                        );
                                                      }).toList(),
                                                      placeholder: const Text(
                                                          "Please select business"),
                                                      onChanged: (value) {
                                                        if (value == null) {
                                                          return;
                                                        }
                                                        controller
                                                            .selectedBusiness
                                                            .value = value;
                                                        controller.comboBoxError
                                                            .value = "";
                                                      },
                                                    ),
                                                  ),
                                                  if (controller
                                                      .comboBoxError.isNotEmpty)
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 8.0),
                                                      child: Text(
                                                        controller.comboBoxError
                                                            .value,
                                                        style: AppTextStyle
                                                            .regularStyle(
                                                          color: Colors.red,
                                                          size: 12,
                                                        ),
                                                      ),
                                                    ),
                                                ],
                                              )
                                        : controller.offerList.isEmpty
                                            ? Text(
                                                "Banner not found",
                                                style: AppTextStyle.boldStyle(
                                                  size: 18,
                                                  color: AppColor
                                                      .tableRowTextColor,
                                                ),
                                              )
                                            : Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  FluentTheme(
                                                    data:
                                                        FluentThemeData.light(),
                                                    child: ComboBox<
                                                        BannerListModel>(
                                                      value: controller
                                                          .selectedBanner.value,
                                                      style: AppTextStyle
                                                          .mediumStyle(
                                                        color: Colors.black,
                                                        size: 15,
                                                      ),
                                                      items: controller
                                                          .bannerList
                                                          .map((e) {
                                                        return ComboBoxItem(
                                                          value: e,
                                                          child: Text(e.offerId
                                                                  ?.description ??
                                                              ""),
                                                        );
                                                      }).toList(),
                                                      placeholder: const Text(
                                                          "Please select banner"),
                                                      onChanged: (value) {
                                                        if (value == null) {
                                                          return;
                                                        }
                                                        controller
                                                            .selectedBanner
                                                            .value = value;
                                                        controller.comboBoxError
                                                            .value = "";
                                                      },
                                                    ),
                                                  ),
                                                  if (controller
                                                      .comboBoxError.isNotEmpty)
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 8.0),
                                                      child: Text(
                                                        controller.comboBoxError
                                                            .value,
                                                        style: AppTextStyle
                                                            .regularStyle(
                                                          color: Colors.red,
                                                          size: 12,
                                                        ),
                                                      ),
                                                    ),
                                                ],
                                              ),
                      ),
                      const Gap(20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Obx(
                            () => controller.isProcess.value
                                ? CustomCircularIndicator.indicator(
                                    color: AppColor.primary,
                                    color1: Colors.white.withOpacity(0.25),
                                  )
                                : FilledButton(
                                    onPressed: () {
                                      controller.checkValidation(ctx: context);
                                    },
                                    style: ButtonStyle(
                                      backgroundColor: WidgetStateProperty.all(
                                        AppColor.btnGreenColor,
                                      ),
                                    ),
                                    child: Text(
                                      'Create Notification',
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
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
