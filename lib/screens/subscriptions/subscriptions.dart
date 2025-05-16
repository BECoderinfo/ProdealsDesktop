import 'dart:math';

import '../../controllers/subscriptions/subscriptions_controller.dart';
import '../../utils/imports.dart';

class Subscriptions extends GetView<SubscriptionsController> {
  const Subscriptions({super.key});

  @override
  Widget build(BuildContext context) {
    double hit = MediaQuery.of(context).size.height;
    double wid = MediaQuery.of(context).size.width;

    return GetBuilder<SubscriptionsController>(
      init: SubscriptionsController(ctx: context),
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
                'Manage Subscriptions',
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
                            'Show ${controller.allSubscriptions.length} Entries',
                            style: AppTextStyle.semiBoldStyle(
                              size: 24,
                              color: AppColor.smokyBlack,
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
                        Text('User Name',
                            style: AppTextStyle.semiBoldStyle(
                                color: AppColor.black, size: 20)),
                        Text('Start Date',
                            style: AppTextStyle.semiBoldStyle(
                                color: AppColor.black, size: 20)),
                        Text('End Date',
                            style: AppTextStyle.semiBoldStyle(
                                color: AppColor.black, size: 20)),
                        Text('Status',
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
                        ? controller.allSubscriptions.isEmpty
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
                                    final subscription =
                                        controller.allSubscriptions[index];
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
                                              Text(
                                                  subscription
                                                          .planId?.planName ??
                                                      "",
                                                  style: AppTextStyle
                                                      .semiBoldStyle(
                                                          color: AppColor
                                                              .tableRowTextColor,
                                                          size: 16)),
                                              Text(
                                                  subscription
                                                          .userId?.userName ??
                                                      "",
                                                  style: AppTextStyle
                                                      .semiBoldStyle(
                                                          color: AppColor
                                                              .tableRowTextColor,
                                                          size: 16)),
                                              Text(
                                                  DateFormat("dd MMM, yyyy")
                                                      .format(subscription
                                                              .startDate ??
                                                          DateTime.now()),
                                                  style: AppTextStyle
                                                      .semiBoldStyle(
                                                          color: AppColor
                                                              .tableRowTextColor,
                                                          size: 16)),
                                              Text(
                                                  DateFormat("dd MMM, yyyy")
                                                      .format(subscription
                                                              .endDate ??
                                                          DateTime.now()),
                                                  style: AppTextStyle
                                                      .semiBoldStyle(
                                                          color: AppColor
                                                              .tableRowTextColor,
                                                          size: 16)),

                                              // Status
                                              Text(
                                                subscription.isActive ?? false
                                                    ? "Active"
                                                    : "Inactive",
                                                style:
                                                    AppTextStyle.semiBoldStyle(
                                                  color: AppColor
                                                      .tableRowTextColor,
                                                  size: 16,
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
                                  itemCount: controller.allSubscriptions.length,
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
