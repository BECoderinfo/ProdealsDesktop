import '../../utils/imports.dart';

class IntroPage extends GetView<IntroController> {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    return GetBuilder<IntroController>(
      init: IntroController(ctx: context),
      builder: (controller) {
        return NavigationView(
          content: Container(
            height: h,
            width: w,
            color: AppColor.primary,
            alignment: Alignment.center,
            child: Container(
              height: h! / 1.8,
              width: w! / 3.8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(w! / 16),
                color: AppColor.white,
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(0, 4),
                    blurRadius: 2,
                    color: AppColor.black300,
                  ),
                ],
              ),
              padding: const EdgeInsets.all(40),
              child: SvgPicture.asset(logo_svg),
            ),
          ),
        );
      },
    );
  }
}
