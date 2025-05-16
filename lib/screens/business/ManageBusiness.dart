import '../../utils/imports.dart';

class ManageBusiness extends GetView<ManageBusinessController> {
  const ManageBusiness({super.key});

  @override
  Widget build(BuildContext context) {
    final double hit = MediaQuery.of(context).size.height;
    final double wid = MediaQuery.of(context).size.width;

    return GetBuilder<ManageBusinessController>(
      init: ManageBusinessController(ctx: context),
      builder: (controller) {
        return Container(
          height: hit,
          width: wid,
          color: AppColor.white,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Manage Businesses',
                style: AppTextStyle.semiBoldStyle(
                  size: 32,
                  color: AppColor.black300,
                ),
              ),
              const Gap(20),

              // Add New Button and Entry Info
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (!controller.isError.value &&
                        controller.allBusiness.isNotEmpty)
                      Text(
                        'Show ${controller.allBusiness.length} Entries',
                        style: AppTextStyle.semiBoldStyle(
                          size: 24,
                          color: AppColor.smokyBlack,
                        ),
                      ),
                    FilledButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/add_business').then(
                          (value) {
                            if (value is bool && value) {
                              controller.getAllBusiness();
                            }
                          },
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all(AppColor.green),
                      ),
                      child: const Text(
                        '+ Add New Business',
                        style: TextStyle(color: AppColor.white),
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(20),

              // Table Header
              _buildTableHeader(),

              const Gap(10),

              // Body
              Expanded(
                child: Obx(() {
                  if (controller.isError.value) {
                    return _buildErrorView();
                  }

                  if (controller.isLoaded.value) {
                    if (controller.allBusiness.isEmpty) {
                      return _buildEmptyView();
                    }

                    return _buildBusinessTable(controller, context);
                  }

                  return CustomCircularIndicator.indicator(
                    color1: Colors.grey.withOpacity(0.5),
                    color: AppColor.black,
                  );
                }),
              ),
              const Gap(20),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTableHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          columnWidths: const {
            0: FixedColumnWidth(50),
            1: FixedColumnWidth(180),
            2: FixedColumnWidth(100),
            3: FixedColumnWidth(180),
            4: FixedColumnWidth(200),
            5: FixedColumnWidth(140),
            6: FixedColumnWidth(200),
          },
          children: [
            TableRow(
              children: [
                _headerText('No.'),
                _headerText('Main Image'),
                _headerText('Name'),
                _headerText('Phone'),
                _headerText('Address'),
                _headerText('Category'),
                _headerText('Action'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _headerText(String text) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(
          text,
          style: AppTextStyle.semiBoldStyle(
            color: AppColor.black,
            size: 20,
          ),
        ),
      );

  Widget _buildErrorView() {
    return Center(
      child: Column(
        children: [
          const Icon(FluentIcons.search_issue, size: 80, color: AppColor.black),
          const Gap(20),
          Text(
            "Something went wrong. Please try again.",
            textAlign: TextAlign.center,
            style: AppTextStyle.boldStyle(size: 20, color: AppColor.black),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyView() {
    return Center(
      child: Text(
        "Business not found.",
        textAlign: TextAlign.center,
        style: AppTextStyle.boldStyle(size: 20, color: AppColor.black),
      ),
    );
  }

  Widget _buildBusinessTable(
      ManageBusinessController controller, BuildContext context) {
    return ListView.separated(
      itemCount: controller.allBusiness.length,
      separatorBuilder: (_, __) => const Gap(20),
      itemBuilder: (context, index) {
        final business = controller.allBusiness[index];

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Table(
              columnWidths: const {
                0: FixedColumnWidth(50),
                1: FixedColumnWidth(180),
                2: FixedColumnWidth(100),
                3: FixedColumnWidth(180),
                4: FixedColumnWidth(200),
                5: FixedColumnWidth(140),
                6: FixedColumnWidth(200),
              },
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                TableRow(
                  children: [
                    _cellText('${index + 1}'),
                    _buildImageCell(business),
                    _cellText(business.businessName ?? ""),
                    _cellText(business.contactNumber ?? ""),
                    _cellText(controller.address(i: index), maxLines: 2),
                    _cellText(business.category ?? ""),
                    _buildActionButtons(controller, index, context),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _cellText(String text, {int maxLines = 1}) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          maxLines: maxLines,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyle.semiBoldStyle(
            color: AppColor.tableRowTextColor,
            size: 16,
          ),
        ),
      );

  Widget _buildImageCell(dynamic business) {
    final bytes = business.mainImage?.data?.data;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: bytes != null && bytes.isNotEmpty
            ? Image.memory(Uint8List.fromList(List<int>.from(bytes)),
                height: 130, width: 130, fit: BoxFit.cover)
            : Image.asset('assets/images/default_image.png',
                height: 130, width: 130, fit: BoxFit.cover),
      ),
    );
  }

  Widget _buildActionButtons(
      ManageBusinessController controller, int index, BuildContext context) {
    final business = controller.allBusiness[index];

    return Obx(
      () => controller.isProcess.value && controller.bId.value == business.sId
          ? CustomCircularIndicator.indicator(
              color1: Colors.grey.withOpacity(0.5),
              color: AppColor.black,
            )
          : Row(
              children: [
                IconButton(
                  icon: const Icon(FluentIcons.edit, color: Colors.white),
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.green),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/update_business',
                      arguments: business,
                    ).then((value) {
                      if (value is bool && value) {
                        controller.getAllBusiness();
                      }
                    });
                  },
                ),
                const Gap(10),
                IconButton(
                  icon: const Icon(FluentIcons.red_eye, color: Colors.white),
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.blue),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/view_business',
                        arguments: business);
                  },
                ),
                const Gap(10),
                IconButton(
                  icon: const Icon(FluentIcons.delete, color: Colors.white),
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.red),
                  ),
                  onPressed: () =>
                      controller.showDeleteDialog(ctx: context, i: index),
                ),
              ],
            ),
    );
  }
}
