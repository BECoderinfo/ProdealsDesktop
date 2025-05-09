import 'package:pro_deals_admin/utils/imports.dart';

class ShowToast {
  static toast({
    required String msg,
    required BuildContext ctx,
  }) {
    GFToast.showToast(
      msg,
      ctx,
      backgroundColor: AppColor.black,
      toastBorderRadius: 5.0,
      toastPosition: GFToastPosition.BOTTOM,
    );
  }
}
