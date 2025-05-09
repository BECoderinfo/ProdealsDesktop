import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pro_deals_admin/utils/constant.dart';

import '../utils/color.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: h,
        width: w,
        margin: EdgeInsets.all(40),
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: h,
                width: w! / 2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20)),
                  color: AppColor.primary,
                ),
                alignment: Alignment.center,
                child: Container(
                  height: h! / 3,
                  width: w! / 6,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(w! / (16 * 1.5)),
                    color: AppColor.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black87,
                          offset: Offset(0, 4),
                          blurRadius: 2),
                    ],
                  ),
                  padding: EdgeInsets.all(20),
                  child: SvgPicture.asset(logo_svg),
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                  color: AppColor.black300,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(prodeals),
                    const Gap(50),
                    Container(
                      width: (w! / 3.4),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Enter phone Number',
                          label: Container(
                            height: 30,
                            width: 30,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: AppColor.white, shape: BoxShape.circle),
                            child: const Icon(
                              Icons.call,
                              size: 20,
                            ),
                          ),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const Gap(30),
                    Container(
                      width: (w! / 3.4),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Password',
                          label: Container(
                            height: 30,
                            width: 30,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: AppColor.white, shape: BoxShape.circle),
                            child: const Icon(
                              Icons.lock,
                              size: 20,
                            ),
                          ),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const Gap(50),
                    Container(
                      width: (w! / 3.4),
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppColor.primary,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Login',
                        style: GoogleFonts.roboto(
                            color: AppColor.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
