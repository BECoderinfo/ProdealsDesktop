import 'dart:developer';

import '../../utils/imports.dart';

class ManageMembershipPlansController extends GetxController {
  final BuildContext ctx;

  ManageMembershipPlansController({required this.ctx});

  RxBool isError = false.obs;
  RxBool isLoaded = false.obs;
  RxBool isProcess = false.obs;

  RxList<MembershipPlanModel> allPlans = <MembershipPlanModel>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAllPlans();
  }

  getAllPlans() async {
    try {
      isLoaded.value = false;
      var response = await ApiService.getApi(
        Apis.getAllMembershipPlan,
        ctx,
      );

      if (response != null) {
        allPlans.clear();
        if (response['data'] is List || response['data'].isNotEmpty) {
          response['data']
              .map((e) => allPlans.add(MembershipPlanModel.fromJson(e)))
              .toList();
        }
        isLoaded.value = true;
      } else {
        isError.value = true;
      }
    } catch (e) {
      isError.value = false;

      GFToast.showToast(e.toString(), ctx);
    }
  }

  RxString pId = "".obs;

  deletePlan({required int i}) async {
    pId.value = allPlans[i].id ?? "";
    try {
      var response = await ApiService.deleteApi(
        Apis.deleteMembershipPlan(pId: pId.value),
        ctx,
      );

      if (response != null) {
        allPlans.removeAt(i);
        ShowToast.toast(
          msg: response['response'] ?? "Plan deleted successfully.",
          ctx: ctx,
        );
        pId.value = "";
      }
      isProcess.value = false;
    } catch (e) {
      isProcess.value = false;

      GFToast.showToast(e.toString(), ctx);
    }
  }

  void togglePlanStatus(
      {required BuildContext ctx,
      required String planId,
      required String currentStatus}) async {
    try {
      isProcess.value = true;
      pId.value = planId;

      String newStatus =
          currentStatus.toLowerCase() == 'active' ? 'Inactive' : 'Active';

      var res = await ApiService.putApi(
          Apis.toggleStatus(id: planId), body: {'planStatus': newStatus}, ctx);

      if (res != null) {
        log(res.toString());
        ShowToast.toast(msg: res['message'], ctx: ctx);
      }

      // await api.updatePlanStatus(planId, newStatus);
      await Future.delayed(const Duration(seconds: 1)); // Simulated delay
      getAllPlans(); // Refresh list
    } catch (e) {
      log(e.toString());
      GFToast.showToast(e.toString(), ctx);
    } finally {
      isProcess.value = false;
      pId.value = '';
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
              'Delete Plan?',
              style: AppTextStyle.semiBoldStyle(
                color: AppColor.black,
                size: 18,
              ),
            ),
            content: Text(
              'Are you sure you want to delete this plan? This action cannot be undone.',
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
                  'OK, delete',
                  style: AppTextStyle.mediumStyle(
                    color: AppColor.white,
                    size: 15,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  isProcess.value = true;
                  deletePlan(i: i);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
