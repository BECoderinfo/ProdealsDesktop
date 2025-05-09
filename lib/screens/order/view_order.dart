import 'package:pro_deals_admin/controllers/manage_order/ViewOrderController.dart';
import 'package:pro_deals_admin/modal/order_model.dart';
import 'package:pro_deals_admin/utils/imports.dart';

class ViewOrder extends GetView<ViewBusinessController> {
  final OrderModal order;

  const ViewOrder({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    double hit = MediaQuery.of(context).size.height;
    double wid = MediaQuery.of(context).size.width;
    return GetBuilder<ViewOrderController>(
      init: ViewOrderController(),
      builder: (controller) {
        return NavigationView(
          key: controller.viewOrderKey,
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
              "View Order Details",
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
            child: FluentTheme(
              data: FluentThemeData.light(),
              child: Obx(
                () => TabView(
                  currentIndex: controller.currentIndex.value,
                  onChanged: (value) => controller.currentIndex.value = value,
                  closeButtonVisibility: CloseButtonVisibilityMode.never,
                  tabWidthBehavior: TabWidthBehavior.sizeToContent,
                  tabs: [
                    Tab(
                      text: Text(
                        "Information",
                        style: controller.tabTextStyle(index: 0),
                      ),
                      body: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(25),
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              if (constraints.maxWidth > 800) {
                                return Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                        child:
                                            _buildUserInfoSection(controller)),
                                    const SizedBox(width: 20),
                                    Expanded(
                                        child: _buildBusinessInfoSection(
                                            controller)),
                                    const SizedBox(width: 20),
                                    Expanded(
                                        child: _buildOrderInfoSection(
                                            controller, context)),
                                  ],
                                );
                              } else {
                                return Column(
                                  children: [
                                    _buildUserInfoSection(controller),
                                    const SizedBox(height: 20),
                                    _buildBusinessInfoSection(controller),
                                    const SizedBox(height: 20),
                                    _buildOrderInfoSection(controller, context),
                                  ],
                                );
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildUserInfoSection(ViewOrderController controller) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 10,
            color: Colors.black.withOpacity(0.1),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'User Information',
            style: AppTextStyle.boldStyle(
              color: AppColor.smokyBlack,
              size: 22,
            ),
          ),
          const Gap(10),
          const Divider(
            size: 200,
            style: DividerThemeData(
                thickness: 1.5, horizontalMargin: EdgeInsets.all(0)),
          ),
          const Gap(10),
          Text(
            "Profile Image",
            style: AppTextStyle.mediumStyle(
              color: AppColor.smokyBlack,
              size: 20,
            ),
          ),
          const Gap(10),
          ClipOval(
            child: order.userId?.image?.data != null
                ? Image.memory(
                    Uint8List.fromList(order.userId!.image!.data!),
                    height: 125,
                    width: 125,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Image.asset(
                      'assets/images/default_image.png',
                      height: 125,
                      width: 125,
                    ),
                  )
                : Image.asset(
                    'assets/images/default_image.png',
                    height: 125,
                    width: 125,
                    fit: BoxFit.cover,
                  ),
          ),
          const Gap(10),
          controller.summaryWidget(
            title: 'Name',
            content: order.userId?.userName ?? "",
          ),
          const Gap(10),
          Row(
            children: [
              const Icon(FluentIcons.phone,
                  size: 16, color: AppColor.smokyBlack),
              const SizedBox(width: 8),
              Text(order.userId?.phone ?? "",
                  style: AppTextStyle.mediumStyle(
                      size: 16, color: AppColor.black)),
            ],
          ),
          const Gap(10),
          Row(
            children: [
              const Icon(FluentIcons.mail,
                  size: 16, color: AppColor.smokyBlack),
              const SizedBox(width: 8),
              Text(order.userId?.email ?? "",
                  style: AppTextStyle.mediumStyle(
                      size: 16, color: AppColor.black)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBusinessInfoSection(ViewOrderController controller) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 10,
            color: Colors.black.withOpacity(0.1),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Business Information',
            style: AppTextStyle.boldStyle(
              color: AppColor.smokyBlack,
              size: 22,
            ),
          ),
          const Gap(10),
          const Divider(
            size: 250,
            style: DividerThemeData(
                thickness: 1.5, horizontalMargin: EdgeInsets.all(0)),
          ),
          const Gap(10),
          Text(
            "Main Image",
            style: AppTextStyle.mediumStyle(
              color: AppColor.smokyBlack,
              size: 20,
            ),
          ),
          const Gap(10),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: order.businessId?.mainImage?.data != null
                ? Image.memory(
                    Uint8List.fromList(
                        order.businessId!.mainImage!.data!.data!),
                    height: 200,
                    width: 200,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Image.asset(
                      'assets/images/default_image.png',
                      height: 200,
                      width: 200,
                    ),
                  )
                : Image.asset(
                    'assets/images/default_image.png',
                    height: 200,
                    width: 200,
                    fit: BoxFit.cover,
                  ),
          ),
          const Gap(10),
          controller.summaryWidget(
            title: 'Name',
            content: order.businessId?.businessName ?? "",
          ),
          const Gap(10),
          Row(
            children: [
              const Icon(FluentIcons.phone,
                  size: 16, color: AppColor.smokyBlack),
              const SizedBox(width: 8),
              Text(order.businessId?.contactNumber ?? "",
                  style: AppTextStyle.mediumStyle(
                      size: 16, color: AppColor.black)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOrderInfoSection(
      ViewOrderController controller, BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: MediaQuery.of(context).size.width / 3.5,
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 10,
            color: Colors.black.withOpacity(0.1),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order Information',
            style: AppTextStyle.boldStyle(
              color: AppColor.smokyBlack,
              size: 22,
            ),
          ),
          const Gap(10),
          const Divider(
            size: 220,
            style: DividerThemeData(
                thickness: 1.5, horizontalMargin: EdgeInsets.all(0)),
          ),
          const Gap(10),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: BoxDecoration(
              color: _getStatusColor(order.status),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              order.status ?? '',
              style: AppTextStyle.mediumStyle(color: AppColor.white, size: 16),
            ),
          ),
          const Gap(10),
          controller.summaryWidget(
            title: 'Promo-code',
            content: order.promocode ?? "Not used",
          ),
          const Gap(10),
          controller.summaryWidget(
            title: 'offer-price',
            content: "${order.offerprice ?? "0"}",
          ),
          const Gap(10),
          controller.summaryWidget(
            title: 'Discount',
            content: "${order.discount ?? "0"}",
          ),
          const Gap(10),
          controller.summaryWidget(
            title: 'Total Price',
            content: "${order.totalPrice ?? ""}",
          ),
          const Gap(10),
          controller.summaryWidget(
            title: 'Order Status',
            content: order.orderStatus ?? "",
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String? status) {
    switch (status) {
      case 'Completed':
        return Colors.green;
      case 'Cancelled':
        return Colors.red;
      default:
        return Colors.orange;
    }
  }
}
