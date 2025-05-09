import 'package:flutter/material.dart' show Icons;
import 'package:pro_deals_admin/utils/imports.dart';

class SettingScreen extends GetView<SettingsController> {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double hit = MediaQuery.of(context).size.height;
    double wid = MediaQuery.of(context).size.width;
    return GetBuilder<SettingsController>(
      init: SettingsController(),
      builder: (controller) => Container(
        height: hit,
        width: wid,
        color: AppColor.white,
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Setting',
                style: AppTextStyle.semiBoldStyle(
                  size: 32,
                  color: AppColor.black,
                ),
              ),
              const Gap(20),
              Button(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.resolveWith((states) {
                    if (states.isHovered) {
                      return AppColor.btnGreenColor.withOpacity(0.5);
                    }
                    return AppColor.btnGreenColor;
                  }),
                ),
                child: Text(
                  'Reset password',
                  style: AppTextStyle.mediumStyle(
                    color: AppColor.white,
                    size: 15,
                  ),
                ),
                onPressed: () {
                  controller.showBtnDialog(
                    ctx: context,
                    title: "Reset password",
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InfoLabel(
                          label: "Password",
                          labelStyle: AppTextStyle.boldStyle(
                            size: 16,
                            color: AppColor.black300,
                          ),
                          child: Obx(
                            () => TextBoxCustom(
                              controller: controller.passwordController,
                              placeholder: "Enter password",
                              errorText: controller.passwordError.value.isEmpty
                                  ? null
                                  : controller.passwordError.value,
                              onChange: (value) {
                                if (value.isNotEmpty &&
                                    controller.passwordError.value.isNotEmpty) {
                                  controller.passwordError.value = "";
                                }
                              },
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey.withOpacity(0.25),
                                ),
                              ),
                              obsecureText: !controller.showPassword.value,
                              suffix: IconButton(
                                icon: Icon(
                                  controller.showPassword.value
                                      ? Icons.visibility_off_rounded
                                      : Icons.visibility_rounded,
                                  size: 18,
                                ),
                                onPressed: () {
                                  controller.showPassword.value =
                                      !controller.showPassword.value;
                                },
                              ),
                            ),
                          ),
                        ),
                        const Gap(10),
                        InfoLabel(
                          label: "Confirm password",
                          labelStyle: AppTextStyle.boldStyle(
                            size: 16,
                            color: AppColor.black300,
                          ),
                          child: Obx(
                            () => TextBoxCustom(
                              controller: controller.cPasswordController,
                              placeholder: "Confirm password",
                              errorText: controller.cPasswordError.value.isEmpty
                                  ? null
                                  : controller.cPasswordError.value,
                              onChange: (value) {
                                if (value.isNotEmpty &&
                                    controller
                                        .cPasswordError.value.isNotEmpty) {
                                  controller.cPasswordError.value = "";
                                }
                              },
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey.withOpacity(0.25),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    action: [
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
                      Obx(
                        () => controller.isProcess.value
                            ? CustomCircularIndicator.indicator(
                                color: AppColor.primary,
                                color1: Colors.white.withOpacity(0.25),
                              )
                            : Button(
                                style: ButtonStyle(
                                  backgroundColor:
                                      WidgetStateProperty.resolveWith((states) {
                                    if (states.isHovered) {
                                      return AppColor.btnGreenColor
                                          .withOpacity(0.5);
                                    }
                                    return AppColor.btnGreenColor;
                                  }),
                                ),
                                child: Text(
                                  'Reset password',
                                  style: AppTextStyle.mediumStyle(
                                    color: AppColor.white,
                                    size: 15,
                                  ),
                                ),
                                onPressed: () {
                                  controller.checkValidation(ctx: context);
                                },
                              ),
                      ),
                    ],
                  );
                },
              ),
              const Gap(10),
              Button(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.resolveWith((states) {
                    if (states.isHovered) {
                      return AppColor.btnGreenColor.withOpacity(0.5);
                    }
                    return AppColor.btnGreenColor;
                  }),
                ),
                child: Text(
                  'Reset email',
                  style: AppTextStyle.mediumStyle(
                    color: AppColor.white,
                    size: 15,
                  ),
                ),
                onPressed: () {
                  controller.showBtnDialog(
                    ctx: context,
                    title: "Reset email",
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InfoLabel(
                          label: "Email address",
                          labelStyle: AppTextStyle.boldStyle(
                            size: 16,
                            color: AppColor.black300,
                          ),
                          child: Obx(
                            () => TextBoxCustom(
                              controller: controller.emailController,
                              placeholder: "Email address",
                              errorText: controller.emailError.value.isEmpty
                                  ? null
                                  : controller.emailError.value,
                              onChange: (value) {
                                if (value.isNotEmpty &&
                                    controller.emailError.value.isNotEmpty) {
                                  controller.emailError.value = "";
                                }
                              },
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey.withOpacity(0.25),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    action: [
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
                      Obx(
                        () => controller.isProcess.value
                            ? CustomCircularIndicator.indicator(
                                color: AppColor.primary,
                                color1: Colors.white.withOpacity(0.25),
                              )
                            : Button(
                                style: ButtonStyle(
                                  backgroundColor:
                                      WidgetStateProperty.resolveWith((states) {
                                    if (states.isHovered) {
                                      return AppColor.btnGreenColor
                                          .withOpacity(0.5);
                                    }
                                    return AppColor.btnGreenColor;
                                  }),
                                ),
                                child: Text(
                                  'Reset email',
                                  style: AppTextStyle.mediumStyle(
                                    color: AppColor.white,
                                    size: 15,
                                  ),
                                ),
                                onPressed: () {
                                  controller.checkValidationResetEmail(
                                      ctx: context);
                                },
                              ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
