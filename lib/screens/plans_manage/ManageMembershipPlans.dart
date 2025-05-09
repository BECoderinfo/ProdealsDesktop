import 'dart:math';

import '../../utils/imports.dart';

class ManageMembershipPlansScreen
    extends GetView<ManageMembershipPlansController> {
  const ManageMembershipPlansScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double hit = MediaQuery.of(context).size.height;
    double wid = MediaQuery.of(context).size.width;

    return GetBuilder<ManageMembershipPlansController>(
      init: ManageMembershipPlansController(ctx: context),
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
                'Manage Membership Plans',
                style: AppTextStyle.semiBoldStyle(
                  size: 32,
                  color: AppColor.black300,
                ),
              ),
              const Gap(20),
              Obx(
                () => controller.isError.value
                    ? const Gap(0)
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Show ${controller.allPlans.length} Entries',
                            style: AppTextStyle.semiBoldStyle(
                              size: 24,
                              color: AppColor.smokyBlack,
                            ),
                          ),
                          FilledButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                '/add_update_plan',
                                arguments: {'isEdit': false},
                              ).then((value) {
                                if (value != null && value is bool && value) {
                                  controller.getAllPlans();
                                }
                              });
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  WidgetStateProperty.all(AppColor.green),
                            ),
                            child: const Text(
                              '+ Add New Plan',
                              style: TextStyle(color: AppColor.white),
                            ),
                          ),
                        ],
                      ),
              ),
              const Gap(20),

              // Always show the table header
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
                    0: FixedColumnWidth(50),
                  },
                  children: [
                    TableRow(
                      children: [
                        Text('No.',
                            style: AppTextStyle.semiBoldStyle(
                                color: AppColor.black, size: 20)),
                        Text('Plan name',
                            style: AppTextStyle.semiBoldStyle(
                                color: AppColor.black, size: 20)),
                        Text('Plan duration',
                            style: AppTextStyle.semiBoldStyle(
                                color: AppColor.black, size: 20)),
                        Text('Plan price',
                            style: AppTextStyle.semiBoldStyle(
                                color: AppColor.black, size: 20)),
                        Text('Description',
                            style: AppTextStyle.semiBoldStyle(
                                color: AppColor.black, size: 20)),
                        Text('Status',
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
              Obx(
                () => controller.isError.value
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Gap(30),
                          const Icon(FluentIcons.search_issue,
                              size: 80, color: AppColor.black),
                          const Gap(20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                  "Something went wrong please try again.",
                                  textAlign: TextAlign.center,
                                  style: AppTextStyle.boldStyle(
                                      size: 20, color: AppColor.black),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    : controller.isLoaded.value
                        ? controller.allPlans.isEmpty
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Membership plans not found.",
                                          textAlign: TextAlign.center,
                                          style: AppTextStyle.boldStyle(
                                              size: 20, color: AppColor.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            : Expanded(
                                child: ListView.separated(
                                  itemBuilder: (context, index) {
                                    final plan = controller.allPlans[index];
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      child: Table(
                                        columnWidths: const {
                                          0: FixedColumnWidth(50)
                                        },
                                        children: [
                                          TableRow(
                                            children: [
                                              Text('${index + 1}',
                                                  style: AppTextStyle
                                                      .semiBoldStyle(
                                                          color: AppColor
                                                              .tableRowTextColor,
                                                          size: 16)),
                                              Text(plan.planName ?? "",
                                                  style: AppTextStyle
                                                      .semiBoldStyle(
                                                          color: AppColor
                                                              .tableRowTextColor,
                                                          size: 16)),
                                              Text(plan.planDuration ?? "",
                                                  style: AppTextStyle
                                                      .semiBoldStyle(
                                                          color: AppColor
                                                              .tableRowTextColor,
                                                          size: 16)),
                                              Text("${plan.planPrice ?? ""}",
                                                  style: AppTextStyle
                                                      .semiBoldStyle(
                                                          color: AppColor
                                                              .tableRowTextColor,
                                                          size: 16)),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        for (int i = 0;
                                                            i <
                                                                min(
                                                                    plan.planDescription
                                                                            .length ??
                                                                        0,
                                                                    2);
                                                            i++)
                                                          Text(
                                                            "• ${plan.planDescription[i] ?? ""}",
                                                            maxLines: 1,
                                                            style: AppTextStyle
                                                                .semiBoldStyle(
                                                                    color: AppColor
                                                                        .tableRowTextColor,
                                                                    size: 16),
                                                          ),
                                                      ],
                                                    ),
                                                  ),
                                                  const Gap(15),
                                                ],
                                              ),
                                              // Status
                                              Text(
                                                controller.allPlans[index]
                                                        .planStatus ??
                                                    "",
                                                style:
                                                    AppTextStyle.semiBoldStyle(
                                                  color: controller
                                                              .allPlans[index]
                                                              .planStatus
                                                              ?.toLowerCase() ==
                                                          'active'
                                                      ? Colors.green
                                                      : Colors.red,
                                                  size: 16,
                                                ),
                                              ),

// Action (updated)
                                              Obx(
                                                () => controller
                                                            .isProcess.value &&
                                                        controller.pId.value ==
                                                            controller
                                                                .allPlans[index]
                                                                .id
                                                    ? CustomCircularIndicator
                                                        .indicator(
                                                        color1: Colors.white
                                                            .withOpacity(0.25),
                                                        color: AppColor.primary,
                                                      )
                                                    : Row(
                                                        children: [
                                                          IconButton(
                                                            icon: const Icon(
                                                                FluentIcons
                                                                    .red_eye),
                                                            onPressed: () {
                                                              Navigator
                                                                  .pushNamed(
                                                                context,
                                                                '/view_plan',
                                                                arguments:
                                                                    controller
                                                                            .allPlans[
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
                                                          FilledButton(
                                                            onPressed: () {
                                                              controller
                                                                  .togglePlanStatus(
                                                                ctx: context,
                                                                planId: controller
                                                                    .allPlans[
                                                                        index]
                                                                    .id,
                                                                currentStatus:
                                                                    controller
                                                                        .allPlans[
                                                                            index]
                                                                        .planStatus,
                                                              );
                                                            },
                                                            style: ButtonStyle(
                                                              backgroundColor:
                                                                  WidgetStateProperty
                                                                      .all(
                                                                controller
                                                                            .allPlans[
                                                                                index]
                                                                            .planStatus
                                                                            .toLowerCase() ==
                                                                        'active'
                                                                    ? Colors.red
                                                                    : Colors
                                                                        .green,
                                                              ),
                                                            ),
                                                            child: Text(
                                                              controller.allPlans[index]
                                                                          .planStatus
                                                                          .toLowerCase() ==
                                                                      'active'
                                                                  ? 'Deactivate'
                                                                  : 'Activate',
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white),
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
                                  separatorBuilder: (context, index) =>
                                      const Gap(20),
                                  itemCount: controller.allPlans.length,
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
