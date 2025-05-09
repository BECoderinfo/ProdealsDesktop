import '../../utils/imports.dart';

class ManageBusiness extends GetView<ManageBusinessController> {
  const ManageBusiness({super.key});

  @override
  Widget build(BuildContext context) {
    double hit = MediaQuery.of(context).size.height;
    double wid = MediaQuery.of(context).size.width;
    return GetBuilder<ManageBusinessController>(
      init: ManageBusinessController(ctx: context),
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
                'Manage Businesses',
                style: AppTextStyle.semiBoldStyle(
                  size: 32,
                  color: AppColor.black300,
                ),
              ),
              const Gap(20),
              Obx(
                () => controller.isError.value || controller.allBusiness.isEmpty
                    ? const Gap(0)
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Show ${controller.allBusiness.length} Entries',
                            style: AppTextStyle.semiBoldStyle(
                              size: 24,
                              color: AppColor.smokyBlack,
                            ),
                          ),
                          FilledButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                '/add_business',
                              ).then(
                                (value) {
                                  if (value != null && value is bool && value) {
                                    controller.getAllBusiness();
                                  }
                                },
                              );
                            },
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(
                                AppColor.green,
                              ),
                            ),
                            child: const Text(
                              '+ Add New Business',
                              style: TextStyle(
                                color: AppColor.white,
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
              const Gap(20),
              Obx(
                () => controller.isError.value || controller.allBusiness.isEmpty
                    ? const Gap(0)
                    : Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
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
                          defaultVerticalAlignment:
                              TableCellVerticalAlignment.middle,
                          columnWidths: const {
                            0: FixedColumnWidth(50),
                            1: FixedColumnWidth(180),
                            2: FixedColumnWidth(100),
                            3: FixedColumnWidth(180),
                            4: FlexColumnWidth(),
                            5: FixedColumnWidth(140),
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
                                  'Main Image',
                                  style: AppTextStyle.semiBoldStyle(
                                    color: AppColor.black,
                                    size: 20,
                                  ),
                                ),
                                Text(
                                  'Name',
                                  style: AppTextStyle.semiBoldStyle(
                                    color: AppColor.black,
                                    size: 20,
                                  ),
                                ),
                                Text(
                                  'Phone',
                                  style: AppTextStyle.semiBoldStyle(
                                    color: AppColor.black,
                                    size: 20,
                                  ),
                                ),
                                Text(
                                  'Address',
                                  style: AppTextStyle.semiBoldStyle(
                                    color: AppColor.black,
                                    size: 20,
                                  ),
                                ),
                                Text(
                                  'Category',
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
                            mainAxisAlignment: MainAxisAlignment.center,
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
                        ? controller.allBusiness.isEmpty
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Business not found.",
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
                            : Expanded(
                                child: ListView.separated(
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      child: Table(
                                        columnWidths: const {
                                          0: FixedColumnWidth(50),
                                          1: FixedColumnWidth(180),
                                          2: FixedColumnWidth(100),
                                          3: FixedColumnWidth(180),
                                          4: FlexColumnWidth(),
                                          5: FixedColumnWidth(140),
                                          6: FlexColumnWidth(),
                                        },
                                        defaultVerticalAlignment:
                                            TableCellVerticalAlignment.middle,
                                        children: [
                                          TableRow(
                                            children: [
                                              Text(
                                                '${index + 1}',
                                                style:
                                                    AppTextStyle.semiBoldStyle(
                                                  color: AppColor
                                                      .tableRowTextColor,
                                                  size: 16,
                                                ),
                                              ),
                                              Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      child: (controller
                                                                      .allBusiness[
                                                                          index]
                                                                      .mainImage
                                                                      ?.data
                                                                      ?.data ??
                                                                  [])
                                                              .isImage()
                                                          ? Image.asset(
                                                              'assets/images/default_image.png',
                                                              height: 130,
                                                              width: 130,
                                                              fit: BoxFit.cover,
                                                            )
                                                          : Image.memory(
                                                              Uint8List.fromList(
                                                                  controller
                                                                      .allBusiness[
                                                                          index]
                                                                      .mainImage!
                                                                      .data!
                                                                      .data!),
                                                              height: 130,
                                                              width: 130,
                                                              fit: BoxFit.cover,
                                                            )),
                                                ],
                                              ),
                                              Text(
                                                controller.allBusiness[index]
                                                        .businessName ??
                                                    "",
                                                style:
                                                    AppTextStyle.semiBoldStyle(
                                                  color: AppColor
                                                      .tableRowTextColor,
                                                  size: 16,
                                                ),
                                              ),
                                              Text(
                                                controller.allBusiness[index]
                                                        .contactNumber ??
                                                    "",
                                                style:
                                                    AppTextStyle.semiBoldStyle(
                                                  color: AppColor
                                                      .tableRowTextColor,
                                                  size: 16,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  controller.address(i: index),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: AppTextStyle
                                                      .semiBoldStyle(
                                                    color: AppColor
                                                        .tableRowTextColor,
                                                    size: 16,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                controller.allBusiness[index]
                                                        .category ??
                                                    "",
                                                style:
                                                    AppTextStyle.semiBoldStyle(
                                                  color: AppColor
                                                      .tableRowTextColor,
                                                  size: 16,
                                                ),
                                              ),
                                              Obx(() => controller
                                                          .isProcess.value &&
                                                      controller
                                                              .allBusiness[
                                                                  index]
                                                              .sId ==
                                                          controller.bId.value
                                                  ? CustomCircularIndicator
                                                      .indicator(
                                                      color1: Colors.grey
                                                          .withOpacity(0.5),
                                                      color: AppColor.black,
                                                    )
                                                  : Row(
                                                      children: [
                                                        IconButton(
                                                          icon: const Icon(
                                                              FluentIcons.edit),
                                                          onPressed: () {
                                                            Navigator.pushNamed(
                                                              context,
                                                              '/update_business',
                                                              arguments: controller
                                                                      .allBusiness[
                                                                  index],
                                                            ).then(
                                                              (value) {
                                                                if (value !=
                                                                        null &&
                                                                    value
                                                                        is bool &&
                                                                    value) {
                                                                  controller
                                                                      .getAllBusiness();
                                                                }
                                                              },
                                                            );
                                                          },
                                                          style: ButtonStyle(
                                                            backgroundColor:
                                                                WidgetStateProperty
                                                                    .all(Colors
                                                                        .green),
                                                          ),
                                                        ),
                                                        const Gap(10),
                                                        IconButton(
                                                          icon: const Icon(
                                                              FluentIcons
                                                                  .red_eye),
                                                          onPressed: () {
                                                            Navigator.pushNamed(
                                                              context,
                                                              '/view_business',
                                                              arguments: controller
                                                                      .allBusiness[
                                                                  index],
                                                            );
                                                          },
                                                          style: ButtonStyle(
                                                            backgroundColor:
                                                                WidgetStateProperty
                                                                    .all(Colors
                                                                        .blue),
                                                          ),
                                                        ),
                                                        const Gap(10),
                                                        IconButton(
                                                          icon: const Icon(
                                                              FluentIcons
                                                                  .delete),
                                                          onPressed: () {
                                                            controller
                                                                .showDeleteDialog(
                                                                    ctx:
                                                                        context,
                                                                    i: index);
                                                          },
                                                          style: ButtonStyle(
                                                            backgroundColor:
                                                                WidgetStateProperty
                                                                    .all(Colors
                                                                        .red),
                                                          ),
                                                        ),
                                                      ],
                                                    )),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      const Gap(20),
                                  itemCount: controller.allBusiness.length,
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
        );
      },
    );
  }
}
