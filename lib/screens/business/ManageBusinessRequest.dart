import '../../utils/imports.dart';

class ManageBusinessRequest extends GetView<ManageBusinessRequestController> {
  const ManageBusinessRequest({super.key});

  @override
  Widget build(BuildContext context) {
    double hit = MediaQuery.of(context).size.height;
    double wid = MediaQuery.of(context).size.width;

    return GetBuilder<ManageBusinessRequestController>(
      init: ManageBusinessRequestController(ctx: context),
      builder: (controller) {
        return Container(
          height: hit,
          width: wid,
          color: AppColor.white,
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Manage Business Requests',
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
                    Text(
                      'Show ${controller.allRequests.length} Entries',
                      style: AppTextStyle.semiBoldStyle(
                        size: 24,
                        color: AppColor.smokyBlack,
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(20),
              // Always show table header
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
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
                child: Table(
                  columnWidths: const {
                    0: FixedColumnWidth(50),
                    1: FlexColumnWidth(),
                    2: FlexColumnWidth(),
                    3: FlexColumnWidth(),
                    4: FlexColumnWidth(),
                    5: FlexColumnWidth(),
                    6: FlexColumnWidth(1.5),
                  },
                  children: [
                    TableRow(
                      children: [
                        _headerText('No.'),
                        _headerText('Business Name'),
                        _headerText('Business Phone'),
                        _headerText('User Name'),
                        _headerText('User Phone'),
                        _headerText('User Email'),
                        _headerText('Action'),
                      ],
                    ),
                  ],
                ),
              ),
              const Gap(20),
              Obx(
                () {
                  if (controller.isError.value) {
                    return _errorWidget();
                  } else if (controller.isLoaded.value &&
                      controller.allRequests.isEmpty) {
                    return _emptyWidget("Business requests not found.");
                  } else if (controller.isLoaded.value) {
                    return Expanded(
                      child: Scrollbar(
                        thumbVisibility: true,
                        child: ListView.separated(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          itemCount: controller.allRequests.length,
                          separatorBuilder: (_, __) => const Gap(20),
                          itemBuilder: (context, index) {
                            final req = controller.allRequests[index];
                            return Table(
                              columnWidths: const {
                                0: FixedColumnWidth(50),
                                1: FlexColumnWidth(),
                                2: FlexColumnWidth(),
                                3: FlexColumnWidth(),
                                4: FlexColumnWidth(),
                                5: FlexColumnWidth(),
                                6: FlexColumnWidth(1.5),
                              },
                              defaultVerticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              children: [
                                TableRow(
                                  children: [
                                    _rowText('${index + 1}'),
                                    _rowText(req.businessName ?? ""),
                                    _rowText(req.contactNumber ?? ""),
                                    _rowText(req.userId?.userName ?? ""),
                                    _rowText(req.userId?.phone ?? ""),
                                    _rowText(
                                      req.userId?.email ?? "",
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Obx(() {
                                      bool isProcessing =
                                          controller.isProcess.value &&
                                              controller.bId.value == req.sId;

                                      return isProcessing
                                          ? CustomCircularIndicator.indicator(
                                              color1:
                                                  Colors.grey.withOpacity(0.5),
                                              color: AppColor.black,
                                            )
                                          : Wrap(
                                              runSpacing: 10,
                                              spacing: 5,
                                              children: [
                                                _actionButton(
                                                  icon: FluentIcons.accept,
                                                  label: 'Accept',
                                                  color: Colors.green,
                                                  onTap: () => controller
                                                      .showConfirmationDialog(
                                                    ctx: context,
                                                    i: index,
                                                    isAccept: true,
                                                  ),
                                                ),
                                                _actionButton(
                                                  icon: FluentIcons.cancel,
                                                  label: 'Reject',
                                                  color: Colors.red,
                                                  onTap: () => controller
                                                      .showConfirmationDialog(
                                                    ctx: context,
                                                    i: index,
                                                  ),
                                                ),
                                              ],
                                            );
                                    }),
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    );
                  } else {
                    return CustomCircularIndicator.indicator(
                      color1: Colors.grey.withOpacity(0.5),
                      color: AppColor.black,
                    );
                  }
                },
              ),
              const Gap(20),
            ],
          ),
        );
      },
    );
  }

  Widget _headerText(String text) => Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Text(
          text,
          style: AppTextStyle.semiBoldStyle(
            color: AppColor.black,
            size: 20,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      );

  Widget _rowText(String text,
          {TextOverflow overflow = TextOverflow.visible}) =>
      Text(
        text,
        style: AppTextStyle.semiBoldStyle(
          color: AppColor.tableRowTextColor,
          size: 16,
        ),
        maxLines: 1,
        overflow: overflow,
      );

  Widget _actionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) =>
      FilledButton(
        onPressed: onTap,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(color),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: AppColor.white, size: 15, weight: 15),
            const Gap(3),
            Text(
              label,
              style: AppTextStyle.semiBoldStyle(
                color: AppColor.white,
                size: 14,
              ),
            ),
            const Gap(3),
          ],
        ),
      );

  Widget _emptyWidget(String msg) => Expanded(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            // this centers the content vertically
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(FluentIcons.search_issue,
                  size: 80, color: AppColor.black),
              const Gap(20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  msg,
                  textAlign: TextAlign.center,
                  style:
                      AppTextStyle.boldStyle(size: 20, color: AppColor.black),
                ),
              ),
            ],
          ),
        ),
      );

  Widget _errorWidget() => Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Gap(30),
            const Icon(FluentIcons.search_issue,
                size: 80, color: AppColor.black),
            const Gap(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Something went wrong, please try again.",
                textAlign: TextAlign.center,
                style: AppTextStyle.boldStyle(size: 20, color: AppColor.black),
              ),
            ),
          ],
        ),
      );
}
