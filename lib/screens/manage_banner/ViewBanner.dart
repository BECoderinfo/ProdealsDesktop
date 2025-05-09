import 'package:pro_deals_admin/utils/imports.dart';

class ViewBanner extends GetView<ViewBannerController> {
  final BannerListModel model;

  const ViewBanner({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    double hit = MediaQuery.of(context).size.height;
    double wid = MediaQuery.of(context).size.width;
    return GetBuilder<ViewBannerController>(
      init: ViewBannerController(),
      builder: (controller) {
        return NavigationView(
          key: controller.viewBannerKey,
          appBar: NavigationAppBar(
            backgroundColor: AppColor.bgColor,
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon: const Icon(
                FluentIcons.back,
                size: 15.0,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              "View Banner Details",
              style: AppTextStyle.mediumStyle(
                color: AppColor.white,
                size: 20,
              ),
            ),
          ),
          content: Container(
            height: hit,
            width: wid,
            color: AppColor.white,
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.start,
                runSpacing: 20,
                spacing: 20,
                children: [
                  Container(
                    width: wid / 3.5,
                    padding: const EdgeInsets.symmetric(
                      vertical: 25,
                      horizontal: 25,
                    ),
                    decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(0, 2),
                          blurRadius: 4,
                          color: AppColor.black.withOpacity(0.5),
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Banner details",
                              style: AppTextStyle.semiBoldStyle(
                                size: 25,
                                color: AppColor.tableRowTextColor,
                              ),
                            ),
                          ],
                        ),
                        const Gap(20),
                        Text(
                          'Banner image',
                          style: AppTextStyle.semiBoldStyle(
                            size: 20,
                            color: AppColor.tableRowTextColor,
                          ),
                        ),
                        const Gap(10),
                        GestureDetector(
                          onTap: () {
                            controller.zoomImage(
                              data: model.image!.data!,
                              ctx: context,
                              wid: wid,
                            );
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.memory(
                              Uint8List.fromList(
                                model.image!.data!,
                              ),
                              height: 150,
                              width: 320,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const Gap(20),
                        controller.rowWidget(
                          title: "Banner created date",
                          value: DateFormat('dd MMM, yyyy').format(
                            DateTime.parse(
                                    model.createdAt ?? "${DateTime.now()}")
                                .toLocal(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: wid / 3.5,
                    padding: const EdgeInsets.symmetric(
                      vertical: 25,
                      horizontal: 25,
                    ),
                    decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(0, 2),
                          blurRadius: 4,
                          color: AppColor.black.withOpacity(0.5),
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Offer details",
                              style: AppTextStyle.semiBoldStyle(
                                size: 25,
                                color: AppColor.tableRowTextColor,
                              ),
                            ),
                          ],
                        ),
                        const Gap(15),
                        controller.rowWidget(
                          title: "Offer description",
                          value: model.offerId?.description ?? "",
                        ),
                        const Gap(10),
                        controller.rowWidget(
                          title: "Offer valid days",
                          value: model.offerId?.validOn ?? "",
                        ),
                        const Gap(10),
                        controller.rowWidget(
                          title: "Offer amount",
                          value:
                              'Product price: ${model.offerId?.productPrice ?? 0} ₹\nDiscount price: ${model.offerId?.offerPrice ?? 0} ${model.offerId?.offertype == "Amount" ? '₹' : '%'}\nPayment amount: ${model.offerId?.paymentAmount ?? 0} ₹',
                        ),
                        const Gap(10),
                        controller.rowWidget(
                          title: "Total users",
                          value:
                              'Total ${model.offerId?.usedBy?.length ?? 0} users used this offer.',
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
