import 'package:pro_deals_admin/utils/imports.dart';

class ViewBusiness extends GetView<ViewBusinessController> {
  final AllBusinessModel business;

  const ViewBusiness({
    super.key,
    required this.business,
  });

  @override
  Widget build(BuildContext context) {
    double hit = MediaQuery.of(context).size.height;
    double wid = MediaQuery.of(context).size.width;
    return GetBuilder<ViewBusinessController>(
      init: ViewBusinessController(),
      builder: (controller) {
        return NavigationView(
          key: controller.viewBusinessKey,
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
              "View Business Details",
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
            child: FluentTheme(
              data: FluentThemeData.light(),
              child: Obx(
                () => TabView(
                  currentIndex: controller.currentIndex.value,
                  onChanged: (value) => controller.currentIndex.value = value,
                  closeButtonVisibility: CloseButtonVisibilityMode.never,
                  tabWidthBehavior: TabWidthBehavior.sizeToContent,
                  tabs: [
                    Tab(
                      text: Text(
                        "Information",
                        style: controller.tabTextStyle(index: 0),
                      ),
                      body: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Wrap(
                            runSpacing: 20,
                            spacing: 20,
                            crossAxisAlignment: WrapCrossAlignment.start,
                            children: [
                              Container(
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
                                      'Business Information',
                                      style: AppTextStyle.boldStyle(
                                        color: AppColor.smokyBlack,
                                        size: 22,
                                      ),
                                    ),
                                    const Gap(10),
                                    Text(
                                      "Main Image",
                                      style: AppTextStyle.mediumStyle(
                                        color: AppColor.smokyBlack,
                                        size: 20,
                                      ),
                                    ),
                                    const Gap(10),
                                    GestureDetector(
                                      onTap: () {
                                        controller.zoomImage(
                                          data: business.mainImage!.data!.data!,
                                          ctx: context,
                                          wid: wid,
                                        );
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child:
                                            !(business.mainImage?.data?.data ??
                                                        [])
                                                    .isImage()
                                                ? Image.memory(
                                                    Uint8List.fromList(
                                                      business.mainImage!.data!
                                                          .data!,
                                                    ),
                                                    height: 200,
                                                    width: 200,
                                                    fit: BoxFit.cover,
                                                  )
                                                : Image.asset(
                                                    'assets/images/default_image.png',
                                                    height: 200,
                                                    width: 200,
                                                    fit: BoxFit.cover,
                                                  ),
                                      ),
                                    ),
                                    const Gap(10),
                                    controller.summaryWidget(
                                      title: 'Name',
                                      content: business.businessName ?? "",
                                    ),
                                    const Gap(10),
                                    controller.summaryWidget(
                                      title: 'Phone',
                                      content: business.contactNumber ?? "",
                                    ),
                                  ],
                                ),
                              ),
                              Container(
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
                                      'User Information',
                                      style: AppTextStyle.boldStyle(
                                        color: AppColor.smokyBlack,
                                        size: 22,
                                      ),
                                    ),
                                    const Gap(10),
                                    Text(
                                      "Profile Image",
                                      style: AppTextStyle.mediumStyle(
                                        color: AppColor.smokyBlack,
                                        size: 20,
                                      ),
                                    ),
                                    const Gap(10),
                                    ClipOval(
                                      child: !(business.userId?.image?.data ??
                                                  [])
                                              .isImage()
                                          ? GestureDetector(
                                              onTap: () {
                                                controller.zoomImage(
                                                  data: business
                                                      .userId!.image!.data!,
                                                  ctx: context,
                                                  wid: wid,
                                                );
                                              },
                                              child: Image.memory(
                                                Uint8List.fromList(
                                                  business.userId!.image!.data!,
                                                ),
                                                height: 125,
                                                width: 125,
                                                fit: BoxFit.cover,
                                              ),
                                            )
                                          : Image.asset(
                                              'assets/images/default_image.png',
                                              height: 125,
                                              width: 125,
                                              fit: BoxFit.cover,
                                            ),
                                    ),
                                    const Gap(10),
                                    controller.summaryWidget(
                                      title: 'Name',
                                      content: business.userId?.userName ?? "",
                                    ),
                                    const Gap(10),
                                    controller.summaryWidget(
                                      title: 'Phone',
                                      content: business.userId?.phone ?? "",
                                    ),
                                    const Gap(10),
                                    controller.summaryWidget(
                                      title: 'Email',
                                      content: business.userId?.email ?? "",
                                    ),
                                  ],
                                ),
                              ),
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
                                      'Business Address',
                                      style: AppTextStyle.boldStyle(
                                        color: AppColor.smokyBlack,
                                        size: 22,
                                      ),
                                    ),
                                    const Gap(10),
                                    controller.summaryWidget(
                                      title: 'Address',
                                      content: business.address ?? "",
                                    ),
                                    const Gap(10),
                                    controller.summaryWidget(
                                      title: 'City',
                                      content: business.city ?? "",
                                    ),
                                    const Gap(10),
                                    controller.summaryWidget(
                                      title: 'State',
                                      content: business.state ?? "",
                                    ),
                                    const Gap(10),
                                    controller.summaryWidget(
                                      title: 'Pin-code',
                                      content: business.pincode ?? "",
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Tab(
                      text: Text(
                        "Business Details",
                        style: controller.tabTextStyle(index: 1),
                      ),
                      body: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Wrap(
                            spacing: 20,
                            runSpacing: 20,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: wid / 3,
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
                                          color:
                                              AppColor.black.withOpacity(0.5),
                                        )
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        controller.summaryWidget(
                                          title: 'Business Category',
                                          content: business.category ?? "",
                                        ),
                                        const Gap(10),
                                        controller.summaryWidget(
                                          title: 'GST Number',
                                          content: business.gstNumber ?? "",
                                        ),
                                        const Gap(10),
                                        controller.summaryWidget(
                                          title: 'Pan Number',
                                          content: business.panNumber ?? "",
                                        ),
                                        const Gap(10),
                                        controller.summaryWidget(
                                          title: 'Area in SQFT',
                                          content:
                                              "${business.areaSqures ?? "0"}",
                                        ),
                                        const Gap(10),
                                        controller.summaryWidget(
                                          title: 'Description',
                                          content: business.description ?? "",
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: wid / 4,
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
                                          color:
                                              AppColor.black.withOpacity(0.5),
                                        )
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Office Timing',
                                          style: AppTextStyle.boldStyle(
                                            color: AppColor.smokyBlack,
                                            size: 22,
                                          ),
                                        ),
                                        const Gap(10),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: controller.summaryWidget(
                                                title: 'Open time',
                                                content: business.openTime ??
                                                    "00:00 DD",
                                              ),
                                            ),
                                            Expanded(
                                              child: controller.summaryWidget(
                                                title: 'Close time',
                                                content: business.closeTime ??
                                                    "00:00 DD",
                                              ),
                                            ),
                                          ],
                                        ),
                                        business.offDays == null ||
                                                business.offDays == "null" ||
                                                business.offDays == ""
                                            ? const Gap(0)
                                            : const Gap(10),
                                        business.offDays == null ||
                                                business.offDays == "null" ||
                                                business.offDays == ""
                                            ? const Gap(0)
                                            : controller.summaryWidget(
                                                title: 'Off days',
                                                content: business.offDays ?? "",
                                              ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Tab(
                      text: Text(
                        "Store Images",
                        style: controller.tabTextStyle(index: 2),
                      ),
                      body: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Wrap(
                            spacing: 20,
                            runSpacing: 20,
                            children: [
                              for (int i = 0;
                                  i < (business.storeImages?.length ?? 0);
                                  i++)
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: (business.storeImages?[i].data?.data ??
                                              [])
                                          .isImage()
                                      ? Image.asset(
                                          'assets/images/default_image.png',
                                          height: 130,
                                          width: 130,
                                          fit: BoxFit.cover,
                                        )
                                      : GestureDetector(
                                          onTap: () => controller.zoomImage(
                                            data: business
                                                .storeImages![i].data!.data!,
                                            ctx: context,
                                            wid: wid,
                                          ),
                                          child: Image.memory(
                                            Uint8List.fromList(business
                                                .storeImages![i].data!.data!),
                                            height: wid / 6,
                                            width: wid / 6,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Tab(
                      text: Text(
                        "Documents",
                        style: controller.tabTextStyle(index: 3),
                      ),
                      body: SingleChildScrollView(
                        padding: const EdgeInsets.all(20),
                        child: Wrap(
                          runSpacing: 20,
                          spacing: 20,
                          children: [
                            Container(
                              width: wid / 4,
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
                                  controller.summaryWidget(
                                    title: 'Business Proof',
                                    content: "",
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: !(business.proofImage?.data ?? [])
                                            .isImage()
                                        ? GestureDetector(
                                            onTap: () => controller.zoomImage(
                                              data: business.proofImage!.data!,
                                              ctx: context,
                                              wid: wid,
                                            ),
                                            child: Image.memory(
                                              Uint8List.fromList(
                                                business.proofImage!.data!,
                                              ),
                                              fit: BoxFit.cover,
                                              height: (wid / 4) - 50,
                                              width: (wid / 4) - 50,
                                            ),
                                          )
                                        : Image.asset(
                                            'assets/images/default_image.png',
                                            height: 200,
                                            width: 200,
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: wid / 4,
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
                                  controller.summaryWidget(
                                    title: 'User Voter Id Proof',
                                    content: "",
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: !(business
                                                    .waterIdImage?.data?.data ??
                                                [])
                                            .isImage()
                                        ? GestureDetector(
                                            onTap: () => controller.zoomImage(
                                              data: business
                                                  .waterIdImage!.data!.data!,
                                              ctx: context,
                                              wid: wid,
                                            ),
                                            child: Image.memory(
                                              Uint8List.fromList(
                                                business
                                                    .waterIdImage!.data!.data!,
                                              ),
                                              fit: BoxFit.cover,
                                              height: (wid / 4) - 50,
                                              width: (wid / 4) - 50,
                                            ),
                                          )
                                        : Image.asset(
                                            'assets/images/default_image.png',
                                            height: 200,
                                            width: 200,
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: wid / 4,
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
                                  controller.summaryWidget(
                                    title: 'User Government Id Proof',
                                    content: "",
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: !(business.govermentIdImage?.data
                                                    ?.data ??
                                                [])
                                            .isImage()
                                        ? GestureDetector(
                                            onTap: () => controller.zoomImage(
                                              data: business.govermentIdImage!
                                                  .data!.data!,
                                              ctx: context,
                                              wid: wid,
                                            ),
                                            child: Image.memory(
                                              Uint8List.fromList(
                                                business.govermentIdImage!.data!
                                                    .data!,
                                              ),
                                              fit: BoxFit.cover,
                                              height: (wid / 4) - 50,
                                              width: (wid / 4) - 50,
                                            ),
                                          )
                                        : Image.asset(
                                            'assets/images/default_image.png',
                                            height: 200,
                                            width: 200,
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
