import 'package:pro_deals_admin/utils/imports.dart';

class StaffPanel extends GetView<StaffPanelController> {
  const StaffPanel({super.key});

  @override
  Widget build(BuildContext context) {
    double wid = MediaQuery.of(context).size.width;
    return GetBuilder<StaffPanelController>(
      init: StaffPanelController(),
      builder: (controller) => Obx(
        () {
          return NavigationView(
            appBar: NavigationAppBar(
              title: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  '${StorageService.readData(key: StorageKeys.staffName) ?? ""}',
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
                    const Gap(20),
                    Center(
                      child: Text(
                        '${StorageService.readData(key: StorageKeys.staffEmail) ?? ""}',
                        style: GoogleFonts.poppins(
                          color: AppColor.white,
                        ),
                      ),
                    ),
                    const Gap(40),
                  ],
                ),
              ),
              automaticallyImplyLeading: false,
            ),
            pane: NavigationPane(
              selected: controller.selected.value,
              size: const NavigationPaneSize(
                openMinWidth: 100,
                openMaxWidth: 200,
              ),
              displayMode: PaneDisplayMode.compact,
              items: <NavigationPaneItem>[
                PaneItem(
                  icon: SvgPicture.asset(
                    AppIcons.cityIcon,
                    height: 18,
                    width: 18,
                    fit: BoxFit.cover,
                  ),
                  body: const ManageCityScreen(),
                  title: const Text(
                    'Manage city',
                  ),
                  onTap: () {
                    controller.selected.value = 0;
                  },
                ),
                PaneItem(
                  icon: SvgPicture.asset(
                    AppIcons.categoryIcon,
                    height: 18,
                    width: 18,
                    fit: BoxFit.cover,
                  ),
                  body: const ManageCategoryScreen(),
                  title: const Text(
                    'Manage category',
                  ),
                  onTap: () {
                    controller.selected.value = 1;
                  },
                ),
                PaneItem(
                  icon: SvgPicture.asset(
                    AppIcons.foodTypeIcon,
                    height: 18,
                    width: 18,
                    fit: BoxFit.cover,
                  ),
                  body: const ManageFoodTypeScreen(),
                  title: const Text(
                    'Manage food type',
                  ),
                  onTap: () {
                    controller.selected.value = 2;
                  },
                ),
                PaneItem(
                  icon: SvgPicture.asset(
                    AppIcons.faqIcon,
                    height: 18,
                    width: 18,
                    fit: BoxFit.cover,
                  ),
                  body: const ManageFaqScreen(),
                  title: const Text(
                    'Manage FAQ',
                  ),
                  onTap: () {
                    controller.selected.value = 3;
                  },
                ),
              ],
              footerItems: [
                PaneItem(
                  icon: GestureDetector(
                    onTap: () {
                      StorageService.removeData(
                          key: StorageKeys.isStaffLoggedIn);
                      StorageService.removeBox();
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/login',
                        (route) => false,
                      );
                    },
                    child: const Icon(FluentIcons.sign_out),
                  ),
                  title: const Text('Logout'),
                  body: Container(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
