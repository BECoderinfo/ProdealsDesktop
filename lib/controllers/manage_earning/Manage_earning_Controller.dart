import 'package:pro_deals_admin/modal/chart_modal.dart';
import 'package:pro_deals_admin/utils/imports.dart';

class ManageEarningController extends GetxController {
  final BuildContext ctx;

  ManageEarningController({required this.ctx});

  RxBool isError = false.obs;
  RxBool isLoaded = false.obs;
  RxBool isProcess = false.obs;
  RxInt totalOrder = 0.obs;
  RxInt totalRevenue = 0.obs;
  RxString title = 'weekly'.obs;

  RxList<ChartModal> chartDataList = <ChartModal>[].obs;

  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getChartData();
  }

  getChartData() async {
    try {
      isLoaded.value = false;
      chartDataList.clear();

      var response = await ApiService.getApi(
        Apis.getSalesData(title: title.value),
        ctx,
      );
      if (response != null) {
        for (var i = 0; i < response.length - 1; i++) {
          if (title.value == 'yearly') {
            chartDataList.add(ChartModal.fromJsonYear(response[i]));
          } else if (title.value == 'monthly') {
            chartDataList.add(ChartModal.fromJsonMonth(response[i]));
          } else {
            chartDataList.add(ChartModal.fromJsonDay(response[i]));
          }
        }
        isLoaded.value = true;
      } else {
        isError.value = true;
        GFToast.showToast(response['message'] ?? 'Error fetching data', ctx);
      }
    } catch (e) {
      isError.value = true;

      GFToast.showToast(e.toString(), ctx);
    }
  }

  updateChartData({required String title}) {
    this.title.value = title;
    getChartData();
  }
}
