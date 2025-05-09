import '../../utils/imports.dart';

class ManageNotification extends GetView<ManageNotificationController> {
  const ManageNotification({super.key});

  @override
  Widget build(BuildContext context) {
    double hit = MediaQuery.of(context).size.height;
    double wid = MediaQuery.of(context).size.width;
    return GetBuilder<ManageNotificationController>(
      init: ManageNotificationController(ctx: context),
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
                'Manage Notification',
                style: AppTextStyle.semiBoldStyle(
                  size: 32,
                  color: AppColor.black300,
                ),
              ),
              const Gap(20),
              Obx(
                () => controller.isError.value ||
                        controller.notificationList.isEmpty
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          FilledButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                '/add_notification',
                              ).then(
                                (value) {
                                  if (value != null && value is bool && value) {
                                    controller.getAllNotification();
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
                              '+ Add New Notification',
                              style: TextStyle(
                                color: AppColor.white,
                              ),
                            ),
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Show ${controller.notificationList.where((item) => item.notification != null).length} Notifications',
                            style: AppTextStyle.semiBoldStyle(
                              size: 24,
                              color: AppColor.smokyBlack,
                            ),
                          ),
                          FilledButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                '/add_notification',
                              ).then(
                                (value) {
                                  if (value != null && value is bool && value) {
                                    controller.getAllNotification();
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
                              '+ Add New Notification',
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
                        ? controller.notificationList.isEmpty
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Notifications not found.",
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
                                child: ListView.builder(
                                  itemBuilder: (context, index) {
                                    if (controller
                                        .notificationList[index].isHeader) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            controller.notificationList[index]
                                                    .header ??
                                                "",
                                            style: AppTextStyle.semiBoldStyle(
                                              size: 18,
                                              color: AppColor.smokyBlack,
                                            ),
                                          ),
                                          const Gap(10),
                                        ],
                                      );
                                    } else {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: wid,
                                            height: 90,
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 8),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              color: AppColor.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  offset: const Offset(0, 4),
                                                  blurRadius: 8,
                                                  color: AppColor.black
                                                      .withOpacity(0.1),
                                                ),
                                              ],
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15, vertical: 10),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        controller
                                                                .notificationList[
                                                                    index]
                                                                .notification
                                                                ?.title ??
                                                            "",
                                                        style: AppTextStyle
                                                            .semiBoldStyle(
                                                          color: AppColor.black,
                                                          size: 16,
                                                        ),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                      const SizedBox(height: 5),
                                                      Text(
                                                        controller
                                                                .notificationList[
                                                                    index]
                                                                .notification
                                                                ?.description ??
                                                            "",
                                                        maxLines: 1,
                                                        style: AppTextStyle
                                                            .regularStyle(
                                                          color: AppColor.black
                                                              .withOpacity(0.7),
                                                          size: 14,
                                                        ),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(width: 15),
                                                Row(
                                                  children: [
                                                    IconButton(
                                                      icon: Icon(
                                                          FluentIcons.delete,
                                                          color: Colors.red),
                                                      onPressed: () {
                                                        controller
                                                            .showDeleteDialog(
                                                                ctx: context,
                                                                i: index);
                                                      },
                                                      style: ButtonStyle(
                                                        backgroundColor:
                                                            ButtonState.all(
                                                                Colors.red
                                                                    .withOpacity(
                                                                        0.15)),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          const Gap(20),
                                        ],
                                      );
                                    }
                                  },
                                  itemCount: controller.notificationList.length,
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
