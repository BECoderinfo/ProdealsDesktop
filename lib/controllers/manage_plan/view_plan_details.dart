import 'package:pro_deals_admin/utils/imports.dart';

class ViewPlanDetailsController extends GetxController {
  final String pId;

  ViewPlanDetailsController({required this.pId});

  final viewPlanKey = GlobalKey(debugLabel: 'View Plan Details Key');

  Widget rowWidget({
    required String title,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyle.semiBoldStyle(
            size: 20,
            color: AppColor.tableRowTextColor,
          ),
        ),
        const Gap(10),
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
