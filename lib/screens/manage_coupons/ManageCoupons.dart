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
                  _buildManagePromoCoupon(hit, wid, context),
                  _buildManageCouponDialog(hit, wid, context),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  _buildManagePromoCoupon(double hit, double wid, BuildContext context) {
    return Tab(
      text: Text(
        'Manage Promo Codes',
        style: controller.tabTextStyle(index: 0),
      ),
      body: Container(
        height: hit,
        width: wid,
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
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
                  controller.isCouponError.value || controller.promoList.isEmpty
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
                      backgroundColor: WidgetStateProperty.all(Colors.green),
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

            // Table Header - always shown
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              decoration: BoxDecoration(
                color: AppColor.tableHeaderBgColor,
                borderRadius: BorderRadius.circular(4),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 2),
                    blurRadius: 4,
                    color: AppColor.black.withOpacity(0.5),
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
                      Text('No.',
                          style: AppTextStyle.semiBoldStyle(
                              color: AppColor.black, size: 20)),
                      Text('Promo code',
                          style: AppTextStyle.semiBoldStyle(
                              color: AppColor.black, size: 20)),
                      Text('Description',
                          style: AppTextStyle.semiBoldStyle(
                              color: AppColor.black, size: 20)),
                      Text('Discount',
                          style: AppTextStyle.semiBoldStyle(
                              color: AppColor.black, size: 20)),
                      Text('Order value',
                          style: AppTextStyle.semiBoldStyle(
                              color: AppColor.black, size: 20)),
                      Text('Used by',
                          style: AppTextStyle.semiBoldStyle(
                              color: AppColor.black, size: 20)),
                      Text('Expiry date',
                          style: AppTextStyle.semiBoldStyle(
                              color: AppColor.black, size: 20)),
                      Text('Action',
                          style: AppTextStyle.semiBoldStyle(
                              color: AppColor.black, size: 20)),
                    ],
                  ),
                ],
              ),
            ),

            const Gap(20),

            // Promo rows, error, empty or loading
            Expanded(
              child: Obx(
                () {
                  if (controller.isCouponError.value) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Gap(30),
                        const Icon(FluentIcons.search_issue,
                            size: 80, color: AppColor.black),
                        const Gap(20),
                        Text(
                          "Something went wrong please try again.",
                          textAlign: TextAlign.center,
                          style: AppTextStyle.boldStyle(
                              size: 20, color: AppColor.black),
                        ),
                      ],
                    );
                  } else if (controller.isCouponLoaded.value) {
                    if (controller.promoList.isEmpty) {
                      return Center(
                        child: Text(
                          "Promo-code data not found.",
                          style: AppTextStyle.boldStyle(
                              size: 20, color: AppColor.black),
                        ),
                      );
                    } else {
                      return ListView.separated(
                        itemBuilder: (context, index) {
                          final promo = controller.promoList[index];
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Table(
                              columnWidths: const {
                                0: FixedColumnWidth(50),
                              },
                              children: [
                                TableRow(
                                  children: [
                                    Text('${index + 1}',
                                        style: AppTextStyle.semiBoldStyle(
                                            color: AppColor.tableRowTextColor,
                                            size: 16)),
                                    Text(promo.promocode ?? "",
                                        style: AppTextStyle.semiBoldStyle(
                                            color: AppColor.tableRowTextColor,
                                            size: 16)),
                                    Text(promo.description ?? "",
                                        maxLines: 2,
                                        style: AppTextStyle.semiBoldStyle(
                                            color: AppColor.tableRowTextColor,
                                            size: 16)),
                                    Text(
                                        "${promo.discount ?? ""} ${promo.discountType == "Amount" ? '₹' : '%'}",
                                        style: AppTextStyle.semiBoldStyle(
                                            color: AppColor.tableRowTextColor,
                                            size: 16)),
                                    Text("${promo.neededAmount ?? ""} ₹",
                                        style: AppTextStyle.semiBoldStyle(
                                            color: AppColor.tableRowTextColor,
                                            size: 16)),
                                    Text("${promo.usedBy?.length ?? "0"} users",
                                        style: AppTextStyle.semiBoldStyle(
                                            color: AppColor.tableRowTextColor,
                                            size: 16)),
                                    Text(
                                      DateFormat("dd MMMM, yyyy").format(
                                          DateTime.parse(promo.expiryDate ??
                                                  "${DateTime.now()}")
                                              .toLocal()),
                                      maxLines: 1,
                                      style: AppTextStyle.semiBoldStyle(
                                          color: AppColor.tableRowTextColor,
                                          size: 16),
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: const Icon(FluentIcons.edit,
                                              color: AppColor.white),
                                          onPressed: () {
                                            controller.showAddUpdateDialog(
                                              ctx: context,
                                              title: "Update promo-code",
                                              isEdit: true,
                                              promocode: promo,
                                            );
                                          },
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  WidgetStateProperty.all(
                                                      Colors.green)),
                                        ),
                                        const Gap(10),
                                        IconButton(
                                          icon: const Icon(FluentIcons.red_eye,
                                              color: AppColor.white),
                                          onPressed: () {
                                            controller.showDetailDialog(
                                              ctx: context,
                                              title: "View promo details",
                                              content: controller
                                                  .showPromoDetail(data: promo),
                                            );
                                          },
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  WidgetStateProperty.all(
                                                      Colors.blue)),
                                        ),
                                        const Gap(10),
                                        IconButton(
                                          icon: const Icon(FluentIcons.delete,
                                              color: AppColor.white),
                                          onPressed: () {
                                            controller.showDeleteDialog(
                                                ctx: context, i: index);
                                          },
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  WidgetStateProperty.all(
                                                      Colors.red)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => const Gap(20),
                        itemCount: controller.promoList.length,
                      );
                    }
                  } else {
                    return CustomCircularIndicator.indicator(
                      color1: Colors.grey.withOpacity(0.5),
                      color: AppColor.black,
                    );
                  }
                },
              ),
            ),

            const Gap(20),
          ],
        ),
      ),
    );
  }

  _buildManageCouponDialog(double hit, double wid, BuildContext context) {
    return Tab(
      text: Text(
        'Redeemed Promo-code',
        style: controller.tabTextStyle(index: 1),
      ),
      body: Container(
        height: hit,
        width: wid,
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
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

            // Total Entries Count
            Obx(() => controller.isRedeemedCouponError.value ||
                    controller.redeemedCouponList.isEmpty
                ? const Gap(0)
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Show ${controller.redeemedCouponList.map((e) => e.usedBy?.length ?? 0).fold(0, (a, b) => a + b)} Entries',
                        style: AppTextStyle.semiBoldStyle(
                          size: 24,
                          color: AppColor.smokyBlack,
                        ),
                      ),
                    ],
                  )),

            const Gap(20),

            // Table Header (Always visible)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              decoration: BoxDecoration(
                color: AppColor.tableHeaderBgColor,
                borderRadius: BorderRadius.circular(4),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 2),
                    blurRadius: 4,
                    color: AppColor.black.withOpacity(0.5),
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
                      _tableHeader('No.'),
                      _tableHeader('Take by'),
                      _tableHeader('Promo Code'),
                      _tableHeader('Take Date'),
                      _tableHeader('Created'),
                      _tableHeader('Expires'),
                      _tableHeader('Status'),
                      _tableHeader('Action'),
                    ],
                  ),
                ],
              ),
            ),

            const Gap(20),

            // Table Body / States
            Obx(() {
              if (controller.isRedeemedCouponError.value) {
                return _buildErrorWidget();
              } else if (controller.isRedeemedCouponLoaded.value) {
                if (controller.redeemedCouponList.isEmpty) {
                  return _buildEmptyWidget("Redeemed coupons data not found.");
                } else {
                  controller.no = 0;
                  return Expanded(
                    child: ListView.separated(
                      itemCount: controller.redeemedCouponList.length,
                      separatorBuilder: (_, __) => const Gap(20),
                      itemBuilder: (context, index) {
                        return _buildCouponEntries(context, index);
                      },
                    ),
                  );
                }
              } else {
                return CustomCircularIndicator.indicator(
                  color1: Colors.grey.withOpacity(0.5),
                  color: AppColor.black,
                );
              }
            }),

            const Gap(20),
          ],
        ),
      ),
    );
  }

// Helper for header cells
  Widget _tableHeader(String title) => Text(
        title,
        style: AppTextStyle.semiBoldStyle(
          color: AppColor.black,
          size: 20,
        ),
      );

// Helper for error state
  Widget _buildErrorWidget() => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Gap(30),
          const Icon(FluentIcons.search_issue, size: 80, color: AppColor.black),
          const Gap(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  "Something went wrong please try again.",
                  textAlign: TextAlign.center,
                  style:
                      AppTextStyle.boldStyle(size: 20, color: AppColor.black),
                ),
              ),
            ],
          ),
        ],
      );

// Helper for empty state
  Widget _buildEmptyWidget(String message) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                  style:
                      AppTextStyle.boldStyle(size: 20, color: AppColor.black),
                ),
              ),
            ],
          ),
        ],
      );

// Helper for building coupon entries
  Widget _buildCouponEntries(BuildContext context, int index) {
    final coupon = controller.redeemedCouponList[index];
    if ((coupon.usedBy?.isEmpty ?? true)) return const SizedBox();

    return ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: coupon.usedBy?.length ?? 0,
      separatorBuilder: (_, __) => const Gap(20),
      itemBuilder: (context, i) {
        final user = coupon.usedBy![i];
        controller.no++;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Table(
            columnWidths: const {
              0: FixedColumnWidth(50),
              7: FixedColumnWidth(100),
            },
            children: [
              TableRow(
                children: [
                  _tableCell('${controller.no}'),
                  _tableCell(user.userId?.userName ?? ""),
                  _tableCell(coupon.promocode ?? ""),
                  _tableCell(DateFormat("dd MMMM, yyyy").format(
                      DateTime.parse(user.usedAt ?? "${DateTime.now()}")
                          .toLocal())),
                  _tableCell(DateFormat("dd MMMM, yyyy").format(
                      DateTime.parse(coupon.updatedAt ?? "${DateTime.now()}")
                          .toLocal())),
                  _tableCell(DateFormat("dd MMMM, yyyy").format(
                      DateTime.parse(coupon.expiryDate ?? "${DateTime.now()}")
                          .toLocal())),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: AppColor.btnGreenColor,
                        ),
                        child: Text(
                          'REDEEMED',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColor.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(FluentIcons.red_eye,
                            color: AppColor.white),
                        onPressed: () {
                          controller.showDetailDialog(
                            ctx: context,
                            title: "View redeemed promo details",
                            content: controller.showRedeemedPromoDetail(
                              index: i,
                              data: coupon,
                            ),
                          );
                        },
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(Colors.blue),
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
    );
  }

// Helper for table cell styling
  Widget _tableCell(String text) => Text(
        text,
        style: AppTextStyle.semiBoldStyle(
          color: AppColor.tableRowTextColor,
          size: 16,
        ),
      );
}
