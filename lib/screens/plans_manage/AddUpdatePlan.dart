import '../../utils/imports.dart';

class AddUpdatePlan extends GetView<PlanAddUpdateController> {
  final dynamic data;

  const AddUpdatePlan({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    double hit = MediaQuery.of(context).size.height;
    double wid = MediaQuery.of(context).size.width;
    return GetBuilder<PlanAddUpdateController>(
      init: PlanAddUpdateController(data: data),
      builder: (controller) {
        return NavigationView(
          key: controller.planKey,
          appBar: NavigationAppBar(
            backgroundColor: AppColor.bgColor,
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon: const Icon(FluentIcons.back, size: 15.0),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              "${controller.isEdit.value ? 'Update' : 'Add'} Membership Plan",
              style: AppTextStyle.mediumStyle(color: AppColor.white, size: 20),
            ),
          ),
          content: Container(
            height: hit,
            width: wid,
            color: AppColor.white,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: wid / 2.5,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 2),
                        blurRadius: 4,
                        color: AppColor.black.withOpacity(0.5),
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      _buildTextField(
                        label: 'Plan name',
                        controller: controller.planName,
                        errorText: controller.planNameError,
                      ),
                      const Gap(15),
                      _buildTextField(
                        label: 'Plan price',
                        controller: controller.planPrice,
                        errorText: controller.planPriceError,
                        placeholder: 'Enter plan price Ex: 999',
                      ),
                      const Gap(15),
                      _buildTextField(
                        label: 'Plan count',
                        controller: controller.planCount,
                        errorText: controller.planCountError,
                        placeholder: 'How may days, months or years',
                      ),
                      const Gap(15),
                      _buildDropdown(
                        label: 'Duration',
                        value: controller.selectedDuration,
                        items: controller.durationList,
                        onChanged: (val) =>
                            controller.selectedDuration.value = val!,
                      ),
                      const Gap(15),
                      _buildDescriptionField(controller),
                      const Gap(20),
                      Obx(() => controller.isProcess.value
                          ? CustomCircularIndicator.indicator(
                              color: AppColor.primary,
                              color1: Colors.white.withOpacity(0.25),
                            )
                          : FilledButton(
                              onPressed: () =>
                                  controller.checkValidation(ctx: context),
                              style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all(
                                  AppColor.btnGreenColor,
                                ),
                              ),
                              child: Text(
                                controller.isEdit.value
                                    ? 'Update plan now'
                                    : 'Create Now',
                                style: AppTextStyle.mediumStyle(
                                  color: AppColor.white,
                                  size: 17,
                                ),
                              ),
                            )),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required RxString errorText,
    String placeholder = '',
  }) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(label,
              style: AppTextStyle.mediumStyle(size: 20, color: AppColor.black)),
        ),
        const Gap(10),
        Expanded(
          flex: 3,
          child: Obx(() => TextBoxCustom(
                controller: controller,
                placeholder:
                    placeholder.isNotEmpty ? placeholder : 'Enter $label',
                errorText: errorText.value.isEmpty ? null : errorText.value,
                onChange: (value) {
                  if (value.isNotEmpty && errorText.isNotEmpty) {
                    errorText.value = "";
                  }
                },
              )),
        ),
      ],
    );
  }

  Widget _buildDropdown({
    required String label,
    required RxString value,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(label,
              style: AppTextStyle.mediumStyle(size: 20, color: AppColor.black)),
        ),
        const Gap(10),
        Expanded(
          flex: 3,
          child: Obx(() => FluentTheme(
                data: FluentThemeData.light(),
                child: ComboBox<String>(
                  value: value.value,
                  items: items
                      .map((e) => ComboBoxItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: onChanged,
                ),
              )),
        ),
      ],
    );
  }

  Widget _buildDescriptionField(PlanAddUpdateController controller) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Text('Description',
              style: AppTextStyle.mediumStyle(size: 20, color: AppColor.black)),
        ),
        const Gap(10),
        Expanded(
          flex: 3,
          child: Obx(
            () => ListView.separated(
              itemCount: controller.descriptionList.length,
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (_, __) => const Gap(10),
              itemBuilder: (context, index) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Obx(() => TextBoxCustom(
                            controller: controller.descriptionList[index],
                            placeholder: 'Enter description',
                            errorText:
                                controller.descriptionErrorList[index].isEmpty
                                    ? null
                                    : controller.descriptionErrorList[index],
                            onChange: (value) {
                              if (value.isNotEmpty &&
                                  controller
                                      .descriptionErrorList[index].isNotEmpty) {
                                controller.descriptionErrorList[index] = "";
                              }
                            },
                          )),
                    ),
                    const Gap(10),
                    FluentTheme(
                      data: FluentThemeData.light(),
                      child: GestureDetector(
                        onTap: () {
                          if (index == 0) {
                            controller.descriptionList
                                .add(TextEditingController());
                            controller.descriptionErrorList.add("");
                          } else {
                            controller.descriptionList.removeAt(index);
                            controller.descriptionErrorList.removeAt(index);
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: index == 0
                                ? AppColor.btnGreenColor
                                : AppColor.btnRedColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: const EdgeInsets.all(10),
                          child: Icon(
                            index == 0 ? FluentIcons.add : FluentIcons.delete,
                            color: AppColor.white,
                            size: 15,
                          ),
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
