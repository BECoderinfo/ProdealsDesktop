import 'package:pro_deals_admin/utils/imports.dart';

import '../subscriptions/subscriptions.dart';

class panel extends GetView<PanelController> {
  const panel({super.key});

  @override
  Widget build(BuildContext context) {
    double wid = MediaQuery.of(context).size.width;
    return GetBuilder<PanelController>(
      init: PanelController(),
      builder: (controller) => Obx(
        () {
          return NavigationView(
            appBar: NavigationAppBar(
              title: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Admin',
                  style: GoogleFonts.poppins(
                    color: AppColor.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              actions: SizedBox(
                width: wid / 1.2,
                child: Row(
                  children: [
                    const Gap(20),
                    const Spacer(),
                    Center(
                      child: AnimatedBuilder(
                        animation: aEmail,
                        builder: (context, child) {
                          return Text(
                            aEmail.value,
                            style: GoogleFonts.poppins(
                              color: AppColor.white,
                            ),
                          );
                        },
                      ),
                    ),
                    const Gap(40),
                  ],
                ),
              ),
              automaticallyImplyLeading: false,
            ),
            pane: NavigationPane(
              selected: controller.select.value,
              size: const NavigationPaneSize(
                openMinWidth: 100,
                openMaxWidth: 200,
              ),
              displayMode: PaneDisplayMode.compact,
              items: <NavigationPaneItem>[
                PaneItem(
                  icon: const Icon(
                    FluentIcons.home,
                    size: 18,
                  ),
                  body: const Dashboard(),
                  title: const Text('DashBoard'),
                  onTap: () {
                    controller.select.value = 0;
                  },
                ),
                PaneItem(
                  icon: const Icon(
                    FluentIcons.manager_self_service,
                    size: 18,
                  ),
                  onTap: () {
                    controller.select.value = 1;
                  },
                  body: const ManageBusiness(),
                  title: const Text('Manage Business'),
                ),
                PaneItem(
                  icon: const Icon(
                    FluentIcons.manager_self_service,
                    size: 18,
                  ),
                  onTap: () {
                    controller.select.value = 2;
                  },
                  body: const ManageBusinessRequest(),
                  title: const Text('Manage Business Request'),
                ),
                PaneItem(
                  icon: const Icon(
                    FluentIcons.hands_free,
                    size: 18,
                  ),
                  onTap: () {
                    controller.select.value = 3;
                  },
                  body: const offers(),
                  title: const Text('Offers & Deals'),
                ),
                PaneItem(
                  icon: const Icon(
                    FluentIcons.account_management,
                    size: 18,
                  ),
                  onTap: () {
                    controller.select.value = 4;
                  },
                  body: const ManageUsers(),
                  title: const Text('Manage Users'),
                ),
                PaneItem(
                  icon: const Icon(
                    FluentIcons.activate_orders,
                    size: 18,
                  ),
                  onTap: () {
                    controller.select.value = 5;
                  },
                  body: const MangeOrders(),
                  title: const Text('Mange Total Orders'),
                ),
                PaneItem(
                  icon: const Icon(
                    FluentIcons.money,
                    size: 18,
                  ),
                  onTap: () {
                    controller.select.value = 6;
                  },
                  body: ManageEarning(),
                  title: const Text('Mange Earning'),
                ),
                PaneItem(
                  icon: const Icon(
                    FluentIcons.alt_text,
                    size: 18,
                  ),
                  onTap: () {
                    controller.select.value = 7;
                  },
                  body: const ManageBanner(),
                  title: const Text('Manage Banner'),
                ),
                PaneItem(
                  icon: const Icon(
                    FluentIcons.ringer,
                    size: 18,
                  ),
                  onTap: () {
                    controller.select.value = 8;
                  },
                  body: const ManageNotification(),
                  title: const Text('Manage Notification'),
                ),
                PaneItem(
                  icon: const Icon(
                    FluentIcons.diamond,
                    size: 18,
                  ),
                  onTap: () {
                    controller.select.value = 9;
                  },
                  body: const ManageMembershipPlansScreen(),
                  title: const Text('Manage Membership Plans'),
                ),
                PaneItem(
                  icon: const Icon(
                    FluentIcons.user_sync,
                    size: 18,
                  ),
                  onTap: () {
                    controller.select.value = 10;
                  },
                  body: const Subscriptions(),
                  title: const Text('Subscribed Users'),
                ),
                PaneItem(
                  icon: const Icon(
                    FluentIcons.admin_c_logo_inverse32,
                    size: 18,
                  ),
                  onTap: () {
                    controller.select.value = 11;
                  },
                  body: const ManageCMS(),
                  title: const Text('Manage CMS Pages'),
                ),
                PaneItem(
                  icon: const Icon(
                    FluentIcons.coupon,
                    size: 18,
                  ),
                  onTap: () {
                    controller.select.value = 12;
                  },
                  body: const ManageCoupons(),
                  title: const Text('Manage Coupons'),
                ),
                PaneItem(
                  icon: const Icon(
                    FluentIcons.settings,
                    size: 18,
                  ),
                  onTap: () {
                    controller.select.value = 13;
                  },
                  body: const SettingScreen(),
                  title: const Text('Setting'),
                ),
              ],
              footerItems: [
                PaneItem(
                  icon: const Icon(FluentIcons.sign_out),
                  title: const Text('Log out'),
                  body: Container(),
                  onTap: () {
                    StorageService.removeData(key: StorageKeys.isLoggedIn);
                    StorageService.removeBox();
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/login',
                      (route) => false,
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
