import '../../utils/imports.dart';

class ManageCategoryScreen extends GetView<ManageCategoryController> {
  const ManageCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double hit = MediaQuery.of(context).size.height;
    double wid = MediaQuery.of(context).size.width;
    return GetBuilder<ManageCategoryController>(
      init: ManageCategoryController(ctx: context),
      builder: (controller) => Container(
        height: hit,
        width: wid,
        color: AppColor.white,
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Manage Category',
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
                    controller.isCategoryError.value ||
                            controller.categoryList.isEmpty
                        ? const Gap(0)
                        : Text(
                            'Show ${controller.categoryList.length} Entries',
                            style: AppTextStyle.semiBoldStyle(
                              size: 24,
                              color: AppColor.smokyBlack,
                            ),
                          ),
                    FilledButton(
                      onPressed: () {
                        controller.showCategoryAddUpdateDialog(
                          title: "Add category",
                          ctx: context,
                        );
                      },
                      style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                          AppColor.btnGreenColor,
                        ),
                      ),
                      child: const Text(
                        '+ Add Category',
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
              () => controller.isCategoryError.value ||
                      controller.categoryList.isEmpty
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
                          1: FlexColumnWidth(),
                          2: FixedColumnWidth(200),
                          3: FixedColumnWidth(200),
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
                                'Category name',
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
                                'Icon',
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
              () => controller.isCategoryError.value
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
                  : controller.isCategoryLoaded.value
                      ? controller.categoryList.isEmpty
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Category not found.",
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
                                          1: FlexColumnWidth(),
                                          2: FixedColumnWidth(200),
                                          3: FixedColumnWidth(200),
                                          4: FlexColumnWidth(),
                                        },
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
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  right: 10.0,
                                                ),
                                                child: Text(
                                                  controller.categoryList[index]
                                                          .category ??
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
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    child: (controller
                                                                    .categoryList[
                                                                        index]
                                                                    .image
                                                                    ?.data ??
                                                                [])
                                                            .isImage()
                                                        ? Image.asset(
                                                            'assets/images/default_image.png',
                                                            width: 125,
                                                            height: 125,
                                                            fit: BoxFit.cover,
                                                          )
                                                        : GestureDetector(
                                                            onTap: () {
                                                              controller
                                                                  .zoomImage(
                                                                data: controller
                                                                    .categoryList[
                                                                        index]
                                                                    .image!
                                                                    .data!,
                                                                ctx: context,
                                                                wid: wid,
                                                              );
                                                            },
                                                            child: Image.memory(
                                                              Uint8List.fromList(
                                                                  controller
                                                                      .categoryList[
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
                                              Row(
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    child: (controller
                                                                    .categoryList[
                                                                        index]
                                                                    .icon
                                                                    ?.data ??
                                                                [])
                                                            .isImage()
                                                        ? Image.asset(
                                                            'assets/images/default_image.png',
                                                            width: 125,
                                                            height: 125,
                                                            fit: BoxFit.cover,
                                                          )
                                                        : GestureDetector(
                                                            onTap: () {
                                                              controller
                                                                  .zoomImage(
                                                                data: controller
                                                                    .categoryList[
                                                                        index]
                                                                    .icon!
                                                                    .data!,
                                                                ctx: context,
                                                                wid: wid,
                                                              );
                                                            },
                                                            child: Image.memory(
                                                              Uint8List.fromList(
                                                                  controller
                                                                      .categoryList[
                                                                          index]
                                                                      .icon!
                                                                      .data!),
                                                              width: 125,
                                                              height: 125,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                  ),
                                                ],
                                              ),
                                              Obx(
                                                () => controller
                                                            .isProcess.value &&
                                                        controller
                                                                .categoryList[
                                                                    index]
                                                                .sId ==
                                                            controller.id.value
                                                    ? CustomCircularIndicator
                                                        .indicator(
                                                        color1: Colors.white
                                                            .withOpacity(0.25),
                                                        color: AppColor.primary,
                                                      )
                                                    : Wrap(
                                                        runSpacing: 10,
                                                        spacing: 5,
                                                        children: [
                                                          IconButton(
                                                            icon: const Icon(
                                                              FluentIcons.edit,
                                                              color: AppColor
                                                                  .white,
                                                            ),
                                                            onPressed: () {
                                                              controller
                                                                  .nameController
                                                                  .text = controller
                                                                      .categoryList[
                                                                          index]
                                                                      .category ??
                                                                  "";
                                                              controller
                                                                  .showCategoryAddUpdateDialog(
                                                                title:
                                                                    "Update category",
                                                                ctx: context,
                                                                isEdit: controller
                                                                        .categoryList[
                                                                            index]
                                                                        .sId ??
                                                                    "",
                                                                imageData: [
                                                                  (controller
                                                                          .categoryList[
                                                                              index]
                                                                          .image
                                                                          ?.data ??
                                                                      []),
                                                                  (controller
                                                                          .categoryList[
                                                                              index]
                                                                          .icon
                                                                          ?.data ??
                                                                      [])
                                                                ],
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
                                                                  .delete,
                                                              color: AppColor
                                                                  .white,
                                                            ),
                                                            onPressed: () {
                                                              controller
                                                                  .showDeleteDialog(
                                                                id: controller
                                                                        .categoryList[
                                                                            index]
                                                                        .sId ??
                                                                    "",
                                                                content:
                                                                    'Are you sure you want to delete this category?',
                                                                title:
                                                                    'Delete Category?',
                                                                url: Apis.deleteCategory(
                                                                    cId: controller
                                                                            .categoryList[index]
                                                                            .sId ??
                                                                        ""),
                                                                onCall: () {
                                                                  controller
                                                                      .categoryList
                                                                      .removeAt(
                                                                          index);
                                                                },
                                                                message:
                                                                    "Category deleted successfully",
                                                                ctx: context,
                                                              );
                                                            },
                                                            style: ButtonStyle(
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
                                  itemCount: controller.categoryList.length,
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
      ),
    );
  }
}
