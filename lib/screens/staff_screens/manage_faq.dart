import 'package:pro_deals_admin/utils/imports.dart';

class ManageFaqScreen extends GetView<ManageFAQController> {
  const ManageFaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double hit = MediaQuery.of(context).size.height;
    double wid = MediaQuery.of(context).size.width;
    return GetBuilder<ManageFAQController>(
      init: ManageFAQController(ctx: context),
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
                'Manage FAQ',
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
                    controller.isError.value || controller.questionList.isEmpty
                        ? const Gap(0)
                        : Text(
                            'Show ${controller.questionList.length} Entries',
                            style: AppTextStyle.semiBoldStyle(
                              size: 24,
                              color: AppColor.smokyBlack,
                            ),
                          ),
                    FilledButton(
                      onPressed: () {
                        controller.addUpdateFaqDialog(
                          title: "Add question answer",
                          ctx: context,
                        );
                      },
                      style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                          AppColor.btnGreenColor,
                        ),
                      ),
                      child: const Text(
                        '+ Add Question Answer',
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
                () =>
                    controller.isError.value || controller.questionList.isEmpty
                        ? const Gap(0)
                        : Container(
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
                                3: FixedColumnWidth(150),
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
                                      'Question',
                                      style: AppTextStyle.semiBoldStyle(
                                        color: AppColor.black,
                                        size: 20,
                                      ),
                                    ),
                                    Text(
                                      'Answer',
                                      style: AppTextStyle.semiBoldStyle(
                                        color: AppColor.black,
                                        size: 20,
                                      ),
                                    ),
                                    Text(
                                      'Answered',
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
                        ? controller.questionList.isEmpty
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Questions not found.",
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
                                          0: FixedColumnWidth(100),
                                          1: FlexColumnWidth(),
                                          2: FlexColumnWidth(),
                                          3: FixedColumnWidth(150),
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
                                                    right: 10.0),
                                                child: Text(
                                                  controller.questionList[index]
                                                          .quotation ??
                                                      "",
                                                  style: AppTextStyle
                                                      .semiBoldStyle(
                                                    color: AppColor
                                                        .tableRowTextColor,
                                                    size: 16,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10.0),
                                                child: Text(
                                                  controller.questionList[index]
                                                          .answer ??
                                                      "-",
                                                  style: AppTextStyle
                                                      .semiBoldStyle(
                                                    color: AppColor
                                                        .tableRowTextColor,
                                                    size: 16,
                                                  ),
                                                  maxLines: 3,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  controller.questionList[index]
                                                              .answer !=
                                                          null
                                                      ? Container(
                                                          height: 30,
                                                          width: 30,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            color: AppColor
                                                                .btnGreenColor,
                                                          ),
                                                          alignment:
                                                              Alignment.center,
                                                          child: const Icon(
                                                            FluentIcons
                                                                .check_mark,
                                                            color:
                                                                AppColor.white,
                                                            size: 22,
                                                          ),
                                                        )
                                                      : Container(
                                                          alignment:
                                                              Alignment.center,
                                                          height: 30,
                                                          width: 30,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            color: AppColor
                                                                .btnRedColor,
                                                          ),
                                                          child: const Icon(
                                                            FluentIcons.clear,
                                                            color:
                                                                AppColor.white,
                                                            size: 15,
                                                          ),
                                                        ),
                                                ],
                                              ),
                                              Obx(
                                                () => controller
                                                            .isProcess.value &&
                                                        controller
                                                                .questionList[
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
                                                          controller
                                                                      .questionList[
                                                                          index]
                                                                      .answer !=
                                                                  null
                                                              ? GestureDetector(
                                                                  onTap: () {
                                                                    controller
                                                                        .questionController
                                                                        .text = controller
                                                                            .questionList[index]
                                                                            .quotation ??
                                                                        "";

                                                                    controller
                                                                        .answerController
                                                                        .text = controller
                                                                            .questionList[index]
                                                                            .answer ??
                                                                        "";
                                                                    controller
                                                                        .addUpdateFaqDialog(
                                                                      title:
                                                                          "Answer question",
                                                                      ctx:
                                                                          context,
                                                                      isEdit: controller
                                                                              .questionList[index]
                                                                              .sId ??
                                                                          "",
                                                                    );
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    height: 26,
                                                                    width: 26,
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            6),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: AppColor
                                                                          .btnGreenColor,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              4),
                                                                    ),
                                                                    child: SvgPicture
                                                                        .asset(
                                                                      AppIcons
                                                                          .editAnswerIcon,
                                                                    ),
                                                                  ),
                                                                )
                                                              : GestureDetector(
                                                                  onTap: () {
                                                                    controller
                                                                        .questionController
                                                                        .text = controller
                                                                            .questionList[index]
                                                                            .quotation ??
                                                                        "";

                                                                    controller
                                                                        .addUpdateFaqDialog(
                                                                      title:
                                                                          "Answer question",
                                                                      ctx:
                                                                          context,
                                                                      isEdit: controller
                                                                              .questionList[index]
                                                                              .sId ??
                                                                          "",
                                                                    );
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    height: 26,
                                                                    width: 26,
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            6),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: AppColor
                                                                          .btnGreenColor,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              4),
                                                                    ),
                                                                    child: SvgPicture.asset(
                                                                        AppIcons
                                                                            .questionAnswerIcon),
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
                                                                    "View question details",
                                                                content: controller
                                                                    .showQuestionDetail(
                                                                        data: controller
                                                                            .questionList[index]),
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
                                                                  .delete,
                                                              color: AppColor
                                                                  .white,
                                                            ),
                                                            onPressed: () {
                                                              controller
                                                                  .showDeleteDialog(
                                                                ctx: context,
                                                                i: index,
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
                                  itemCount: controller.questionList.length,
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
