import 'package:pro_deals_admin/utils/imports.dart';

class ManageNotificationController extends GetxController {
  final BuildContext ctx;

  ManageNotificationController({required this.ctx});

  RxList<NotificationItem> notificationList = <NotificationItem>[].obs;

  RxBool isLoaded = false.obs;
  RxBool isError = false.obs;
  RxBool isProcess = false.obs;
  RxString nId = "".obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAllNotification();
  }

  getAllNotification() async {
    try {
      isLoaded.value = false;
      var response = await ApiService.getApi(
        Apis.getAllNotification,
        ctx,
      );

      if (response != null) {
        notificationList.clear();
        if (response['notifications'] is List ||
            response['notifications'].isNotEmpty) {
          List<NotificationListResopnse> list = <NotificationListResopnse>[];
          response['notifications']
              .map((e) => list.add(NotificationListResopnse.fromJson(e)))
              .toList();

          notificationList.value = sortItem(notificationList: list);
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

  List<NotificationItem> sortItem(
      {required List<NotificationListResopnse> notificationList}) {
    DateTime now = DateTime.now();
    DateTime todayStart = DateTime(now.year, now.month, now.day);
    DateTime yesterdayStart = todayStart.subtract(const Duration(days: 1));
    DateTime lastWeekStart = todayStart.subtract(const Duration(days: 7));
    DateTime lastMonthStart = DateTime(now.year, now.month - 1, now.day);
    DateTime lastYearStart = DateTime(now.year - 1, now.month, now.day);

    List<NotificationItem> sortedList = [];

    bool todayAdded = false;
    bool yesterdayAdded = false;
    bool lastWeekAdded = false;
    bool lastMonthAdded = false;
    bool lastYearAdded = false;
    bool olderAdded = false;

    for (var notification in notificationList) {
      if (DateTime.parse(notification.createdAt ?? "${DateTime.now()}")
          .toLocal()
          .isAfter(todayStart)) {
        if (!todayAdded) {
          sortedList.add(NotificationItem.header('Today'));
          todayAdded = true;
        }
        sortedList.add(NotificationItem.notification(notification));
      } else if (DateTime.parse(notification.createdAt ?? "${DateTime.now()}")
              .toLocal()
              .isAfter(yesterdayStart) &&
          DateTime.parse(notification.createdAt ?? "${DateTime.now()}")
              .toLocal()
              .isBefore(todayStart)) {
        if (!yesterdayAdded) {
          sortedList.add(NotificationItem.header('Yesterday'));
          yesterdayAdded = true;
        }
        sortedList.add(NotificationItem.notification(notification));
      } else if (DateTime.parse(notification.createdAt ?? "${DateTime.now()}")
          .toLocal()
          .isAfter(lastWeekStart)) {
        if (!lastWeekAdded) {
          sortedList.add(NotificationItem.header('Last Week'));
          lastWeekAdded = true;
        }
        sortedList.add(NotificationItem.notification(notification));
      } else if (DateTime.parse(notification.createdAt ?? "${DateTime.now()}")
          .toLocal()
          .isAfter(lastMonthStart)) {
        if (!lastMonthAdded) {
          sortedList.add(NotificationItem.header('Last Month'));
          lastMonthAdded = true;
        }
        sortedList.add(NotificationItem.notification(notification));
      } else if (DateTime.parse(notification.createdAt ?? "${DateTime.now()}")
          .toLocal()
          .isAfter(lastYearStart)) {
        if (!lastYearAdded) {
          sortedList.add(NotificationItem.header('Last Year'));
          lastYearAdded = true;
        }
        sortedList.add(NotificationItem.notification(notification));
      } else {
        if (!olderAdded) {
          sortedList.add(NotificationItem.header('Older'));
          olderAdded = true;
        }
        sortedList.add(NotificationItem.notification(notification));
      }
    }

    return sortedList;
  }

  deleteNotification({required int i}) async {
    nId.value = notificationList[i].notification?.sId ?? "";
    try {
      var response = await ApiService.deleteApi(
        Apis.deleteNotification(nId: nId.value),
        ctx,
      );

      if (response != null) {
        if (i > 0 && i < notificationList.length - 1) {
          if (notificationList[i - 1].notification == null &&
              notificationList[i + 1].notification == null) {
            notificationList.removeAt(i);
            notificationList.removeAt(i - 1);
          } else {
            notificationList.removeAt(i);
          }
        } else if (i != 0) {
          if (notificationList[i - 1].notification == null) {
            notificationList.removeAt(i);
            notificationList.removeAt(i - 1);
          } else {
            notificationList.removeAt(i);
          }
        }
        ShowToast.toast(
          msg: response['message'] ?? "User deleted successfully.",
          ctx: ctx,
        );
        nId.value = "";
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
              'Delete Notification?',
              style: AppTextStyle.semiBoldStyle(
                color: AppColor.black,
                size: 18,
              ),
            ),
            content: Text(
              'Are you sure you want to delete this notification? This action cannot be undone.',
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
                  deleteNotification(i: i);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class NotificationItem {
  final String? header;
  final NotificationListResopnse? notification;

  NotificationItem.header(this.header) : notification = null;

  NotificationItem.notification(this.notification) : header = null;

  bool get isHeader => header != null;
}
