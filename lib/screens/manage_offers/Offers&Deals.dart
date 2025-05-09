import '../../utils/imports.dart';

class offers extends GetView<ManageOfferDealsController> {
  const offers({super.key});

  @override
  Widget build(BuildContext context) {
    double hit = MediaQuery.of(context).size.height;
    double wid = MediaQuery.of(context).size.width;

    return GetBuilder<ManageOfferDealsController>(
      init: ManageOfferDealsController(ctx: context),
      builder: (controller) {
        return Container(
          height: hit,
          width: wid,
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          color: AppColor.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Manage Offers',
                style: AppTextStyle.semiBoldStyle(
                  size: 32,
                  color: AppColor.black300,
                ),
              ),
              const Gap(20),
              Obx(() {
                bool isEmpty =
                    controller.isError.value || controller.allOffer.isEmpty;
                return Row(
                  mainAxisAlignment: isEmpty
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.spaceBetween,
                  children: [
                    if (!isEmpty)
                      Text(
                        'Show ${controller.allOffer.length} Entries',
                        style: AppTextStyle.semiBoldStyle(
                          size: 24,
                          color: AppColor.smokyBlack,
                        ),
                      ),
                    _buildAddOfferButton(context, controller),
                  ],
                );
              }),
              const Gap(20),
              Obx(() {
                if (controller.isError.value || controller.allOffer.isEmpty) {
                  return const Gap(0);
                }
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: AppColor.tableHeaderBgColor,
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 2),
                        blurRadius: 4,
                        color: AppColor.black.withValues(alpha: 0.5),
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Table(
                    columnWidths: const {
                      0: FixedColumnWidth(50),
                      4: FixedColumnWidth(100),
                      6: FixedColumnWidth(120),
                    },
                    children: [_buildTableHeader()],
                  ),
                );
              }),
              const Gap(20),
              Obx(() {
                if (controller.isError.value) {
                  return _buildErrorState();
                } else if (controller.isLoaded.value) {
                  if (controller.allOffer.isEmpty) return _buildEmptyState();
                  return Expanded(
                    child: ListView.separated(
                      itemCount: controller.allOffer.length,
                      itemBuilder: (context, index) {
                        return _buildOfferRow(context, controller, index);
                      },
                      separatorBuilder: (context, index) => const Gap(20),
                    ),
                  );
                } else {
                  return CustomCircularIndicator.indicator(
                    color1: Colors.grey.withValues(alpha: 0.5),
                    color: AppColor.black,
                  );
                }
              }),
              const Gap(20),
            ],
          ),
        );
      },
    );
  }

  // ===================== Extracted Widgets =======================

  Widget _buildAddOfferButton(
      BuildContext context, ManageOfferDealsController controller) {
    return FilledButton(
      onPressed: () {
        controller.showAddUpdateDialog(ctx: context, title: "Add offer");
      },
      style: const ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(AppColor.btnGreenColor),
      ),
      child: const Text(
        '+ Add New Offer',
        style: TextStyle(color: AppColor.white),
      ),
    );
  }

  TableRow _buildTableHeader() {
    List<String> headers = [
      'No.',
      'Offer description',
      'Offer price',
      'Valid on',
      'Status',
      'Business detail',
      'Action'
    ];
    return TableRow(
      children: headers.map((h) => _buildHeaderCell(h)).toList(),
    );
  }

  Widget _buildHeaderCell(String label) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Text(
        label,
        style: AppTextStyle.semiBoldStyle(color: AppColor.black, size: 20),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
    );
  }

  Widget _buildErrorState() {
    return Column(
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
                style: AppTextStyle.boldStyle(size: 20, color: AppColor.black),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                "Offers not found.",
                textAlign: TextAlign.center,
                style: AppTextStyle.boldStyle(size: 20, color: AppColor.black),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildOfferRow(
    BuildContext context,
    ManageOfferDealsController controller,
    int index,
  ) {
    final offer = controller.allOffer[index];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Table(
        columnWidths: const {
          0: FixedColumnWidth(50),
          4: FixedColumnWidth(100),
          6: FixedColumnWidth(120),
        },
        children: [
          TableRow(
            children: [
              Text(
                '${index + 1}',
                style: AppTextStyle.semiBoldStyle(
                  color: AppColor.tableRowTextColor,
                  size: 16,
                ),
              ),
              _buildTextCell(offer.description ?? "", 2),
              _buildTextCell(
                'Product price: ${offer.productPrice ?? 0} ₹\n'
                'Discount price: ${offer.offerPrice ?? 0} ${offer.offertype == "Amount" ? '₹' : '%'}\n'
                'Payment amount: ${offer.paymentAmount ?? 0} ₹',
                3,
              ),
              _buildTextCell(offer.validOn ?? "", 1),
              _buildStatusCell(offer.isActive ?? false),
              _buildBusinessDetailCell(offer),
              _buildActionCell(context, controller, index, offer),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTextCell(String text, int maxLines) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Text(
        text,
        style: AppTextStyle.semiBoldStyle(
          color: AppColor.tableRowTextColor,
          size: 16,
        ),
        overflow: TextOverflow.ellipsis,
        maxLines: maxLines,
      ),
    );
  }

  Widget _buildStatusCell(bool isActive) {
    return Container(
      alignment: Alignment.center,
      height: 30,
      width: 30,
      decoration: BoxDecoration(
        color: isActive ? AppColor.btnGreenColor : AppColor.btnRedColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Icon(
        isActive ? FluentIcons.check_mark : FluentIcons.clear,
        color: AppColor.white,
        size: isActive ? 22 : 15,
      ),
    );
  }

  Widget _buildBusinessDetailCell(offer) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Business name",
            style: AppTextStyle.semiBoldStyle(
              color: AppColor.tableRowTextColor,
              size: 16,
            ),
          ),
          Text(
            offer.businessId?.businessName ?? "",
            style: AppTextStyle.mediumStyle(
              color: AppColor.tableRowTextColor,
              size: 14,
            ),
          ),
          Text(
            "Business contact",
            style: AppTextStyle.semiBoldStyle(
              color: AppColor.tableRowTextColor,
              size: 16,
            ),
          ),
          Text(
            offer.businessId?.contactNumber ?? "",
            style: AppTextStyle.mediumStyle(
              color: AppColor.tableRowTextColor,
              size: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionCell(
    BuildContext context,
    ManageOfferDealsController controller,
    int index,
    dynamic offer,
  ) {
    return Obx(() {
      bool isLoading =
          !controller.isProcess.value && offer.sId == controller.oId.value;
      if (isLoading) {
        return CustomCircularIndicator.indicator(
          color1: Colors.white.withValues(alpha: 0.25),
          color: AppColor.primary,
        );
      }
      return Expanded(
        child: Wrap(
          runSpacing: 10,
          children: [
            _buildIconButton(
              icon: FluentIcons.edit,
              color: Colors.green,
              onPressed: () {
                controller.showAddUpdateDialog(
                  ctx: context,
                  title: "Update offer",
                  isEdit: true,
                  offer: offer,
                );
              },
            ),
            _buildIconButton(
              icon: FluentIcons.red_eye,
              color: Colors.blue,
              onPressed: () {
                controller.viewDetailDialog(ctx: context, offer: offer);
              },
            ),
            _buildIconButton(
              icon: FluentIcons.delete,
              color: Colors.red,
              onPressed: () {
                controller.showDeleteDialog(ctx: context, i: index);
              },
            ),
          ],
        ),
      );
    });
  }

  Widget _buildIconButton({
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 5),
      child: IconButton(
        icon: Icon(icon),
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(color),
        ),
      ),
    );
  }
}
