import 'package:pro_deals_admin/utils/imports.dart';

class ManageFAQController extends GetxController {
  final BuildContext ctx;

  ManageFAQController({required this.ctx});

  RxBool isProcess = false.obs;
  RxString id = "".obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAllQuestion();
  }

  RxList<FAQListModel> questionList = <FAQListModel>[].obs;
  RxBool isLoaded = false.obs;
  RxBool isError = false.obs;

  getAllQuestion() async {
    try {
      var response = await ApiService.getApi(
        Apis.getAllQuestion,
        ctx,
      );

      if (response != null) {
        questionList.clear();
        if (response['quotations'] is List &&
            response['quotations'].isNotEmpty) {
          response['quotations']
              .map((e) => questionList.add(FAQListModel.fromJson(e)))
              .toList();
        }
      }
      isLoaded.value = true;
    } catch (e) {
      isError.value = false;

      GFToast.showToast(e.toString(), ctx);
    }
  }

  addUpdateFaqDialog({
    required String title,
    required BuildContext ctx,
    String isEdit = "",
  }) {
    showDialog(
      context: ctx,
      builder: (context) {
        return FluentTheme(
          data: FluentThemeData.light(),
          child: ContentDialog(
            title: Text(
              title,
              style: AppTextStyle.semiBoldStyle(
                color: AppColor.black,
                size: 18,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InfoLabel(
                  label: "Question",
                  labelStyle: AppTextStyle.boldStyle(
                    size: 16,
                    color: AppColor.black300,
                  ),
                  child: Obx(
                    () => TextBoxCustom(
                      onTap: () {
                        if (isEdit.isNotEmpty) {
                          ShowToast.toast(
                            msg: "You can't edit question.",
                            ctx: ctx,
                          );
                        }
                      },
                      controller: questionController,
                      placeholder: "Enter question",
                      readOnly: isEdit.isNotEmpty,
                      errorText: questionError.value.isEmpty
                          ? null
                          : questionError.value,
                      maxline: isEdit.isNotEmpty ? 2 : null,
                      onChange: (value) {
                        if (value.isNotEmpty &&
                            questionError.value.isNotEmpty) {
                          questionError.value = "";
                        }
                      },
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.25),
                        ),
                      ),
                    ),
                  ),
                ),
                const Gap(10),
                InfoLabel(
                  label: "Answer",
                  labelStyle: AppTextStyle.boldStyle(
                    size: 16,
                    color: AppColor.black300,
                  ),
                  child: Obx(
                    () => TextBoxCustom(
                      controller: answerController,
                      placeholder: "Enter answer",
                      maxline: 3,
                      errorText:
                          answerError.value.isEmpty ? null : answerError.value,
                      onChange: (value) {
                        if (value.isNotEmpty && answerError.value.isNotEmpty) {
                          answerError.value = "";
                        }
                      },
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.25),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            actions: [
              Button(
                child: Text(
                  'Cancel',
                  style: AppTextStyle.mediumStyle(
                    color: AppColor.black,
                    size: 15,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              Obx(
                () => isProcess.value
                    ? CustomCircularIndicator.indicator(
                        color1: Colors.grey.withOpacity(0.5),
                        color: AppColor.black,
                      )
                    : Button(
                        style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.resolveWith((states) {
                            if (states.isHovered) {
                              return AppColor.btnGreenColor.withOpacity(0.5);
                            }
                            return AppColor.btnGreenColor;
                          }),
                        ),
                        child: Text(
                          isEdit.isNotEmpty
                              ? 'Answer question'
                              : 'Add question',
                          style: AppTextStyle.mediumStyle(
                            color: AppColor.white,
                            size: 15,
                          ),
                        ),
                        onPressed: () async {
                          clearError();
                          if ((isEdit.isEmpty &&
                                  questionController.text.isEmpty) ||
                              answerController.text.isEmpty) {
                            if (isEdit.isEmpty &&
                                questionController.text.isEmpty) {
                              answerError.value = "Please enter question.";
                            }
                            if (answerController.text.isEmpty) {
                              answerError.value = "Please enter answer.";
                            }
                          } else {
                            isProcess.value = true;
                            if (isEdit.isNotEmpty) {
                              apiCall(
                                ctx: ctx,
                                url: Apis.answerQuestion,
                                body: {
                                  "quotationId": isEdit,
                                  "answer": answerController.text
                                },
                              );
                            } else {
                              dynamic d = await apiCall(
                                ctx: ctx,
                                url: Apis.askQuestion,
                                body: {
                                  "user": StorageService.readData(
                                          key: StorageKeys.staffSId) ??
                                      "",
                                  "quotation": questionController.text,
                                },
                                type: 2,
                              );

                              if (d != null && d is String) {
                                apiCall(
                                  ctx: ctx,
                                  url: Apis.answerQuestion,
                                  body: {
                                    "quotationId": d,
                                    "answer": answerController.text
                                  },
                                );
                              }
                            }
                          }
                        },
                      ),
              ),
            ],
          ),
        );
      },
      barrierDismissible: true,
    ).then(
      (value) => clearFields(),
    );
  }

  TextEditingController answerController = TextEditingController();
  TextEditingController questionController = TextEditingController();
  RxString answerError = "".obs;
  RxString questionError = "".obs;

  clearError() {
    answerError.value = "";
    questionError.value = "";
  }

  clearFields() {
    answerController.clear();
    questionController.clear();
    answerError.value = "";
    questionError.value = "";
  }

  Future<dynamic> apiCall({
    required BuildContext ctx,
    required Uri url,
    required Map<String, String> body,
    int type = 1,
  }) async {
    try {
      var response = await ApiService.postApi(
        url,
        ctx,
        body: body,
      );

      if (response != null) {
        if (type == 2) {
          return response['support']['_id'];
        } else {
          Navigator.pop(ctx);
          getAllQuestion();
        }
      }
      isProcess.value = false;
    } catch (e) {
      isProcess.value = false;

      GFToast.showToast(e.toString(), ctx);
    }
  }

  deleteQuestion({required int i}) async {
    id.value = questionList[i].sId ?? "";
    try {
      var response = await ApiService.deleteApi(
        Apis.deleteQuestion(aId: id.value),
        ctx,
      );

      if (response != null) {
        questionList.removeAt(i);
        ShowToast.toast(
          msg: response['message'] ?? "Question deleted successfully.",
          ctx: ctx,
        );
        id.value = "";
      }
      isProcess.value = false;
    } catch (e) {
      isProcess.value = false;

      GFToast.showToast(e.toString(), ctx);
    }
  }

  showDeleteDialog({
    required BuildContext ctx,
    required int i,
  }) {
    showDialog(
      context: ctx,
      builder: (context) {
        return FluentTheme(
          data: FluentThemeData.light().copyWith(),
          child: ContentDialog(
            title: Text(
              'Delete Question?',
              style: AppTextStyle.semiBoldStyle(
                color: AppColor.black,
                size: 18,
              ),
            ),
            content: Text(
              'Are you sure you want to delete this question? This action cannot be undone.',
              style: AppTextStyle.regularStyle(
                color: AppColor.black,
                size: 17,
              ),
            ),
            actions: [
              Button(
                child: Text(
                  'Cancel',
                  style: AppTextStyle.mediumStyle(
                    color: AppColor.black,
                    size: 15,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              Button(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.resolveWith((states) {
                    if (states.isHovered) {
                      return Colors.red.withOpacity(0.5);
                    }
                    return Colors.red;
                  }),
                ),
                child: Text(
                  'OK',
                  style: AppTextStyle.mediumStyle(
                    color: AppColor.white,
                    size: 15,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  isProcess.value = true;
                  deleteQuestion(i: i);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  showDetailDialog({
    required BuildContext ctx,
    required String title,
    required Widget content,
  }) {
    showDialog(
      context: ctx,
      barrierDismissible: true,
      builder: (context) {
        return FluentTheme(
          data: FluentThemeData.light().copyWith(),
          child: ContentDialog(
            title: Text(
              title,
              style: AppTextStyle.semiBoldStyle(
                color: AppColor.black,
                size: 22,
              ),
            ),
            content: content,
            actions: [
              Button(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.resolveWith((states) {
                    if (states.isHovered) {
                      return AppColor.btnGreenColor.withOpacity(0.5);
                    }
                    return AppColor.btnGreenColor;
                  }),
                ),
                child: Text(
                  'OK',
                  style: AppTextStyle.mediumStyle(
                    color: AppColor.white,
                    size: 15,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget showQuestionDetail({required FAQListModel data}) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          rowWidget(
            title: "Question",
            value: data.quotation ?? "",
          ),
          const Gap(10),
          rowWidget(
            title: "Time",
            value: DateFormat("dd MMM, yyyy hh:mm a").format(
                DateTime.parse(data.createdAt ?? "${DateTime.now()}")
                    .toLocal()),
          ),
          data.answer == null ? const Gap(0) : const Gap(10),
          data.answer == null
              ? const Gap(0)
              : rowWidget(
                  title: "Answer",
                  value: data.answer ?? "",
                ),
          data.answer == null ? const Gap(0) : const Gap(10),
          data.answer == null
              ? const Gap(0)
              : rowWidget(
                  title: "Answer Time",
                  value: DateFormat("dd-MMM-yyyy hh:mm a").format(
                      DateTime.parse(data.updatedAt ?? "${DateTime.now()}")
                          .toLocal()),
                ),
        ],
      ),
    );
  }

  Widget rowWidget({
    required String title,
    required String value,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyle.semiBoldStyle(
            size: 20,
            color: AppColor.tableRowTextColor,
          ),
        ),
        Text(
          value,
          style: AppTextStyle.regularStyle(
            size: 18,
            color: AppColor.tableRowTextColor,
          ),
        ),
      ],
    );
  }
}
