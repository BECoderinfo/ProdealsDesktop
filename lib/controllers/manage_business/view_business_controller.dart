import 'package:pro_deals_admin/utils/imports.dart';

class ViewBusinessController extends GetxController {
  final viewBusinessKey = GlobalKey(debugLabel: 'View Business Details');

  RxInt currentIndex = 0.obs;

  TextStyle tabTextStyle({required int index}) {
    return currentIndex.value == index
        ? AppTextStyle.mediumStyle(
            color: Colors.black,
            size: 18,
          )
        : AppTextStyle.regularStyle(
            color: AppColor.smokyBlack,
            size: 16,
          );
  }

  Widget summaryWidget({
    required String title,
    required String content,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyle.mediumStyle(
            color: AppColor.smokyBlack,
            size: 20,
          ),
        ),
        Text(
          content,
          style: AppTextStyle.regularStyle(
            color: AppColor.smokyBlack,
            size: 18,
          ),
        ),
      ],
    );
  }

  zoomImage({
    required List<int> data,
    required BuildContext ctx,
    required double wid,
  }) {
    showDialog(
      context: ctx,
      barrierDismissible: true,
      builder: (context) {
        return FluentTheme(
          data: FluentThemeData.light(),
          child: ContentDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(FluentIcons.clear),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            content: InteractiveViewer(
              panEnabled: true,
              minScale: 0.5,
              maxScale: 4.0,
              child: Image.memory(
                Uint8List.fromList(
                  data,
                ),
                height: wid / 3,
                width: wid / 3,
                fit: BoxFit.contain,
              ),
            ),
          ),
        );
      },
    );
  }
}
