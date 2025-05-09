export 'dart:convert';
export 'dart:io';
export 'dart:async';
export 'dart:typed_data';

/// utils
export 'package:pro_deals_admin/utils/variables.dart';
export 'package:pro_deals_admin/utils/color.dart';
export 'package:pro_deals_admin/utils/imports.dart';
export 'package:pro_deals_admin/utils/constant.dart';
export 'package:pro_deals_admin/utils/apis.dart';
export 'package:pro_deals_admin/utils/app_textstyle.dart';
export 'package:pro_deals_admin/utils/app_icons.dart';

/// widgets
export 'package:pro_deals_admin/widgets/show_toast.dart';
export 'package:pro_deals_admin/widgets/indicator.dart';
export 'package:pro_deals_admin/widgets/textbox.dart';
export 'package:pro_deals_admin/widgets/theme_data.dart';
export 'package:pro_deals_admin/widgets/custom_time_picker.dart';

/// extensions
export 'package:pro_deals_admin/extension/extension.dart';

/// services
export 'package:pro_deals_admin/services/data_storage_service.dart';
export 'package:pro_deals_admin/services/api_service.dart';

/// screens
export 'package:pro_deals_admin/screens/ManageInvoice.dart';
export 'package:pro_deals_admin/screens/order/ManageOrders.dart';
export 'package:pro_deals_admin/screens/dashboard.dart';

/// packages
export 'package:fluent_ui/fluent_ui.dart'
    hide StringExtension, TimePicker, DatePicker;
export 'package:google_fonts/google_fonts.dart';
export 'package:gap/gap.dart';
export 'package:get/get.dart' hide MultipartFile, Response, HeaderValue;
export 'package:get_storage/get_storage.dart';
export 'package:fluttertoast/fluttertoast.dart' hide ToastStateFulState;
export 'package:flutter_svg/svg.dart';
export 'package:http/http.dart';
export 'package:flutter_localizations/flutter_localizations.dart';
export 'package:getwidget/getwidget.dart';
export 'package:otp_pin_field/otp_pin_field.dart';
export 'package:file_picker/file_picker.dart';
export 'package:intl/intl.dart' hide TextDirection;

/// intro screen
export 'package:pro_deals_admin/screens/admin_panel_screen/panel.dart';
export 'package:pro_deals_admin/controllers/admin_panel_screen/panel_controller.dart';

/// intro screen
export 'package:pro_deals_admin/screens/intro_screen/starting_page.dart';
export 'package:pro_deals_admin/controllers/intro_screen/intro_controller.dart';

/// login screen
export 'package:pro_deals_admin/screens/auth_screen/login.dart';
export 'package:pro_deals_admin/controllers/auth_screen/login_controller.dart';

/// manage user screen
export 'package:pro_deals_admin/screens/manage_user/ManageUsers.dart';
export 'package:pro_deals_admin/modal/user_model.dart';
export 'package:pro_deals_admin/controllers/manage_user/manage_user_controller.dart';

/// manage business screen(business request and entire business crud)
export 'package:pro_deals_admin/screens/business/ManageBusinessRequest.dart';
export 'package:pro_deals_admin/modal/reqbusiness.dart';
export 'package:pro_deals_admin/controllers/manage_business/manage_business_request_controller.dart';

// crud
export 'package:pro_deals_admin/modal/business.dart';
export 'package:pro_deals_admin/screens/business/ManageBusiness.dart';
export 'package:pro_deals_admin/controllers/manage_business/manage_business_controller.dart';
export 'package:pro_deals_admin/screens/business/add_business.dart';
export 'package:pro_deals_admin/controllers/manage_business/add_business_controller.dart';
export 'package:pro_deals_admin/screens/business/update_business.dart';
export 'package:pro_deals_admin/controllers/manage_business/update_business_controller.dart';
export 'package:pro_deals_admin/screens/business/view_business.dart';
export 'package:pro_deals_admin/controllers/manage_business/view_business_controller.dart';
export 'package:pro_deals_admin/modal/dashboard_model.dart';

/// manage notification screen
export 'package:pro_deals_admin/screens/manage_notification/ManageNotification.dart';
export 'package:pro_deals_admin/controllers/manage_notification/manage_notification_controller.dart';
export 'package:pro_deals_admin/modal/notification_list_res.dart';
export 'package:pro_deals_admin/screens/manage_notification/create_notification.dart';
export 'package:pro_deals_admin/controllers/manage_notification/create_notification_controller.dart';

/// manage banner screen
export 'package:pro_deals_admin/screens/manage_banner/ManageBanner.dart';
export 'package:pro_deals_admin/controllers/manage_banner/banner_controller.dart';
export 'package:pro_deals_admin/modal/banner_model.dart';
export 'package:pro_deals_admin/screens/manage_banner/ViewBanner.dart';
export 'package:pro_deals_admin/controllers/manage_banner/view_banner_controller.dart';
export 'package:pro_deals_admin/screens/manage_banner/AddUpdateBanner.dart';
export 'package:pro_deals_admin/controllers/manage_banner/add_update_banner.dart';

/// manage membership plans screen
export 'package:pro_deals_admin/screens/plans_manage/ManageMembershipPlans.dart';
export 'package:pro_deals_admin/modal/membership_plans.dart';
export 'package:pro_deals_admin/controllers/manage_plan/manage_membership_plans_request.dart';
export 'package:pro_deals_admin/screens/plans_manage/ViewPlan.dart';
export 'package:pro_deals_admin/controllers/manage_plan/view_plan_details.dart';
export 'package:pro_deals_admin/screens/plans_manage/AddUpdatePlan.dart';
export 'package:pro_deals_admin/controllers/manage_plan/add_update_plan.dart';

/// manage cms pages plans screen
export 'package:pro_deals_admin/screens/manage_cms/ManageCMS.dart';
export 'package:pro_deals_admin/controllers/manage_cms/manage_cms_controller.dart';
export 'package:pro_deals_admin/modal/manage_cms.dart';

/// manage offer&deals screen
export 'package:pro_deals_admin/screens/manage_offers/Offers&Deals.dart';
export 'package:pro_deals_admin/controllers/manage_offers/offer_deals_controller.dart';
export 'package:pro_deals_admin/modal/offer_list_model.dart';

/// manage earning
export 'package:pro_deals_admin/screens/manage_earning/ManageEarning.dart';

/// settings screen
export 'package:pro_deals_admin/screens/settings/Setting.dart';
export 'package:pro_deals_admin/controllers/settings/settings_controller.dart';

/// manage coupons screen
export 'package:pro_deals_admin/screens/manage_coupons/ManageCoupons.dart';
export 'package:pro_deals_admin/controllers/manage_coupons/manage_coupon_controller.dart';
export 'package:pro_deals_admin/modal/coupons_model.dart';

/// staff screens
export 'package:pro_deals_admin/screens/staff_screens/staff_panel.dart';
export 'package:pro_deals_admin/controllers/staff_controller/staff_panel_controller.dart';

/// manage city screens
export 'package:pro_deals_admin/screens/staff_screens/manage_city.dart';
export 'package:pro_deals_admin/controllers/staff_controller/manage_city_controller.dart';
export 'package:pro_deals_admin/modal/staff_screen_models/city.dart';

/// manage category screens
export 'package:pro_deals_admin/screens/staff_screens/manage_category.dart';
export 'package:pro_deals_admin/controllers/staff_controller/manage_category_controller.dart';
export 'package:pro_deals_admin/modal/staff_screen_models/category.dart';

/// manage food type screens
export 'package:pro_deals_admin/screens/staff_screens/manage_foodtype.dart';
export 'package:pro_deals_admin/controllers/staff_controller/manage_foodtype_controller.dart';
export 'package:pro_deals_admin/modal/staff_screen_models/foodtype.dart';

/// manage faq screens
export 'package:pro_deals_admin/screens/staff_screens/manage_faq.dart';
export 'package:pro_deals_admin/controllers/staff_controller/manage_faq_controller.dart';
export 'package:pro_deals_admin/modal/staff_screen_models/faq_model.dart';

/// order
export '../controllers/manage_order/manage_order_controller.dart';
