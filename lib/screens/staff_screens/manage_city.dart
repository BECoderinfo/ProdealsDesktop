import '../../utils/imports.dart';

class ManageCityScreen extends GetView<ManageCityController> {
  const ManageCityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double hit = MediaQuery.of(context).size.height;
    double wid = MediaQuery.of(context).size.width;
    return GetBuilder<ManageCityController>(
      init: ManageCityController(ctx: context),
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
                'Manage City',
                style: AppTextStyle.semiBoldStyle(
                  size: 32,
                  color: AppColor.black300,
                ),
              ),
              const Gap(20),
              Obx(
                () => SizedBox(
                  width: wid / 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      controller.isCityError.value ||
                              controller.cityList.isEmpty
                          ? const Gap(0)
                          : Text(
                              'Show ${controller.cityList.length} Entries',
                              style: AppTextStyle.semiBoldStyle(
                                size: 24,
                                color: AppColor.smokyBlack,
                              ),
                            ),
                      FilledButton(
                        onPressed: () {
                          controller.showCityAddUpdateDialog(
                            title: "Add city",
                            ctx: context,
                          );
                        },
                        style: const ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                            AppColor.btnGreenColor,
                          ),
                        ),
                        child: const Text(
                          '+ Add City',
                          style: TextStyle(
                            color: AppColor.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Gap(20),
              Obx(
                () =>
                    controller.isCityError.value || controller.cityList.isEmpty
                        ? const Gap(0)
                        : Container(
                            width: wid / 2,
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
                                  color: AppColor.black.withOpacity(0.5),
                                )
                              ],
                            ),
                            alignment: Alignment.center,
                            child: Table(
                              columnWidths: const {
                                0: FixedColumnWidth(100),
                                1: FlexColumnWidth(),
                                2: FlexColumnWidth(),
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
                                      'Name',
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
                () => controller.isCityError.value
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
                    : controller.isCityLoaded.value
                        ? controller.cityList.isEmpty
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "City not found.",
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
                                child: SizedBox(
                                  width: wid / 2,
                                  child: ListView.separated(
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20.0),
                                        child: Table(
                                          columnWidths: const {
                                            0: FixedColumnWidth(100),
                                            1: FlexColumnWidth(),
                                            2: FlexColumnWidth(),
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
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    right: 10.0,
                                                  ),
                                                  child: Text(
                                                    controller.cityList[index]
                                                            .cityname ??
                                                        "",
                                                    style: AppTextStyle
                                                        .semiBoldStyle(
                                                      color: AppColor
                                                          .tableRowTextColor,
                                                      size: 16,
                                                    ),
                                                  ),
                                                ),
                                                Obx(
                                                  () => controller.isProcess
                                                              .value &&
                                                          controller
                                                                  .cityList[
                                                                      index]
                                                                  .sId ==
                                                              controller
                                                                  .id.value
                                                      ? CustomCircularIndicator
                                                          .indicator(
                                                          color1: Colors.white
                                                              .withOpacity(
                                                                  0.25),
                                                          color:
                                                              AppColor.primary,
                                                        )
                                                      : Wrap(
                                                          runSpacing: 10,
                                                          spacing: 5,
                                                          children: [
                                                            IconButton(
                                                              icon: const Icon(
                                                                FluentIcons
                                                                    .edit,
                                                                color: AppColor
                                                                    .white,
                                                              ),
                                                              onPressed: () {
                                                                controller
                                                                    .nameController
                                                                    .text = controller
                                                                        .cityList[
                                                                            index]
                                                                        .cityname ??
                                                                    "";
                                                                controller
                                                                    .showCityAddUpdateDialog(
                                                                  title:
                                                                      "Update city",
                                                                  ctx: context,
                                                                  isEdit: controller
                                                                          .cityList[
                                                                              index]
                                                                          .sId ??
                                                                      "",
                                                                );
                                                              },
                                                              style:
                                                                  ButtonStyle(
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
                                                                    .red_eye,
                                                                color: AppColor
                                                                    .white,
                                                              ),
                                                              onPressed: () {
                                                                controller
                                                                    .showDetailDialog(
                                                                  ctx: context,
                                                                  title:
                                                                      "View city details",
                                                                  content:
                                                                      Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .min,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      controller
                                                                          .rowWidget(
                                                                        title:
                                                                            "City name",
                                                                        value: controller.cityList[index].cityname ??
                                                                            "",
                                                                      ),
                                                                    ],
                                                                  ),
                                                                );
                                                              },
                                                              style:
                                                                  ButtonStyle(
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
                                                                    .delete,
                                                                color: AppColor
                                                                    .white,
                                                              ),
                                                              onPressed: () {
                                                                controller
                                                                    .showDeleteDialog(
                                                                  id: controller
                                                                          .cityList[
                                                                              index]
                                                                          .sId ??
                                                                      "",
                                                                  content:
                                                                      'Are you sure you want to delete this city?',
                                                                  title:
                                                                      'Delete City?',
                                                                  url: Apis.deleteCity(
                                                                      cId: controller
                                                                              .cityList[index]
                                                                              .sId ??
                                                                          ""),
                                                                  onCall: () {
                                                                    controller
                                                                        .cityList
                                                                        .removeAt(
                                                                            index);
                                                                  },
                                                                  message:
                                                                      "City deleted successfully",
                                                                  ctx: context,
                                                                );
                                                              },
                                                              style:
                                                                  ButtonStyle(
                                                                backgroundColor:
                                                                    WidgetStateProperty
                                                                        .all(Colors
                                                                            .red),
                                                              ),
                                                            )
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
                                    itemCount: controller.cityList.length,
                                  ),
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
