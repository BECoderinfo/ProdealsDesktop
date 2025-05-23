import 'dart:developer';

import 'package:pro_deals_admin/modal/subscription_model.dart';

import '../../utils/imports.dart';

class SubscriptionsController extends GetxController {
  final BuildContext ctx;

  SubscriptionsController({required this.ctx});

  RxBool isError = false.obs;
  RxBool isLoaded = false.obs;
  RxBool isProcess = false.obs;

  RxList<SubscriptionModel> allSubscriptions = <SubscriptionModel>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAllSubscriptions();
  }

  getAllSubscriptions() async {
    try {
      isLoaded.value = false;
      var response = await ApiService.getApi(
        Apis.getAllSubscriptions,
        ctx,
      );

      if (response != null) {
        allSubscriptions.clear();
        if (response is List || response.isNotEmpty) {
          response
              .map((e) => allSubscriptions.add(SubscriptionModel.fromJson(e)))
              .toList();
        }
        isLoaded.value = true;
      } else {
        isError.value = true;
      }
    } catch (e) {
      isError.value = false;
      print(e.toString());

      GFToast.showToast(e.toString(), ctx);
    }
  }

  RxString pId = "".obs;

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
      getAllSubscriptions(); // Refresh list
    } catch (e) {
      log(e.toString());
      GFToast.showToast(e.toString(), ctx);
    } finally {
      isProcess.value = false;
      pId.value = '';
    }
  }
}
