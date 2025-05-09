import '../../utils/imports.dart';

class ViewPlan extends GetView<ViewPlanDetailsController> {
  final MembershipPlanModel plan;

  const ViewPlan({
    super.key,
    required this.plan,
  });

  @override
  Widget build(BuildContext context) {
    double hit = MediaQuery.of(context).size.height;
    double wid = MediaQuery.of(context).size.width;
    return GetBuilder<ViewPlanDetailsController>(
      init: ViewPlanDetailsController(pId: plan.id ?? ""),
      builder: (controller) {
        return NavigationView(
          key: controller.viewPlanKey,
          appBar: NavigationAppBar(
            backgroundColor: AppColor.bgColor,
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon: const Icon(
                FluentIcons.back,
                size: 15.0,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              "View Plan Details",
              style: AppTextStyle.mediumStyle(
                color: AppColor.white,
                size: 20,
              ),
            ),
          ),
          content: Container(
            height: hit,
            width: wid,
            color: AppColor.white,
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  controller.rowWidget(
                    title: 'Plan name :',
                    value: plan.planName ?? "",
                  ),
                  const Gap(15),
                  controller.rowWidget(
                    title: 'Plan Duration :',
                    value: plan.planDuration ?? "",
                  ),
                  const Gap(15),
                  controller.rowWidget(
                    title: 'Plan Price :',
                    value: "₹ ${plan.planPrice ?? ""}",
                  ),
                  plan.planDescription?.isEmpty ?? true
                      ? const Gap(0)
                      : const Gap(15),
                  plan.planDescription?.isEmpty ?? true
                      ? const Gap(0)
                      : controller.rowWidget(
                          title: 'Plan Description :',
                          value: plan.planDescription
                                  ?.map(
                                    (e) => "${plan.planDescription!.indexWhere(
                                          (element) => element == e,
                                        ) + 1}. $e",
                                  )
                                  .toList()
                                  .join("\n") ??
                              "",
                        ),
                  const Gap(20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
