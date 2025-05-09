import '../../utils/imports.dart';

class ManageFoodTypeScreen extends GetView<ManageFoodTypeController> {
  const ManageFoodTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double hit = MediaQuery.of(context).size.height;
    double wid = MediaQuery.of(context).size.width;
    return GetBuilder<ManageFoodTypeController>(
      init: ManageFoodTypeController(ctx: context),
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
                'Manage FoodType',
                style: AppTextStyle.semiBoldStyle(
                  size: 32,
                  color: AppColor.black300,
                ),
              ),
              const Gap(20),
              Obx(
                () => SizedBox(
                  width: wid / 1.25,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      controller.isFoodTypeError.value ||
                              controller.foodTypeList.isEmpty
                          ? const Gap(0)
                          : Text(
                              'Show ${controller.foodTypeList.length} Entries',
                              style: AppTextStyle.semiBoldStyle(
                                size: 24,
                                color: AppColor.smokyBlack,
                              ),
                            ),
                      FilledButton(
                        onPressed: () {
                          controller.showFoodTypeAddUpdateDialog(
                            title: "Add food type",
                            ctx: context,
                          );
                        },
                        style: const ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                            AppColor.btnGreenColor,
                          ),
                        ),
                        child: const Text(
                          '+ Add Food Type',
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
                () => controller.isFoodTypeError.value ||
                        controller.foodTypeList.isEmpty
                    ? const Gap(0)
                    : Container(
                        width: wid / 1.25,
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
                            1: FixedColumnWidth(200),
                            2: FlexColumnWidth(),
                            3: FlexColumnWidth(),
                            4: FlexColumnWidth(),
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
                                  'Food type name',
                                  style: AppTextStyle.semiBoldStyle(
                                    color: AppColor.black,
                                    size: 20,
                                  ),
                                ),
                                Text(
                                  'Image',
                                  style: AppTextStyle.semiBoldStyle(
                                    color: AppColor.black,
                                    size: 20,
                                  ),
                                ),
                                Text(
                                  'City',
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
                () => controller.isFoodTypeError.value
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
                    : controller.isFoodTypeLoaded.value
                        ? controller.foodTypeList.isEmpty
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Food type not found.",
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
                                  width: wid / 1.25,
                                  child: ListView.separated(
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20.0),
                                        child: Table(
                                          columnWidths: const {
                                            0: FixedColumnWidth(100),
                                            1: FixedColumnWidth(200),
                                            2: FlexColumnWidth(),
                                            3: FlexColumnWidth(),
                                            4: FlexColumnWidth(),
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
                                                    controller
                                                            .foodTypeList[index]
                                                            .foodType ??
                                                        "",
                                                    style: AppTextStyle
                                                        .semiBoldStyle(
                                                      color: AppColor
                                                          .tableRowTextColor,
                                                      size: 16,
                                                    ),
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        controller.zoomImage(
                                                          data: controller
                                                              .foodTypeList[
                                                                  index]
                                                              .image!
                                                              .data!,
                                                          ctx: context,
                                                          wid: wid,
                                                        );
                                                      },
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        child: Image.memory(
                                                          Uint8List.fromList(
                                                              controller
                                                                  .foodTypeList[
                                                                      index]
                                                                  .image!
                                                                  .data!),
                                                          width: 125,
                                                          height: 125,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    right: 10.0,
                                                  ),
                                                  child: Text(
                                                    controller
                                                            .foodTypeList[index]
                                                            .city ??
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
                                                                  .foodTypeList[
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
                                                                        .foodTypeList[
                                                                            index]
                                                                        .foodType ??
                                                                    "";
                                                                if (controller
                                                                    .cityList
                                                                    .map(
                                                                      (element) =>
                                                                          element
                                                                              .cityname ??
                                                                          "",
                                                                    )
                                                                    .toList()
                                                                    .contains(controller
                                                                            .foodTypeList[index]
                                                                            .city ??
                                                                        "")) {
                                                                  controller
                                                                      .selectedFoodType
                                                                      .value = controller
                                                                          .foodTypeList[
                                                                              index]
                                                                          .city ??
                                                                      "";
                                                                }
                                                                controller
                                                                    .showFoodTypeAddUpdateDialog(
                                                                  title:
                                                                      "Update food type",
                                                                  ctx: context,
                                                                  isEdit: controller
                                                                          .foodTypeList[
                                                                              index]
                                                                          .sId ??
                                                                      "",
                                                                  imageData: controller
                                                                          .foodTypeList[
                                                                              index]
                                                                          .image
                                                                          ?.data ??
                                                                      [],
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
                                                                    .delete,
                                                                color: AppColor
                                                                    .white,
                                                              ),
                                                              onPressed: () {
                                                                controller
                                                                    .showDeleteDialog(
                                                                  id: controller
                                                                          .foodTypeList[
                                                                              index]
                                                                          .sId ??
                                                                      "",
                                                                  content:
                                                                      'Are you sure you want to delete this food-type?',
                                                                  title:
                                                                      'Delete Food Type?',
                                                                  url: Apis.deleteFoodType(
                                                                      cId: controller
                                                                              .foodTypeList[index]
                                                                              .sId ??
                                                                          ""),
                                                                  onCall: () {
                                                                    controller
                                                                        .foodTypeList
                                                                        .removeAt(
                                                                            index);
                                                                  },
                                                                  message:
                                                                      "Food type deleted successfully",
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
                                    itemCount: controller.foodTypeList.length,
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
