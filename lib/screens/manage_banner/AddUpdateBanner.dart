import 'package:pro_deals_admin/utils/imports.dart';

class AddUpdateBanner extends StatelessWidget {
  final dynamic data;

  const AddUpdateBanner({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    double hit = MediaQuery.of(context).size.height;
    double wid = MediaQuery.of(context).size.width;
    return GetBuilder<AddUpdateBannerController>(
      init: AddUpdateBannerController(
        data: data,
        ctx: context,
      ),
      builder: (controller) {
        return NavigationView(
          key: controller.addUpdateBannerKey,
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
              controller.isEdit.value ? 'Update banner details' : "Add banner",
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
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: wid / 3.5,
                  padding: const EdgeInsets.symmetric(
                    vertical: 25,
                    horizontal: 25,
                  ),
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
                      Text(
                        'Banner image',
                        style: AppTextStyle.semiBoldStyle(
                          size: 20,
                          color: AppColor.tableRowTextColor,
                        ),
                      ),
                      const Gap(10),
                      Obx(
                        () => Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: controller.bannerImage.value == null
                                  ? controller.isEdit.value
                                      ? Image.memory(
                                          Uint8List.fromList(
                                            controller.banner.image!.data!,
                                          ),
                                          height: 150,
                                          width: wid / 3.7,
                                          fit: BoxFit.cover,
                                        )
                                      : Image.asset(
                                          'assets/images/default_image.png',
                                          height: 150,
                                          width: wid / 3.7,
                                          fit: BoxFit.fitWidth,
                                        )
                                  : Image.file(
                                      controller.bannerImage.value!,
                                      height: 150,
                                      width: wid / 3.7,
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
                                    controller.bannerImage.value =
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
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Gap(20),
                      Text(
                        'Banner type',
                        style: AppTextStyle.semiBoldStyle(
                          size: 20,
                          color: AppColor.tableRowTextColor,
                        ),
                      ),
                      const Gap(10),
                      FluentTheme(
                        data: FluentThemeData.light(),
                        child: Obx(
                          () => ComboBox<String>(
                            value: controller.selectedType.value,
                            style: AppTextStyle.mediumStyle(
                              color: Colors.black,
                              size: 15,
                            ),
                            placeholder: const Text("Select Banner Type"),
                            items: controller.bannerTypeList.map((e) {
                              return ComboBoxItem(
                                value: e,
                                child: Text(e),
                              );
                            }).toList(),
                            onChanged: (value) {
                              if (value == null) return;
                              controller.selectedType.value = value;
                            },
                          ),
                        ),
                      ),
                      controller.isEdit.value
                          ? const Gap(0)
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Gap(20),
                                Text(
                                  'Select offer',
                                  style: AppTextStyle.semiBoldStyle(
                                    size: 20,
                                    color: AppColor.tableRowTextColor,
                                  ),
                                ),
                                const Gap(10),
                                FluentTheme(
                                  data: FluentThemeData.light(),
                                  child: Obx(
                                    () => controller.isLoaded.value
                                        ? controller.offerList.isEmpty
                                            ? Text(
                                                'Offers not found',
                                                style:
                                                    AppTextStyle.regularStyle(
                                                  size: 15,
                                                  color: AppColor
                                                      .tableRowTextColor,
                                                ),
                                              )
                                            : ConstrainedBox(
                                                constraints: BoxConstraints(
                                                    maxWidth: wid / 3.7),
                                                // same as the image box
                                                child: ComboBox<String>(
                                                  value: controller
                                                      .selectedOffer.value,
                                                  style:
                                                      AppTextStyle.mediumStyle(
                                                    color: Colors.black,
                                                    size: 15,
                                                  ),
                                                  placeholder: const Text(
                                                      "Select Offer"),
                                                  items: controller.offerList
                                                      .map((e) {
                                                    final displayText =
                                                        "${e.description ?? ""} | ${e.businessId?.businessName ?? ""}";
                                                    return ComboBoxItem(
                                                      value: displayText,
                                                      child: ConstrainedBox(
                                                        constraints:
                                                            BoxConstraints(
                                                                maxWidth:
                                                                    wid / 4.8),
                                                        child: Tooltip(
                                                          message: displayText,
                                                          child: Text(
                                                            displayText,
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        14),
                                                            softWrap: false,
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  }).toList(),
                                                  onChanged: (value) {
                                                    if (value == null) return;
                                                    controller.selectedOffer
                                                        .value = value;
                                                  },
                                                ),
                                              )
                                        : CustomCircularIndicator.indicator(
                                            color1:
                                                Colors.white.withOpacity(0.25),
                                            color: AppColor.primary,
                                          ),
                                  ),
                                ),
                              ],
                            ),
                      const Gap(25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Obx(
                            () => FilledButton(
                              onPressed: () {
                                controller.checkValidation(ctx: context);
                              },
                              style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all(
                                  AppColor.btnGreenColor,
                                ),
                              ),
                              child: Text(
                                controller.isEdit.value
                                    ? 'Update Banner'
                                    : 'Add Banner',
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
