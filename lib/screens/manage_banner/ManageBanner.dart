import 'package:pro_deals_admin/utils/imports.dart';

class ManageBanner extends GetView<ManageBannerController> {
  const ManageBanner({super.key});

  @override
  Widget build(BuildContext context) {
    double hit = MediaQuery.of(context).size.height;
    double wid = MediaQuery.of(context).size.width;
    return GetBuilder<ManageBannerController>(
      init: ManageBannerController(ctx: context),
      builder: (controller) {
        return Container(
          color: AppColor.white,
          child: Obx(
            () => FluentThemeWidget(
              widget: TabView(
                currentIndex: controller.currentIndex.value,
                onChanged: (index) => controller.currentIndex.value = index,
                closeButtonVisibility: CloseButtonVisibilityMode.never,
                tabWidthBehavior: TabWidthBehavior.equal,
                tabs: [
                  Tab(
                    text: Text(
                      'All Banner',
                      style: controller.tabTextStyle(index: 0),
                    ),
                    body: Container(
                      height: hit,
                      width: wid,
                      color: AppColor.white,
                      padding:
                          const EdgeInsets.only(top: 20, left: 20, right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Manage Banner',
                            style: AppTextStyle.semiBoldStyle(
                              size: 32,
                              color: AppColor.black300,
                            ),
                          ),
                          const Gap(20),
                          Obx(
                            () => Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                controller.isError.value ||
                                        (controller.type1.length +
                                                controller.type2.length +
                                                controller.type3.length) ==
                                            0
                                    ? const Gap(0)
                                    : Text(
                                        'Show ${controller.type1.length + controller.type2.length + controller.type3.length} Entries',
                                        style: AppTextStyle.semiBoldStyle(
                                          size: 24,
                                          color: AppColor.smokyBlack,
                                        ),
                                      ),
                                FilledButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                      context,
                                      '/add_update_banner',
                                      arguments: {
                                        'isEdit': false,
                                      },
                                    ).then(
                                      (value) {
                                        if (value is bool && value) {
                                          controller.getBannerList();
                                        }
                                      },
                                    );
                                  },
                                  style: const ButtonStyle(
                                    backgroundColor: WidgetStatePropertyAll(
                                      AppColor.btnGreenColor,
                                    ),
                                  ),
                                  child: const Text('+ Add New Banner'),
                                ),
                              ],
                            ),
                          ),
                          const Gap(20),
                          Obx(
                            () => controller.isError.value ||
                                    (controller.type1.length +
                                            controller.type2.length +
                                            controller.type3.length) ==
                                        0
                                ? const Gap(0)
                                : Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 14,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColor.tableHeaderBgColor,
                                      borderRadius: BorderRadius.circular(4),
                                      boxShadow: [
                                        BoxShadow(
                                          offset: const Offset(0, 2),
                                          blurRadius: 4,
                                          color:
                                              AppColor.black.withOpacity(0.5),
                                        )
                                      ],
                                    ),
                                    alignment: Alignment.center,
                                    child: Table(
                                      columnWidths: const {
                                        0: FixedColumnWidth(50),
                                        1: FixedColumnWidth(150),
                                        2: FixedColumnWidth(200),
                                        3: FlexColumnWidth(),
                                        4: FixedColumnWidth(150),
                                        5: FlexColumnWidth(),
                                        6: FlexColumnWidth(),
                                      },
                                      children: [
                                        TableRow(
                                          children: [
                                            Text(
                                              'No.',
                                              style: AppTextStyle.semiBoldStyle(
                                                color: AppColor.black,
                                                size: 20,
                                              ),
                                            ),
                                            Text(
                                              'Image',
                                              style: AppTextStyle.semiBoldStyle(
                                                color: AppColor.black,
                                                size: 20,
                                              ),
                                            ),
                                            Text(
                                              'Description',
                                              style: AppTextStyle.semiBoldStyle(
                                                color: AppColor.black,
                                                size: 20,
                                              ),
                                            ),
                                            Text(
                                              'Offer details',
                                              style: AppTextStyle.semiBoldStyle(
                                                color: AppColor.black,
                                                size: 20,
                                              ),
                                            ),
                                            Text(
                                              'Offer Status',
                                              style: AppTextStyle.semiBoldStyle(
                                                color: AppColor.black,
                                                size: 20,
                                              ),
                                            ),
                                            Text(
                                              'Valid on',
                                              style: AppTextStyle.semiBoldStyle(
                                                color: AppColor.black,
                                                size: 20,
                                              ),
                                            ),
                                            Text(
                                              'Action',
                                              style: AppTextStyle.semiBoldStyle(
                                                color: AppColor.black,
                                                size: 20,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                          ),
                          const Gap(20),
                          Obx(
                            () => controller.isError.value
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Gap(30),
                                      const Icon(
                                        FluentIcons.search_issue,
                                        size: 80,
                                        color: AppColor.black,
                                      ),
                                      const Gap(20),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "Something went wrong please try again.",
                                              textAlign: TextAlign.center,
                                              style: AppTextStyle.boldStyle(
                                                size: 20,
                                                color: AppColor.black,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                : controller.isLoaded.value
                                    ? (controller.type1.length +
                                                controller.type2.length +
                                                controller.type3.length) ==
                                            0
                                        ? Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      "Banner not found.",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: AppTextStyle
                                                          .boldStyle(
                                                        size: 20,
                                                        color: AppColor.black,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )
                                        : Expanded(
                                            child: SingleChildScrollView(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  controller.type1.isEmpty
                                                      ? const Gap(0)
                                                      : Text(
                                                          "Upper slider banner",
                                                          style: AppTextStyle
                                                              .boldStyle(
                                                            size: 20,
                                                            color: AppColor
                                                                .smokyBlack,
                                                          ),
                                                        ),
                                                  controller.type1.isEmpty
                                                      ? const Gap(0)
                                                      : const Gap(10),
                                                  ListView.separated(
                                                    shrinkWrap: true,
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal:
                                                                    20.0),
                                                        child: Table(
                                                          columnWidths: const {
                                                            0: FixedColumnWidth(
                                                                50),
                                                            1: FixedColumnWidth(
                                                                150),
                                                            2: FixedColumnWidth(
                                                                200),
                                                            3: FlexColumnWidth(),
                                                            4: FixedColumnWidth(
                                                                150),
                                                            5: FlexColumnWidth(),
                                                            6: FlexColumnWidth(),
                                                          },
                                                          children: [
                                                            TableRow(
                                                              children: [
                                                                Text(
                                                                  '${index + 1}',
                                                                  style: AppTextStyle
                                                                      .semiBoldStyle(
                                                                    color: AppColor
                                                                        .tableRowTextColor,
                                                                    size: 16,
                                                                  ),
                                                                ),
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    controller
                                                                        .zoomImage(
                                                                      data: controller
                                                                          .type1[
                                                                              index]
                                                                          .image!
                                                                          .data!,
                                                                      ctx:
                                                                          context,
                                                                      wid: wid,
                                                                    );
                                                                  },
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .only(
                                                                      right:
                                                                          10.0,
                                                                    ),
                                                                    child:
                                                                        ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10),
                                                                      child: Image
                                                                          .memory(
                                                                        Uint8List
                                                                            .fromList(
                                                                          controller
                                                                              .type1[index]
                                                                              .image!
                                                                              .data!,
                                                                        ),
                                                                        height:
                                                                            150,
                                                                        width:
                                                                            150,
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                    right: 10.0,
                                                                  ),
                                                                  child: Text(
                                                                    controller
                                                                            .type1[index]
                                                                            .offerId
                                                                            ?.description ??
                                                                        "",
                                                                    style: AppTextStyle
                                                                        .semiBoldStyle(
                                                                      color: AppColor
                                                                          .tableRowTextColor,
                                                                      size: 16,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Text(
                                                                  'Product price: ${controller.type1[index].offerId?.productPrice ?? 0} ₹\nDiscount price: ${controller.type1[index].offerId?.offerPrice ?? 0} ${controller.type1[index].offerId?.offertype == "Amount" ? '₹' : '%'}\nPayment amount: ${controller.type1[index].offerId?.paymentAmount ?? 0} ₹',
                                                                  style: AppTextStyle
                                                                      .semiBoldStyle(
                                                                    color: AppColor
                                                                        .tableRowTextColor,
                                                                    size: 16,
                                                                  ),
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    controller.type1[index].offerId?.isActive ??
                                                                            false
                                                                        ? Container(
                                                                            height:
                                                                                30,
                                                                            width:
                                                                                30,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(5),
                                                                              color: AppColor.btnGreenColor,
                                                                            ),
                                                                            alignment:
                                                                                Alignment.center,
                                                                            child:
                                                                                const Icon(
                                                                              FluentIcons.check_mark,
                                                                              color: AppColor.white,
                                                                              size: 22,
                                                                            ),
                                                                          )
                                                                        : Container(
                                                                            alignment:
                                                                                Alignment.center,
                                                                            height:
                                                                                30,
                                                                            width:
                                                                                30,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(5),
                                                                              color: AppColor.btnRedColor,
                                                                            ),
                                                                            child:
                                                                                const Icon(
                                                                              FluentIcons.clear,
                                                                              color: AppColor.white,
                                                                              size: 15,
                                                                            ),
                                                                          ),
                                                                  ],
                                                                ),
                                                                Text(
                                                                  controller
                                                                          .type1[
                                                                              index]
                                                                          .offerId
                                                                          ?.validOn ??
                                                                      "",
                                                                  style: AppTextStyle
                                                                      .semiBoldStyle(
                                                                    color: AppColor
                                                                        .tableRowTextColor,
                                                                    size: 16,
                                                                  ),
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    IconButton(
                                                                      icon:
                                                                          const Icon(
                                                                        FluentIcons
                                                                            .edit,
                                                                        color: AppColor
                                                                            .white,
                                                                      ),
                                                                      onPressed:
                                                                          () {
                                                                        Navigator
                                                                            .pushNamed(
                                                                          context,
                                                                          '/add_update_banner',
                                                                          arguments: {
                                                                            'isEdit':
                                                                                true,
                                                                            'data':
                                                                                controller.type1[index],
                                                                          },
                                                                        ).then(
                                                                          (value) {
                                                                            if (value is bool &&
                                                                                value) {
                                                                              controller.getBannerList();
                                                                            }
                                                                          },
                                                                        );
                                                                      },
                                                                      style:
                                                                          ButtonStyle(
                                                                        backgroundColor:
                                                                            WidgetStateProperty.all(Colors.green),
                                                                      ),
                                                                    ),
                                                                    const Gap(
                                                                        10),
                                                                    IconButton(
                                                                      icon:
                                                                          const Icon(
                                                                        FluentIcons
                                                                            .red_eye,
                                                                        color: AppColor
                                                                            .white,
                                                                      ),
                                                                      onPressed:
                                                                          () {
                                                                        Navigator
                                                                            .pushNamed(
                                                                          context,
                                                                          '/view_banner',
                                                                          arguments:
                                                                              controller.type1[index],
                                                                        );
                                                                      },
                                                                      style:
                                                                          ButtonStyle(
                                                                        backgroundColor:
                                                                            WidgetStateProperty.all(Colors.blue),
                                                                      ),
                                                                    ),
                                                                    const Gap(
                                                                        10),
                                                                    IconButton(
                                                                      icon:
                                                                          const Icon(
                                                                        FluentIcons
                                                                            .delete,
                                                                        color: AppColor
                                                                            .white,
                                                                      ),
                                                                      onPressed:
                                                                          () {
                                                                        controller
                                                                            .showDeleteDialog(
                                                                          ctx:
                                                                              context,
                                                                          i: index,
                                                                          id: controller.type1[index].sId ??
                                                                              "",
                                                                        );
                                                                      },
                                                                      style:
                                                                          ButtonStyle(
                                                                        backgroundColor:
                                                                            WidgetStateProperty.all(Colors.red),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                    separatorBuilder:
                                                        (context, index) =>
                                                            const Gap(20),
                                                    itemCount:
                                                        controller.type1.length,
                                                  ),
                                                  controller.type1.isEmpty
                                                      ? const Gap(0)
                                                      : const Gap(15),
                                                  controller.type2.isEmpty
                                                      ? const Gap(0)
                                                      : Text(
                                                          "Middle slider banner",
                                                          style: AppTextStyle
                                                              .boldStyle(
                                                            size: 20,
                                                            color: AppColor
                                                                .smokyBlack,
                                                          ),
                                                        ),
                                                  controller.type2.isEmpty
                                                      ? const Gap(0)
                                                      : const Gap(10),
                                                  ListView.separated(
                                                    shrinkWrap: true,
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal:
                                                                    20.0),
                                                        child: Table(
                                                          columnWidths: const {
                                                            0: FixedColumnWidth(
                                                                50),
                                                            1: FixedColumnWidth(
                                                                150),
                                                            2: FixedColumnWidth(
                                                                200),
                                                            3: FlexColumnWidth(),
                                                            4: FixedColumnWidth(
                                                                150),
                                                            5: FlexColumnWidth(),
                                                            6: FlexColumnWidth(),
                                                          },
                                                          children: [
                                                            TableRow(
                                                              children: [
                                                                Text(
                                                                  '${index + 1}',
                                                                  style: AppTextStyle
                                                                      .semiBoldStyle(
                                                                    color: AppColor
                                                                        .tableRowTextColor,
                                                                    size: 16,
                                                                  ),
                                                                ),
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    controller
                                                                        .zoomImage(
                                                                      data: controller
                                                                          .type2[
                                                                              index]
                                                                          .image!
                                                                          .data!,
                                                                      ctx:
                                                                          context,
                                                                      wid: wid,
                                                                    );
                                                                  },
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .only(
                                                                      right:
                                                                          10.0,
                                                                    ),
                                                                    child:
                                                                        ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10),
                                                                      child: Image
                                                                          .memory(
                                                                        Uint8List
                                                                            .fromList(
                                                                          controller
                                                                              .type2[index]
                                                                              .image!
                                                                              .data!,
                                                                        ),
                                                                        height:
                                                                            150,
                                                                        width:
                                                                            150,
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                    right: 10.0,
                                                                  ),
                                                                  child: Text(
                                                                    controller
                                                                            .type2[index]
                                                                            .offerId
                                                                            ?.description ??
                                                                        "",
                                                                    style: AppTextStyle
                                                                        .semiBoldStyle(
                                                                      color: AppColor
                                                                          .tableRowTextColor,
                                                                      size: 16,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Text(
                                                                  'Product price: ${controller.type2[index].offerId?.productPrice ?? 0} ₹\nDiscount price: ${controller.type2[index].offerId?.offerPrice ?? 0} ${controller.type2[index].offerId?.offertype == "Amount" ? '₹' : '%'}\nPayment amount: ${controller.type2[index].offerId?.paymentAmount ?? 0} ₹',
                                                                  style: AppTextStyle
                                                                      .semiBoldStyle(
                                                                    color: AppColor
                                                                        .tableRowTextColor,
                                                                    size: 16,
                                                                  ),
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    controller.type2[index].offerId?.isActive ??
                                                                            false
                                                                        ? Container(
                                                                            height:
                                                                                30,
                                                                            width:
                                                                                30,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(5),
                                                                              color: AppColor.btnGreenColor,
                                                                            ),
                                                                            alignment:
                                                                                Alignment.center,
                                                                            child:
                                                                                const Icon(
                                                                              FluentIcons.check_mark,
                                                                              color: AppColor.white,
                                                                              size: 22,
                                                                            ),
                                                                          )
                                                                        : Container(
                                                                            alignment:
                                                                                Alignment.center,
                                                                            height:
                                                                                30,
                                                                            width:
                                                                                30,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(5),
                                                                              color: AppColor.btnRedColor,
                                                                            ),
                                                                            child:
                                                                                const Icon(
                                                                              FluentIcons.clear,
                                                                              color: AppColor.white,
                                                                              size: 15,
                                                                            ),
                                                                          ),
                                                                  ],
                                                                ),
                                                                Text(
                                                                  controller
                                                                          .type2[
                                                                              index]
                                                                          .offerId
                                                                          ?.validOn ??
                                                                      "",
                                                                  style: AppTextStyle
                                                                      .semiBoldStyle(
                                                                    color: AppColor
                                                                        .tableRowTextColor,
                                                                    size: 16,
                                                                  ),
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    IconButton(
                                                                      icon:
                                                                          const Icon(
                                                                        FluentIcons
                                                                            .edit,
                                                                        color: AppColor
                                                                            .white,
                                                                      ),
                                                                      onPressed:
                                                                          () {
                                                                        Navigator
                                                                            .pushNamed(
                                                                          context,
                                                                          '/add_update_banner',
                                                                          arguments: {
                                                                            'isEdit':
                                                                                true,
                                                                            'data':
                                                                                controller.type2[index],
                                                                          },
                                                                        ).then(
                                                                          (value) {
                                                                            if (value is bool &&
                                                                                value) {
                                                                              controller.getBannerList();
                                                                            }
                                                                          },
                                                                        );
                                                                      },
                                                                      style:
                                                                          ButtonStyle(
                                                                        backgroundColor:
                                                                            WidgetStateProperty.all(Colors.green),
                                                                      ),
                                                                    ),
                                                                    const Gap(
                                                                        10),
                                                                    IconButton(
                                                                      icon:
                                                                          const Icon(
                                                                        FluentIcons
                                                                            .red_eye,
                                                                        color: AppColor
                                                                            .white,
                                                                      ),
                                                                      onPressed:
                                                                          () {
                                                                        Navigator
                                                                            .pushNamed(
                                                                          context,
                                                                          '/view_banner',
                                                                          arguments:
                                                                              controller.type2[index],
                                                                        );
                                                                      },
                                                                      style:
                                                                          ButtonStyle(
                                                                        backgroundColor:
                                                                            WidgetStateProperty.all(Colors.blue),
                                                                      ),
                                                                    ),
                                                                    const Gap(
                                                                        10),
                                                                    IconButton(
                                                                      icon:
                                                                          const Icon(
                                                                        FluentIcons
                                                                            .delete,
                                                                        color: AppColor
                                                                            .white,
                                                                      ),
                                                                      onPressed:
                                                                          () {
                                                                        controller
                                                                            .showDeleteDialog(
                                                                          ctx:
                                                                              context,
                                                                          i: index,
                                                                          id: controller.type2[index].sId ??
                                                                              "",
                                                                        );
                                                                      },
                                                                      style:
                                                                          ButtonStyle(
                                                                        backgroundColor:
                                                                            WidgetStateProperty.all(Colors.red),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                    separatorBuilder:
                                                        (context, index) =>
                                                            const Gap(20),
                                                    itemCount:
                                                        controller.type2.length,
                                                  ),
                                                  controller.type2.isEmpty
                                                      ? const Gap(0)
                                                      : const Gap(15),
                                                  controller.type3.isEmpty
                                                      ? const Gap(0)
                                                      : Text(
                                                          "Lower slider banner",
                                                          style: AppTextStyle
                                                              .boldStyle(
                                                            size: 20,
                                                            color: AppColor
                                                                .smokyBlack,
                                                          ),
                                                        ),
                                                  controller.type3.isEmpty
                                                      ? const Gap(0)
                                                      : const Gap(10),
                                                  ListView.separated(
                                                    shrinkWrap: true,
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal:
                                                                    20.0),
                                                        child: Table(
                                                          columnWidths: const {
                                                            0: FixedColumnWidth(
                                                                50),
                                                            1: FixedColumnWidth(
                                                                150),
                                                            2: FixedColumnWidth(
                                                                200),
                                                            3: FlexColumnWidth(),
                                                            4: FixedColumnWidth(
                                                                150),
                                                            5: FlexColumnWidth(),
                                                            6: FlexColumnWidth(),
                                                          },
                                                          children: [
                                                            TableRow(
                                                              children: [
                                                                Text(
                                                                  '${index + 1}',
                                                                  style: AppTextStyle
                                                                      .semiBoldStyle(
                                                                    color: AppColor
                                                                        .tableRowTextColor,
                                                                    size: 16,
                                                                  ),
                                                                ),
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    controller
                                                                        .zoomImage(
                                                                      data: controller
                                                                          .type3[
                                                                              index]
                                                                          .image!
                                                                          .data!,
                                                                      ctx:
                                                                          context,
                                                                      wid: wid,
                                                                    );
                                                                  },
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .only(
                                                                      right:
                                                                          10.0,
                                                                    ),
                                                                    child:
                                                                        ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10),
                                                                      child: Image
                                                                          .memory(
                                                                        Uint8List
                                                                            .fromList(
                                                                          controller
                                                                              .type3[index]
                                                                              .image!
                                                                              .data!,
                                                                        ),
                                                                        height:
                                                                            150,
                                                                        width:
                                                                            150,
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                    right: 10.0,
                                                                  ),
                                                                  child: Text(
                                                                    controller
                                                                            .type3[index]
                                                                            .offerId
                                                                            ?.description ??
                                                                        "",
                                                                    style: AppTextStyle
                                                                        .semiBoldStyle(
                                                                      color: AppColor
                                                                          .tableRowTextColor,
                                                                      size: 16,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Text(
                                                                  'Product price: ${controller.type3[index].offerId?.productPrice ?? 0} ₹\nDiscount price: ${controller.type3[index].offerId?.offerPrice ?? 0} ${controller.type3[index].offerId?.offertype == "Amount" ? '₹' : '%'}\nPayment amount: ${controller.type3[index].offerId?.paymentAmount ?? 0} ₹',
                                                                  style: AppTextStyle
                                                                      .semiBoldStyle(
                                                                    color: AppColor
                                                                        .tableRowTextColor,
                                                                    size: 16,
                                                                  ),
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    controller.type3[index].offerId?.isActive ??
                                                                            false
                                                                        ? Container(
                                                                            height:
                                                                                30,
                                                                            width:
                                                                                30,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(5),
                                                                              color: AppColor.btnGreenColor,
                                                                            ),
                                                                            alignment:
                                                                                Alignment.center,
                                                                            child:
                                                                                const Icon(
                                                                              FluentIcons.check_mark,
                                                                              color: AppColor.white,
                                                                              size: 22,
                                                                            ),
                                                                          )
                                                                        : Container(
                                                                            alignment:
                                                                                Alignment.center,
                                                                            height:
                                                                                30,
                                                                            width:
                                                                                30,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(5),
                                                                              color: AppColor.btnRedColor,
                                                                            ),
                                                                            child:
                                                                                const Icon(
                                                                              FluentIcons.clear,
                                                                              color: AppColor.white,
                                                                              size: 15,
                                                                            ),
                                                                          ),
                                                                  ],
                                                                ),
                                                                Text(
                                                                  controller
                                                                          .type3[
                                                                              index]
                                                                          .offerId
                                                                          ?.validOn ??
                                                                      "",
                                                                  style: AppTextStyle
                                                                      .semiBoldStyle(
                                                                    color: AppColor
                                                                        .tableRowTextColor,
                                                                    size: 16,
                                                                  ),
                                                                ),
                                                                Obx(
                                                                  () => !controller
                                                                              .isProcess
                                                                              .value &&
                                                                          controller.type3[index].sId ==
                                                                              controller
                                                                                  .bId.value
                                                                      ? CustomCircularIndicator
                                                                          .indicator(
                                                                          color1: Colors
                                                                              .white
                                                                              .withOpacity(0.25),
                                                                          color:
                                                                              AppColor.primary,
                                                                        )
                                                                      : Row(
                                                                          children: [
                                                                            IconButton(
                                                                              icon: const Icon(
                                                                                FluentIcons.edit,
                                                                                color: AppColor.white,
                                                                              ),
                                                                              onPressed: () {
                                                                                Navigator.pushNamed(
                                                                                  context,
                                                                                  '/add_update_banner',
                                                                                  arguments: {
                                                                                    'isEdit': true,
                                                                                    'data': controller.type3[index],
                                                                                  },
                                                                                ).then(
                                                                                  (value) {
                                                                                    if (value is bool && value) {
                                                                                      controller.getBannerList();
                                                                                    }
                                                                                  },
                                                                                );
                                                                              },
                                                                              style: ButtonStyle(
                                                                                backgroundColor: WidgetStateProperty.all(Colors.green),
                                                                              ),
                                                                            ),
                                                                            const Gap(10),
                                                                            IconButton(
                                                                              icon: const Icon(
                                                                                FluentIcons.red_eye,
                                                                                color: AppColor.white,
                                                                              ),
                                                                              onPressed: () {
                                                                                Navigator.pushNamed(
                                                                                  context,
                                                                                  '/view_banner',
                                                                                  arguments: controller.type3[index],
                                                                                );
                                                                              },
                                                                              style: ButtonStyle(
                                                                                backgroundColor: WidgetStateProperty.all(Colors.blue),
                                                                              ),
                                                                            ),
                                                                            const Gap(10),
                                                                            IconButton(
                                                                              icon: const Icon(
                                                                                FluentIcons.delete,
                                                                                color: AppColor.white,
                                                                              ),
                                                                              onPressed: () {
                                                                                controller.showDeleteDialog(
                                                                                  ctx: context,
                                                                                  i: index,
                                                                                  id: controller.type3[index].sId ?? "",
                                                                                );
                                                                              },
                                                                              style: ButtonStyle(
                                                                                backgroundColor: WidgetStateProperty.all(Colors.red),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                    separatorBuilder:
                                                        (context, index) =>
                                                            const Gap(20),
                                                    itemCount:
                                                        controller.type3.length,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                    : CustomCircularIndicator.indicator(
                                        color1: Colors.grey.withOpacity(0.5),
                                        color: AppColor.black,
                                      ),
                          ),
                          const Gap(20),
                        ],
                      ),
                    ),
                  ),
                  Tab(
                    text: Text(
                      'Request Banner',
                      style: controller.tabTextStyle(index: 1),
                    ),
                    body: Container(
                      height: hit,
                      width: wid,
                      color: AppColor.white,
                      padding:
                          const EdgeInsets.only(top: 20, left: 20, right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Request Banner',
                            style: AppTextStyle.semiBoldStyle(
                              size: 32,
                              color: AppColor.black300,
                            ),
                          ),
                          const Gap(20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              controller.isError1.value ||
                                      controller.requestList.isEmpty
                                  ? const Gap(0)
                                  : Text(
                                      'Show ${controller.requestList.length} Entries',
                                      style: GoogleFonts.poppins(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                            ],
                          ),
                          const Gap(20),
                          Obx(
                            () => controller.isError1.value ||
                                    controller.requestList.isEmpty
                                ? const Gap(0)
                                : Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 14,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColor.tableHeaderBgColor,
                                      borderRadius: BorderRadius.circular(4),
                                      boxShadow: [
                                        BoxShadow(
                                          offset: const Offset(0, 2),
                                          blurRadius: 4,
                                          color:
                                              AppColor.black.withOpacity(0.5),
                                        )
                                      ],
                                    ),
                                    alignment: Alignment.center,
                                    child: Table(
                                      columnWidths: const {
                                        0: FixedColumnWidth(50),
                                        1: FixedColumnWidth(150),
                                        2: FixedColumnWidth(200),
                                        3: FlexColumnWidth(),
                                        4: FixedColumnWidth(150),
                                        5: FlexColumnWidth(),
                                        6: FlexColumnWidth(),
                                      },
                                      children: [
                                        TableRow(
                                          children: [
                                            Text(
                                              'No.',
                                              style: AppTextStyle.semiBoldStyle(
                                                color: AppColor.black,
                                                size: 20,
                                              ),
                                            ),
                                            Text(
                                              'Image',
                                              style: AppTextStyle.semiBoldStyle(
                                                color: AppColor.black,
                                                size: 20,
                                              ),
                                            ),
                                            Text(
                                              'Description',
                                              style: AppTextStyle.semiBoldStyle(
                                                color: AppColor.black,
                                                size: 20,
                                              ),
                                            ),
                                            Text(
                                              'Offer details',
                                              style: AppTextStyle.semiBoldStyle(
                                                color: AppColor.black,
                                                size: 20,
                                              ),
                                            ),
                                            Text(
                                              'Offer Status',
                                              style: AppTextStyle.semiBoldStyle(
                                                color: AppColor.black,
                                                size: 20,
                                              ),
                                            ),
                                            Text(
                                              'Valid on',
                                              style: AppTextStyle.semiBoldStyle(
                                                color: AppColor.black,
                                                size: 20,
                                              ),
                                            ),
                                            Text(
                                              'Type',
                                              style: AppTextStyle.semiBoldStyle(
                                                color: AppColor.black,
                                                size: 20,
                                              ),
                                            ),
                                            Text(
                                              'Action',
                                              style: AppTextStyle.semiBoldStyle(
                                                color: AppColor.black,
                                                size: 20,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                          ),
                          const Gap(20),
                          Obx(
                            () => controller.isError1.value
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Gap(30),
                                      const Icon(
                                        FluentIcons.search_issue,
                                        size: 80,
                                        color: AppColor.black,
                                      ),
                                      const Gap(20),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "Something went wrong please try again.",
                                              textAlign: TextAlign.center,
                                              style: AppTextStyle.boldStyle(
                                                size: 20,
                                                color: AppColor.black,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                : controller.isLoaded1.value
                                    ? controller.requestList.isEmpty
                                        ? Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      "Banner requests not found.",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: AppTextStyle
                                                          .boldStyle(
                                                        size: 20,
                                                        color: AppColor.black,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )
                                        : Expanded(
                                            child: ListView.separated(
                                              itemBuilder: (context, index) {
                                                return Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 20.0),
                                                  child: Table(
                                                    columnWidths: const {
                                                      0: FixedColumnWidth(50),
                                                      1: FixedColumnWidth(150),
                                                      2: FixedColumnWidth(200),
                                                      3: FlexColumnWidth(),
                                                      4: FixedColumnWidth(150),
                                                      5: FlexColumnWidth(),
                                                      6: FlexColumnWidth(),
                                                    },
                                                    children: [
                                                      TableRow(
                                                        children: [
                                                          Text(
                                                            '${index + 1}',
                                                            style: AppTextStyle
                                                                .semiBoldStyle(
                                                              color: AppColor
                                                                  .tableRowTextColor,
                                                              size: 16,
                                                            ),
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              controller
                                                                  .zoomImage(
                                                                data: controller
                                                                    .requestList[
                                                                        index]
                                                                    .image!
                                                                    .data!,
                                                                ctx: context,
                                                                wid: wid,
                                                              );
                                                            },
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                right: 10.0,
                                                              ),
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                child: Image
                                                                    .memory(
                                                                  Uint8List
                                                                      .fromList(
                                                                    controller
                                                                        .requestList[
                                                                            index]
                                                                        .image!
                                                                        .data!,
                                                                  ),
                                                                  height: 150,
                                                                  width: 150,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                              right: 10.0,
                                                            ),
                                                            child: Text(
                                                              controller
                                                                      .requestList[
                                                                          index]
                                                                      .offerId
                                                                      ?.description ??
                                                                  "",
                                                              style: AppTextStyle
                                                                  .semiBoldStyle(
                                                                color: AppColor
                                                                    .tableRowTextColor,
                                                                size: 16,
                                                              ),
                                                            ),
                                                          ),
                                                          Text(
                                                            'Product price: ${controller.requestList[index].offerId?.productPrice ?? 0} ₹\nDiscount price: ${controller.requestList[index].offerId?.offerPrice ?? 0} ${controller.requestList[index].offerId?.offertype == "Amount" ? '₹' : '%'}\nPayment amount: ${controller.requestList[index].offerId?.paymentAmount ?? 0} ₹',
                                                            style: AppTextStyle
                                                                .semiBoldStyle(
                                                              color: AppColor
                                                                  .tableRowTextColor,
                                                              size: 16,
                                                            ),
                                                          ),
                                                          Row(
                                                            children: [
                                                              controller
                                                                          .requestList[
                                                                              index]
                                                                          .offerId
                                                                          ?.isActive ??
                                                                      false
                                                                  ? Container(
                                                                      height:
                                                                          30,
                                                                      width: 30,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(5),
                                                                        color: AppColor
                                                                            .btnGreenColor,
                                                                      ),
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      child:
                                                                          const Icon(
                                                                        FluentIcons
                                                                            .check_mark,
                                                                        color: AppColor
                                                                            .white,
                                                                        size:
                                                                            22,
                                                                      ),
                                                                    )
                                                                  : Container(
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      height:
                                                                          30,
                                                                      width: 30,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(5),
                                                                        color: AppColor
                                                                            .btnRedColor,
                                                                      ),
                                                                      child:
                                                                          const Icon(
                                                                        FluentIcons
                                                                            .clear,
                                                                        color: AppColor
                                                                            .white,
                                                                        size:
                                                                            15,
                                                                      ),
                                                                    ),
                                                            ],
                                                          ),
                                                          Text(
                                                            controller
                                                                    .requestList[
                                                                        index]
                                                                    .offerId
                                                                    ?.validOn ??
                                                                "",
                                                            style: AppTextStyle
                                                                .semiBoldStyle(
                                                              color: AppColor
                                                                  .tableRowTextColor,
                                                              size: 16,
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                              right: 10.0,
                                                            ),
                                                            child: Text(
                                                              controller.getBannerTypeName(
                                                                  type: controller
                                                                          .requestList[
                                                                              index]
                                                                          .type ??
                                                                      ""),
                                                              style: AppTextStyle
                                                                  .semiBoldStyle(
                                                                color: AppColor
                                                                    .tableRowTextColor,
                                                                size: 16,
                                                              ),
                                                            ),
                                                          ),
                                                          Obx(
                                                            () => !controller
                                                                        .isProcess
                                                                        .value &&
                                                                    controller
                                                                            .requestList[
                                                                                index]
                                                                            .sId ==
                                                                        controller
                                                                            .bId
                                                                            .value
                                                                ? CustomCircularIndicator
                                                                    .indicator(
                                                                    color1: Colors
                                                                        .white
                                                                        .withOpacity(
                                                                            0.25),
                                                                    color: AppColor
                                                                        .primary,
                                                                  )
                                                                : Wrap(
                                                                    runSpacing:
                                                                        10,
                                                                    spacing: 5,
                                                                    children: [
                                                                      Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.min,
                                                                        children: [
                                                                          FilledButton(
                                                                            onPressed:
                                                                                () {
                                                                              controller.showConfirmationDialog(
                                                                                ctx: context,
                                                                                i: index,
                                                                                isAccept: true,
                                                                                type: index,
                                                                              );
                                                                            },
                                                                            style:
                                                                                ButtonStyle(
                                                                              backgroundColor: WidgetStateProperty.all(
                                                                                Colors.green,
                                                                              ),
                                                                            ),
                                                                            child:
                                                                                Row(
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              children: [
                                                                                const Icon(
                                                                                  FluentIcons.accept,
                                                                                  color: AppColor.white,
                                                                                  size: 15,
                                                                                  weight: 15,
                                                                                ),
                                                                                const Gap(3),
                                                                                Text(
                                                                                  "Accept",
                                                                                  style: AppTextStyle.semiBoldStyle(
                                                                                    color: AppColor.white,
                                                                                    size: 14,
                                                                                  ),
                                                                                ),
                                                                                const Gap(3),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      const Gap(
                                                                          5),
                                                                      Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.min,
                                                                        children: [
                                                                          FilledButton(
                                                                            onPressed:
                                                                                () {
                                                                              controller.showConfirmationDialog(
                                                                                ctx: context,
                                                                                i: index,
                                                                                isAccept: false,
                                                                                type: index,
                                                                              );
                                                                            },
                                                                            style:
                                                                                ButtonStyle(
                                                                              backgroundColor: WidgetStateProperty.all(
                                                                                Colors.red,
                                                                              ),
                                                                            ),
                                                                            child:
                                                                                Row(
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              children: [
                                                                                const Icon(
                                                                                  FluentIcons.cancel,
                                                                                  color: AppColor.white,
                                                                                  size: 15,
                                                                                  weight: 15,
                                                                                ),
                                                                                const Gap(3),
                                                                                Text(
                                                                                  "Reject",
                                                                                  style: AppTextStyle.semiBoldStyle(
                                                                                    color: AppColor.white,
                                                                                    size: 14,
                                                                                  ),
                                                                                ),
                                                                                const Gap(3),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                              separatorBuilder:
                                                  (context, index) =>
                                                      const Gap(20),
                                              itemCount:
                                                  controller.requestList.length,
                                            ),
                                          )
                                    : CustomCircularIndicator.indicator(
                                        color1: Colors.grey.withOpacity(0.5),
                                        color: AppColor.black,
                                      ),
                          ),
                          const Gap(20),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
