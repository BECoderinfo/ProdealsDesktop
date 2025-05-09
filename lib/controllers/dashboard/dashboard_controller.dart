import 'package:pro_deals_admin/modal/chart_modal.dart';
import 'package:pro_deals_admin/utils/imports.dart';

class DashBoardController extends GetxController {
  final BuildContext ctx;

  DashBoardController({required this.ctx});

  RxBool isError = false.obs;
  RxBool isLoaded = false.obs;
  RxBool isProcess = false.obs;

  Rx<DashBoardDataModel?> dashBoardDataModel = Rx<DashBoardDataModel?>(null);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getDashBoardData();
  }

  getDashBoardData() async {
    try {
      isLoaded.value = false;

      var response = await ApiService.getApi(
        Apis.getDashBoardData,
        ctx,
      );

      if (response != null && response['status'] == 'success') {
        dashBoardDataModel.value =
            DashBoardDataModel.fromJson(response['data']);

        isLoaded.value = true; // Set isLoaded to true once data is fetched
      } else {
        isError.value = true;
        GFToast.showToast(response['message'] ?? 'Error fetching data', ctx);
      }
      getChartData();
    } catch (e) {
      isError.value = false;

      GFToast.showToast(e.toString(), ctx);
    }
  }

  RxBool isErrorChart = false.obs;
  RxBool isLoadedChart = false.obs;
  RxInt totalOrder = 0.obs;
  RxInt totalRevenue = 0.obs;
  RxString title = 'weekly'.obs;

  RxList<ChartModal> chartDataList = <ChartModal>[].obs;

  getChartData() async {
    try {
      isLoadedChart.value = false;
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
        isLoadedChart.value = true;
      } else {
        isErrorChart.value = true;
        GFToast.showToast(response['message'] ?? 'Error fetching data', ctx);
      }
    } catch (e) {
      isErrorChart.value = true;

      GFToast.showToast(e.toString(), ctx);
    }
  }

  updateChartData({required String title}) {
    this.title.value = title;
    getChartData();
  }
}
