import 'package:flutter/material.dart' show Material;

import 'package:pro_deals_admin/utils/imports.dart';

class Login extends GetView<LoginController> {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    return GetBuilder<LoginController>(
      init: LoginController(),
      builder: (loginController) => NavigationView(
        content: SizedBox(
          height: h,
          width: w,
          child: Stack(
            children: [
              Positioned(
                child: SvgPicture.asset('assets/images/svg/Arrow1.svg'),
              ),
              Positioned(
                right: 0,
                child: SvgPicture.asset('assets/images/svg/Ellipse2.svg'),
              ),
              Positioned(
                bottom: 0,
                child: SvgPicture.asset('assets/images/svg/Polygon1.svg'),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: SvgPicture.asset('assets/images/svg/Ellipse1.svg'),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 60, vertical: 50),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: h,
                        width: w! / 2,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomLeft: Radius.circular(20)),
                          color: AppColor.primary,
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              top: 80,
                              left: 30,
                              child:
                                  SvgPicture.asset('assets/images/svg/dot.svg'),
                            ),
                            Positioned(
                              top: 0,
                              left: 200,
                              child:
                                  SvgPicture.asset('assets/images/svg/r1.svg'),
                            ),
                            Positioned(
                              top: 0,
                              left: 280,
                              child:
                                  SvgPicture.asset('assets/images/svg/r3.svg'),
                            ),
                            Positioned(
                              top: -10,
                              left: 260,
                              child:
                                  SvgPicture.asset('assets/images/svg/r2.svg'),
                            ),
                            Positioned(
                              top: 120,
                              right: 180,
                              child:
                                  SvgPicture.asset('assets/images/svg/c1.svg'),
                            ),
                            Positioned(
                              bottom: 40,
                              left: 60,
                              child: SvgPicture.asset(
                                  'assets/images/svg/dot2.svg'),
                            ),
                            Positioned(
                              bottom: 110,
                              left: 70,
                              child:
                                  SvgPicture.asset('assets/images/svg/c2.svg'),
                            ),
                            Positioned(
                              bottom: 70,
                              left: 200,
                              child: SvgPicture.asset(
                                  'assets/images/svg/cros.svg'),
                            ),
                            Positioned(
                              bottom: -15,
                              right: 100,
                              child:
                                  SvgPicture.asset('assets/images/svg/c4.svg'),
                            ),
                            Positioned(
                              bottom: 50,
                              right: 120,
                              child:
                                  SvgPicture.asset('assets/images/svg/c3.svg'),
                            ),
                            Center(
                              child: SvgPicture.asset(
                                  'assets/icons/Pro_deals.svg'),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Material(
                        child: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20),
                                bottomRight: Radius.circular(20)),
                            color: AppColor.white,
                          ),
                          child: PageView(
                            controller: loginController.p,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Obx(
                                        () => GestureDetector(
                                          onTap: () {
                                            if (controller.loginType.value ==
                                                0) {
                                              return;
                                            }
                                            controller.loginType.value = 0;
                                          },
                                          child: AnimatedContainer(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 15,
                                              vertical: 8,
                                            ),
                                            duration: const Duration(
                                                milliseconds: 500),
                                            decoration: BoxDecoration(
                                              color:
                                                  controller.loginType.value ==
                                                          0
                                                      ? AppColor.primary
                                                      : Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            child: Text(
                                              "Admin login",
                                              style: GoogleFonts.poppins(
                                                fontSize: 20,
                                                color: controller
                                                            .loginType.value ==
                                                        0
                                                    ? AppColor.white
                                                    : AppColor.black300,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const Gap(15),
                                      Obx(
                                        () => GestureDetector(
                                          onTap: () {
                                            if (controller.loginType.value ==
                                                1) {
                                              return;
                                            }
                                            controller.loginType.value = 1;
                                          },
                                          child: AnimatedContainer(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 15,
                                              vertical: 8,
                                            ),
                                            duration: const Duration(
                                                milliseconds: 500),
                                            decoration: BoxDecoration(
                                              color:
                                                  controller.loginType.value ==
                                                          1
                                                      ? AppColor.primary
                                                      : Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            child: Text(
                                              "Staff login",
                                              style: GoogleFonts.poppins(
                                                fontSize: 20,
                                                color: controller
                                                            .loginType.value ==
                                                        1
                                                    ? AppColor.white
                                                    : AppColor.black300,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Gap(15),
                                  Container(
                                    height: h! / 3 / 1.5,
                                    width: w! / 6 / 1.5,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(w! / (16 * 3)),
                                      color: AppColor.white,
                                      boxShadow: [
                                        BoxShadow(
                                            color: AppColor.black300
                                                .withOpacity(0.4),
                                            offset: const Offset(2, 3),
                                            blurRadius: 5),
                                      ],
                                    ),
                                    padding: const EdgeInsets.all(20),
                                    child: SvgPicture.asset(logo_svg),
                                  ),
                                  const Gap(20),
                                  Text(
                                    'Hello ! Welcome back',
                                    style: GoogleFonts.poppins(
                                      fontSize: 22,
                                      color: AppColor.black300,
                                    ),
                                  ),
                                  const Gap(20),
                                  SizedBox(
                                    width: (w! / 3.4),
                                    child: Obx(
                                      () => InfoLabel(
                                        label:
                                            loginController.loginType.value == 0
                                                ? 'Email'
                                                : 'Staff id',
                                        labelStyle: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: AppColor.black300,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            TextBox(
                                              highlightColor: AppColor.primary,
                                              onChanged: (value) {
                                                if (value.isNotEmpty &&
                                                    loginController
                                                            .emailError.value !=
                                                        null) {
                                                  loginController
                                                      .emailError.value = null;
                                                }
                                              },
                                              placeholderStyle: const TextStyle(
                                                color: AppColor.gray,
                                                fontSize: 14,
                                              ),
                                              decoration:
                                                  WidgetStateProperty.all(
                                                BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                              ),
                                              placeholder: loginController
                                                          .loginType.value ==
                                                      0
                                                  ? 'Email'
                                                  : 'Staff id',
                                              prefix: Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 10.0,
                                                  top: 4,
                                                  bottom: 4,
                                                ),
                                                child: SvgPicture.asset(
                                                    'assets/icons/mail.svg'),
                                              ),
                                              cursorColor: AppColor.primary,
                                              style: GoogleFonts.poppins(
                                                fontSize: 16,
                                                color: AppColor.gray,
                                              ),
                                              controller: loginController.email,
                                              expands: false,
                                            ),
                                            loginController.emailError.value ==
                                                    null
                                                ? const Gap(0)
                                                : Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 8.0),
                                                    child: Obx(
                                                      () => Text(
                                                        loginController
                                                                .emailError
                                                                .value ??
                                                            "",
                                                        style: TextStyle(
                                                          color: Colors.red,
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Gap(20),
                                  SizedBox(
                                    width: (w! / 3.4),
                                    child: InfoLabel(
                                      label: 'Password',
                                      labelStyle: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: AppColor.black300,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextBox(
                                            highlightColor: AppColor.primary,
                                            onChanged: (value) {
                                              if (value.isNotEmpty &&
                                                  loginController
                                                          .passError.value !=
                                                      null) {
                                                loginController
                                                    .passError.value = null;
                                              }
                                            },
                                            placeholderStyle: const TextStyle(
                                              color: AppColor.gray,
                                              fontSize: 14,
                                            ),
                                            decoration: WidgetStateProperty.all(
                                              BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                            cursorColor: AppColor.primary,
                                            placeholder: 'Password',
                                            obscureText: true,
                                            prefix: Padding(
                                              padding: const EdgeInsets.only(
                                                left: 10.0,
                                                top: 4,
                                                bottom: 4,
                                              ),
                                              child: SvgPicture.asset(
                                                  'assets/icons/password.svg'),
                                            ),
                                            style: GoogleFonts.poppins(
                                              fontSize: 16,
                                              color: AppColor.gray,
                                            ),
                                            controller: loginController.pass,
                                            expands: false,
                                          ),
                                          Obx(
                                            () => loginController
                                                        .passError.value ==
                                                    null
                                                ? const Gap(0)
                                                : Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 8.0),
                                                    child: Text(
                                                      loginController.passError
                                                              .value ??
                                                          "",
                                                      style: TextStyle(
                                                        color: Colors.red,
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const Gap(50),
                                  Obx(
                                    () => loginController.isProcess.value
                                        ? CustomCircularIndicator.indicator(
                                            color: AppColor.primary,
                                            color1:
                                                Colors.white.withOpacity(0.25),
                                          )
                                        : GestureDetector(
                                            onTap: () {
                                              loginController.emailError.value =
                                                  null;
                                              loginController.passError.value =
                                                  null;
                                              if (loginController
                                                      .email.text.isEmpty ||
                                                  loginController
                                                      .pass.text.isEmpty) {
                                                if (loginController
                                                    .email.text.isEmpty) {
                                                  if (loginController
                                                          .loginType.value ==
                                                      0) {
                                                    loginController
                                                            .emailError.value =
                                                        "Please enter email";
                                                  } else {
                                                    loginController
                                                            .emailError.value =
                                                        "Please enter staff id";
                                                  }
                                                }
                                                if (loginController
                                                    .pass.text.isEmpty) {
                                                  loginController
                                                          .passError.value =
                                                      "Please enter password";
                                                }
                                              } else if (!GetUtils.isEmail(
                                                      loginController
                                                          .email.text) &&
                                                  loginController
                                                          .loginType.value ==
                                                      0) {
                                                loginController
                                                        .emailError.value =
                                                    "Please enter valid email";
                                              } else if (loginController
                                                      .pass.text
                                                      .trim()
                                                      .length <
                                                  6) {
                                                loginController
                                                        .passError.value =
                                                    "Please enter 6 digit password";
                                              } else {
                                                loginController
                                                    .isProcess.value = true;
                                                if (controller
                                                        .loginType.value ==
                                                    0) {
                                                  loginController.adminLogin(
                                                      ctx: context);
                                                } else {
                                                  loginController.staffLogin(
                                                      ctx: context);
                                                }
                                              }
                                            },
                                            child: Container(
                                              width: (w! / 3.4),
                                              height: 50,
                                              decoration: BoxDecoration(
                                                color: AppColor.primary,
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                              alignment: Alignment.center,
                                              child: Text(
                                                'Login',
                                                style: GoogleFonts.roboto(
                                                    color: AppColor.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: h! / 3 / 1.5,
                                    width: w! / 6 / 1.5,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(w! / (16 * 3)),
                                      color: AppColor.white,
                                      boxShadow: [
                                        BoxShadow(
                                            color: AppColor.black300
                                                .withOpacity(0.4),
                                            offset: const Offset(2, 3),
                                            blurRadius: 5),
                                      ],
                                    ),
                                    padding: const EdgeInsets.all(20),
                                    child: SvgPicture.asset(logo_svg),
                                  ),
                                  const Gap(20),
                                  Text(
                                    'Hello ! Welcome back',
                                    style: GoogleFonts.poppins(
                                      fontSize: 22,
                                      color: AppColor.black300,
                                    ),
                                  ),
                                  const Gap(20),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "assets/icons/enter_otp.png",
                                        height: 33,
                                        width: 33,
                                        fit: BoxFit.cover,
                                      ),
                                      const Gap(10),
                                      Text(
                                        "Enter your OTP",
                                        style: GoogleFonts.poppins(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: AppColor.black300,
                                        ),
                                      )
                                    ],
                                  ),
                                  const Gap(20),
                                  OtpPinField(
                                    maxLength: 6,
                                    onSubmit: (text) {},
                                    onChange: (text) {
                                      loginController.otp.text = text;
                                    },
                                    autoFocus: false,
                                    fieldHeight: 50,
                                    fieldWidth: 50,
                                    otpPinFieldInputType:
                                        OtpPinFieldInputType.custom,
                                    otpPinFieldDecoration: OtpPinFieldDecoration
                                        .roundedPinBoxDecoration,
                                  ),
                                  Container(
                                    alignment: Alignment.centerRight,
                                    width: (w! / 3.4),
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        loginController.resendOtp(ctx: context);
                                      },
                                      child: Text(
                                        "Resend OTP",
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Gap(50),
                                  Obx(
                                    () => loginController.isProcess.value
                                        ? CustomCircularIndicator.indicator(
                                            color: AppColor.primary,
                                            color1:
                                                Colors.white.withOpacity(0.25),
                                          )
                                        : GestureDetector(
                                            onTap: () {
                                              if (loginController
                                                  .otp.text.isEmpty) {
                                                GFToast.showToast(
                                                  'Please enter OTP.',
                                                  context,
                                                  toastPosition:
                                                      GFToastPosition.BOTTOM,
                                                );
                                              } else {
                                                loginController
                                                    .isProcess.value = true;
                                                loginController.verifyOtp(
                                                    ctx: context);
                                              }
                                            },
                                            child: Container(
                                              width: (w! / 3.4),
                                              height: 50,
                                              decoration: BoxDecoration(
                                                color: AppColor.primary,
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                              alignment: Alignment.center,
                                              child: Text(
                                                'Verify OTP',
                                                style: GoogleFonts.roboto(
                                                    color: AppColor.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
