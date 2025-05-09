import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pro_deals_admin/utils/color.dart';
import 'package:pro_deals_admin/utils/constant.dart';

class start_page extends StatefulWidget {
  const start_page({super.key});

  @override
  State<start_page> createState() => _start_pageState();
}

class _start_pageState extends State<start_page> {
  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 4), () {
      Get.offNamed('/login');
    });
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
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
            boxShadow: [
              BoxShadow(
                  color: Colors.black87, offset: Offset(0, 4), blurRadius: 2),
            ],
          ),
          padding: EdgeInsets.all(40),
          child: SvgPicture.asset(logo_svg),
        ),
      ),
    );
  }
}
