import 'package:pro_deals_admin/utils/imports.dart';

class ManageCoupons extends GetView<ManageCouponController> {
  const ManageCoupons({super.key});

  @override
  Widget build(BuildContext context) {
    double hit = MediaQuery.of(context).size.height;
    double wid = MediaQuery.of(context).size.width;
    return GetBuilder<ManageCouponController>(
      init: ManageCouponController(ctx: context),
      builder: (controller) {
        return FluentThemeWidget(
          widget: Obx(
            () => Container(
              color: AppColor.white,
              child: TabView(
                currentIndex: controller.currentIndex.value,
                onChanged: (index) => controller.currentIndex.value = index,
                closeButtonVisibility: CloseButtonVisibilityMode.never,
                tabWidthBehavior: TabWidthBehavior.sizeToContent,
                tabs: [
                  Tab(
                    text: Text(
                      'Manage Promo Codes',
                      style: controller.tabTextStyle(index: 0),
                    ),
                    body: Container(
                      height: hit,
                      width: wid,
                      padding:
                          const EdgeInsets.only(top: 20, left: 20, right: 20),
                      color: AppColor.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Manage Promo-code',
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
                                controller.isCouponError.value ||
                                        controller.promoList.isEmpty
                                    ? const Gap(0)
                                    : Text(
                                        'Show ${controller.promoList.length} Entries',
                                        style: AppTextStyle.semiBoldStyle(
                                          size: 24,
                                          color: AppColor.smokyBlack,
                                        ),
                                      ),
                                FilledButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        WidgetStateProperty.all(Colors.green),
                                  ),
                                  onPressed: () {
                                    controller.showAddUpdateDialog(
                                      ctx: context,
                                      title: "Add promo-code",
                                    );
                                  },
                                  child: const Text('+ Create Promo-code'),
                                ),
                              ],
                            ),
                          ),
                          const Gap(20),
                          Obx(
                            () => controller.isCouponError.value ||
                                    controller.promoList.isEmpty
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
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 8.0),
                                              child: Text(
                                                'Promo code',
                                                style:
                                                    AppTextStyle.semiBoldStyle(
                                                  color: AppColor.black,
                                                  size: 20,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 8.0),
                                              child: Text(
                                                'Description',
                                                style:
                                                    AppTextStyle.semiBoldStyle(
                                                  color: AppColor.black,
                                                  size: 20,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Text(
                                              'Discount',
                                              style: AppTextStyle.semiBoldStyle(
                                                color: AppColor.black,
                                                size: 20,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Text(
                                              'Order value',
                                              style: AppTextStyle.semiBoldStyle(
                                                color: AppColor.black,
                                                size: 20,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Text(
                                              'Used by',
                                              style: AppTextStyle.semiBoldStyle(
                                                color: AppColor.black,
                                                size: 20,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 8.0),
                                              child: Text(
                                                'Expiry date',
                                                style:
                                                    AppTextStyle.semiBoldStyle(
                                                  color: AppColor.black,
                                                  size: 20,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Text(
                                              'Action',
                                              style: AppTextStyle.semiBoldStyle(
                                                color: AppColor.black,
                                                size: 20,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                          ),
                          const Gap(20),
                          Obx(
                            () => controller.isCouponError.value
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
                                : controller.isCouponLoaded.value
                                    ? controller.promoList.isEmpty
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
                                                      "Promo-code data not found.",
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
                                                          Text(
                                                            controller
                                                                    .promoList[
                                                                        index]
                                                                    .promocode ??
                                                                "",
                                                            style: AppTextStyle
                                                                .semiBoldStyle(
                                                              color: AppColor
                                                                  .tableRowTextColor,
                                                              size: 16,
                                                            ),
                                                          ),
                                                          Text(
                                                            controller
                                                                    .promoList[
                                                                        index]
                                                                    .description ??
                                                                "",
                                                            maxLines: 2,
                                                            style: AppTextStyle
                                                                .semiBoldStyle(
                                                              color: AppColor
                                                                  .tableRowTextColor,
                                                              size: 16,
                                                            ),
                                                          ),
                                                          Text(
                                                            "${controller.promoList[index].discount ?? ""} ${controller.promoList[index].discountType == "Amount" ? '₹' : '%'}",
                                                            style: AppTextStyle
                                                                .semiBoldStyle(
                                                              color: AppColor
                                                                  .tableRowTextColor,
                                                              size: 16,
                                                            ),
                                                          ),
                                                          Text(
                                                            "${controller.promoList[index].neededAmount ?? ""} ₹",
                                                            style: AppTextStyle
                                                                .semiBoldStyle(
                                                              color: AppColor
                                                                  .tableRowTextColor,
                                                              size: 16,
                                                            ),
                                                          ),
                                                          Text(
                                                            "${controller.promoList[index].usedBy?.length ?? "0"} users",
                                                            style: AppTextStyle
                                                                .semiBoldStyle(
                                                              color: AppColor
                                                                  .tableRowTextColor,
                                                              size: 16,
                                                            ),
                                                          ),
                                                          Text(
                                                            DateFormat(
                                                                    "dd MMMM, yyyy")
                                                                .format(DateTime.parse(controller
                                                                            .promoList[index]
                                                                            .expiryDate ??
                                                                        "${DateTime.now()}")
                                                                    .toLocal()),
                                                            style: AppTextStyle
                                                                .semiBoldStyle(
                                                              color: AppColor
                                                                  .tableRowTextColor,
                                                              size: 16,
                                                            ),
                                                            maxLines: 1,
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
                                                                onPressed: () {
                                                                  controller
                                                                      .showAddUpdateDialog(
                                                                    ctx:
                                                                        context,
                                                                    title:
                                                                        "Update promo-code",
                                                                    isEdit:
                                                                        true,
                                                                    promocode:
                                                                        controller
                                                                            .promoList[index],
                                                                  );
                                                                },
                                                                style:
                                                                    ButtonStyle(
                                                                  backgroundColor:
                                                                      WidgetStateProperty.all(
                                                                          Colors
                                                                              .green),
                                                                ),
                                                              ),
                                                              const Gap(10),
                                                              IconButton(
                                                                icon:
                                                                    const Icon(
                                                                  FluentIcons
                                                                      .red_eye,
                                                                  color: AppColor
                                                                      .white,
                                                                ),
                                                                onPressed: () {
                                                                  controller
                                                                      .showDetailDialog(
                                                                    ctx:
                                                                        context,
                                                                    title:
                                                                        "View promo details",
                                                                    content:
                                                                        controller
                                                                            .showPromoDetail(
                                                                      data: controller
                                                                              .promoList[
                                                                          index],
                                                                    ),
                                                                  );
                                                                },
                                                                style:
                                                                    ButtonStyle(
                                                                  backgroundColor:
                                                                      WidgetStateProperty.all(
                                                                          Colors
                                                                              .blue),
                                                                ),
                                                              ),
                                                              const Gap(10),
                                                              IconButton(
                                                                icon:
                                                                    const Icon(
                                                                  FluentIcons
                                                                      .delete,
                                                                  color: AppColor
                                                                      .white,
                                                                ),
                                                                onPressed: () {
                                                                  controller
                                                                      .showDeleteDialog(
                                                                    ctx:
                                                                        context,
                                                                    i: index,
                                                                  );
                                                                },
                                                                style:
                                                                    ButtonStyle(
                                                                  backgroundColor:
                                                                      WidgetStateProperty.all(
                                                                          Colors
                                                                              .red),
                                                                ),
                                                              ),
                                                            ],
                                                          )
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
                                                  controller.promoList.length,
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
                      'Redeemed Promo-code',
                      style: controller.tabTextStyle(index: 1),
                    ),
                    body: Container(
                      height: hit,
                      width: wid,
                      padding:
                          const EdgeInsets.only(top: 20, left: 20, right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Redeemed Promo-code',
                            style: AppTextStyle.semiBoldStyle(
                              size: 32,
                              color: AppColor.black300,
                            ),
                          ),
                          const Gap(20),
                          Obx(
                            () => controller.isRedeemedCouponError.value ||
                                    controller.redeemedCouponList.isEmpty
                                ? const Gap(0)
                                : Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Show ${controller.redeemedCouponList.map(
                                              (element) =>
                                                  element.usedBy?.length ?? 0,
                                            ).reduce(
                                              (value, element) =>
                                                  value + element,
                                            )} Entries',
                                        style: AppTextStyle.semiBoldStyle(
                                          size: 24,
                                          color: AppColor.smokyBlack,
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                          const Gap(20),
                          Obx(
                            () => controller.isRedeemedCouponError.value ||
                                    controller.redeemedCouponList.isEmpty
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
                                        7: FixedColumnWidth(100),
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
                                              'Take by',
                                              style: AppTextStyle.semiBoldStyle(
                                                color: AppColor.black,
                                                size: 20,
                                              ),
                                            ),
                                            Text(
                                              'Promo Code',
                                              style: AppTextStyle.semiBoldStyle(
                                                color: AppColor.black,
                                                size: 20,
                                              ),
                                            ),
                                            Text(
                                              'Take Date',
                                              style: AppTextStyle.semiBoldStyle(
                                                color: AppColor.black,
                                                size: 20,
                                              ),
                                            ),
                                            Text(
                                              'Created',
                                              style: AppTextStyle.semiBoldStyle(
                                                color: AppColor.black,
                                                size: 20,
                                              ),
                                            ),
                                            Text(
                                              'Expires',
                                              style: AppTextStyle.semiBoldStyle(
                                                color: AppColor.black,
                                                size: 20,
                                              ),
                                            ),
                                            Text(
                                              'Status',
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
                            () => controller.isRedeemedCouponError.value
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
                                : controller.isRedeemedCouponLoaded.value
                                    ? controller.redeemedCouponList.isEmpty
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
                                                      "Redeemed coupons data not found.",
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
                                                if (index == 0 &&
                                                    controller.no != 0) {
                                                  controller.no = 0;
                                                }
                                                return ListView.separated(
                                                    shrinkWrap: true,
                                                    padding: EdgeInsets.zero,
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    itemBuilder: (context, i) {
                                                      if (controller
                                                              .redeemedCouponList[
                                                                  index]
                                                              .usedBy
                                                              ?.isEmpty ??
                                                          true) {
                                                        return Container();
                                                      }
                                                      controller.no++;
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
                                                            7: FixedColumnWidth(
                                                                100),
                                                          },
                                                          children: [
                                                            TableRow(
                                                              children: [
                                                                Text(
                                                                  '${controller.no}',
                                                                  style: AppTextStyle
                                                                      .semiBoldStyle(
                                                                    color: AppColor
                                                                        .tableRowTextColor,
                                                                    size: 16,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  controller
                                                                          .redeemedCouponList[
                                                                              index]
                                                                          .usedBy?[
                                                                              i]
                                                                          .userId
                                                                          ?.userName ??
                                                                      "",
                                                                  style: AppTextStyle
                                                                      .semiBoldStyle(
                                                                    color: AppColor
                                                                        .tableRowTextColor,
                                                                    size: 16,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  controller
                                                                          .redeemedCouponList[
                                                                              index]
                                                                          .promocode ??
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
                                                                          right:
                                                                              8.0),
                                                                  child: Text(
                                                                    DateFormat(
                                                                            "dd MMMM, yyyy")
                                                                        .format(DateTime.parse(controller.redeemedCouponList[index].usedBy?[i].usedAt ??
                                                                                "${DateTime.now()}")
                                                                            .toLocal()),
                                                                    style: AppTextStyle
                                                                        .semiBoldStyle(
                                                                      color: AppColor
                                                                          .tableRowTextColor,
                                                                      size: 16,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Text(
                                                                  DateFormat(
                                                                          "dd MMMM, yyyy")
                                                                      .format(DateTime.parse(controller.redeemedCouponList[index].updatedAt ??
                                                                              "${DateTime.now()}")
                                                                          .toLocal()),
                                                                  style: AppTextStyle
                                                                      .semiBoldStyle(
                                                                    color: AppColor
                                                                        .tableRowTextColor,
                                                                    size: 16,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  DateFormat(
                                                                          "dd MMMM, yyyy")
                                                                      .format(DateTime.parse(controller.redeemedCouponList[index].expiryDate ??
                                                                              "${DateTime.now()}")
                                                                          .toLocal()),
                                                                  style: AppTextStyle
                                                                      .semiBoldStyle(
                                                                    color: AppColor
                                                                        .tableRowTextColor,
                                                                    size: 16,
                                                                  ),
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Container(
                                                                      padding:
                                                                          const EdgeInsets
                                                                              .symmetric(
                                                                        horizontal:
                                                                            15,
                                                                        vertical:
                                                                            8,
                                                                      ),
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(5),
                                                                        color: AppColor
                                                                            .btnGreenColor,
                                                                      ),
                                                                      child:
                                                                          Text(
                                                                        'Redeemed'
                                                                            .toUpperCase(),
                                                                        style:
                                                                            const TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          color:
                                                                              AppColor.white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Row(
                                                                  children: [
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
                                                                        controller
                                                                            .showDetailDialog(
                                                                          ctx:
                                                                              context,
                                                                          title:
                                                                              "View redeemed promo details",
                                                                          content: controller.showRedeemedPromoDetail(
                                                                              index: i,
                                                                              data: controller.redeemedCouponList[index]),
                                                                        );
                                                                      },
                                                                      style:
                                                                          ButtonStyle(
                                                                        backgroundColor:
                                                                            WidgetStateProperty.all(Colors.blue),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                    separatorBuilder:
                                                        (context, index) =>
                                                            const Gap(20),
                                                    itemCount: controller
                                                            .redeemedCouponList[
                                                                index]
                                                            .usedBy
                                                            ?.length ??
                                                        0);
                                              },
                                              separatorBuilder:
                                                  (context, index) =>
                                                      const Gap(20),
                                              itemCount: controller
                                                  .redeemedCouponList.length,
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
