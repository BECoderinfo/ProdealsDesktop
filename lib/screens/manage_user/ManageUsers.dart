import '../../utils/imports.dart';

class ManageUsers extends GetView<ManageUserController> {
  const ManageUsers({super.key});

  @override
  Widget build(BuildContext context) {
    double hit = MediaQuery.of(context).size.height;
    double wid = MediaQuery.of(context).size.width;

    return GetBuilder<ManageUserController>(
      init: ManageUserController(ctx: context),
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
                'Manage Users',
                style: AppTextStyle.semiBoldStyle(
                  size: 32,
                  color: AppColor.black300,
                ),
              ),
              const Gap(20),

              // Show entries count always
              Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Show ${controller.allUser.length} Entries',
                        style: AppTextStyle.semiBoldStyle(
                          size: 24,
                          color: AppColor.smokyBlack,
                        ),
                      ),
                    ],
                  )),
              const Gap(20),

              // Table Header (Always Show)
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
                alignment: Alignment.center,
                child: Table(
                  columnWidths: const {
                    0: FixedColumnWidth(50), // No.
                    1: FlexColumnWidth(2), // User Name
                    2: FlexColumnWidth(2), // Phone
                    3: FlexColumnWidth(3), // Email (slightly more space)
                    4: FlexColumnWidth(3), // Business
                    5: FlexColumnWidth(2), // Premium
                    6: FixedColumnWidth(80), // Action
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
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Text(
                            'User Name',
                            style: AppTextStyle.semiBoldStyle(
                              color: AppColor.black,
                              size: 20,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Text(
                            'Phone',
                            style: AppTextStyle.semiBoldStyle(
                              color: AppColor.black,
                              size: 20,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Text(
                            'Email',
                            style: AppTextStyle.semiBoldStyle(
                              color: AppColor.black,
                              size: 20,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Text(
                            'Business',
                            style: AppTextStyle.semiBoldStyle(
                              color: AppColor.black,
                              size: 20,
                            ),
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
              const Gap(20),

              // Content
              Obx(() {
                if (controller.isError.value) {
                  return Column(
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
                  );
                } else if (controller.isLoaded.value) {
                  if (controller.allUser.isEmpty) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                "Users not found.",
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
                    );
                  } else {
                    return Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          final user = controller.allUser[index];
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Table(
                              columnWidths: const {
                                0: FixedColumnWidth(50),
                                // No.
                                1: FlexColumnWidth(2),
                                // User Name
                                2: FlexColumnWidth(2),
                                // Phone
                                3: FlexColumnWidth(3),
                                // Email (slightly more space)
                                4: FlexColumnWidth(3),
                                // Business
                                5: FlexColumnWidth(2),
                                // Premium
                                6: FixedColumnWidth(80),
                                // Action
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
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: Text(
                                        user.userName ?? "",
                                        style: AppTextStyle.semiBoldStyle(
                                          color: AppColor.tableRowTextColor,
                                          size: 16,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: Text(
                                        user.phone ?? "",
                                        style: AppTextStyle.semiBoldStyle(
                                          color: AppColor.tableRowTextColor,
                                          size: 16,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: Text(
                                        user.email ?? "",
                                        style: AppTextStyle.semiBoldStyle(
                                          color: AppColor.tableRowTextColor,
                                          size: 16,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Text(
                                      user.isBusiness == true
                                          ? 'Partner Program Member'
                                          : 'User',
                                      style: AppTextStyle.semiBoldStyle(
                                        color: AppColor.tableRowTextColor,
                                        size: 16,
                                      ),
                                    ),
                                    Text(
                                      user.status ?? "unVerified",
                                      style: AppTextStyle.semiBoldStyle(
                                        color: AppColor.tableRowTextColor,
                                        size: 16,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Obx(
                                          () => !controller.isProcess.value &&
                                                  user.id ==
                                                      controller.uId.value
                                              ? CustomCircularIndicator
                                                  .indicator(
                                                  color1: Colors.white
                                                      .withOpacity(0.25),
                                                  color: AppColor.primary,
                                                )
                                              : IconButton(
                                                  icon: const Icon(
                                                      FluentIcons.delete),
                                                  onPressed: () {
                                                    controller.showDeleteDialog(
                                                      ctx: context,
                                                      i: index,
                                                    );
                                                  },
                                                  style: ButtonStyle(
                                                    backgroundColor:
                                                        WidgetStateProperty.all(
                                                            Colors.red),
                                                  ),
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
                        separatorBuilder: (context, index) => const Gap(20),
                        itemCount: controller.allUser.length,
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
        );
      },
    );
  }
}
