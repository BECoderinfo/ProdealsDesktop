import 'package:pro_deals_admin/modal/order_model.dart';

import '../../utils/imports.dart';

class ManageOrderController extends GetxController {
  final BuildContext ctx;

  ManageOrderController({required this.ctx});

  RxBool isError = false.obs;
  RxBool isLoaded = false.obs;
  RxBool isProcess = false.obs;

  RxList<OrderModal> orderList = <OrderModal>[].obs;
  RxString oId = "".obs;

  @override
  void onInit() {
    super.onInit();
    getAllOrder();
  }

  getAllOrder() async {
    try {
      isLoaded.value = false;
      var response = await ApiService.getApi(
        Apis.getAllOrder,
        ctx,
      );
      if (response != null) {
        orderList.clear();
        if (response['orders'] is List || response['orders'].isNotEmpty) {
          response['orders']
              .map((e) => orderList.add(OrderModal.fromJson(e)))
              .toList();
        }
        isLoaded.value = true;
      } else {
        isError.value = true;
      }
    } catch (e) {
      isError.value = true;

      GFToast.showToast(e.toString(), ctx);
    }
  }

  deleteOrder({required int i}) async {
    oId.value = orderList[i].sId ?? "";
    try {
      var response = await ApiService.deleteApi(
        Apis.deleteOrder(oId: oId.value),
        ctx,
      );

      if (response != null) {
        orderList.removeAt(i);
        ShowToast.toast(
          msg: response['response'] ?? "Business deleted successfully.",
          ctx: ctx,
        );
        oId.value = "";
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
              'Delete Order?',
              style: AppTextStyle.semiBoldStyle(
                color: AppColor.black,
                size: 18,
              ),
            ),
            content: Text(
              'Are you sure you want to delete this Order? This action cannot be undone.',
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
                  deleteOrder(i: i);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
