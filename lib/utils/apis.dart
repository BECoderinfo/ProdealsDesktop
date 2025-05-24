class Apis {
  static const Map<String, String> headersValue = {
    'Content-Type': 'application/json'
  };
  static const Duration timeout = Duration(minutes: 5);

  static const String serverAddress = "http://141.148.196.197:3001";

  // static const String serverAddress = "http://192.168.1.4:3001";

  /// authentication
  static Uri adminLogin = Uri.parse("$serverAddress/Admin/adminlogin");

  static Uri adminOTPVerify({required String email}) =>
      Uri.parse("$serverAddress/Admin/adminverify/$email");

  static Uri adminResendOTP({required String email}) =>
      Uri.parse("$serverAddress/Admin/adminresendOTP/$email");
  static Uri adminSecure = Uri.parse("$serverAddress/admin/sequre");
  static Uri adminResetEmail = Uri.parse("$serverAddress/admin/emailreset");
  static Uri adminResetPassword =
      Uri.parse("$serverAddress/admin/passwordreset");

  /// Manage users
  static Uri viewAllUser = Uri.parse("$serverAddress/users/alluser");

  static Uri deleteUser({required String uId}) =>
      Uri.parse("$serverAddress/users/delete/$uId");

  /// Manage business requests
  static Uri viewBusinessRequest =
      Uri.parse("$serverAddress/business/getAllRequest");

  static Uri rejectBusinessRequest({required String bId}) =>
      Uri.parse("$serverAddress/business/reject/$bId");

  static Uri acceptBusinessRequest({required String bId}) =>
      Uri.parse("$serverAddress/business/accept/$bId");

  /// Manage membership plans
  static Uri createMembershipPlan =
      Uri.parse("$serverAddress/memberplan/createplan");

  static Uri getAllMembershipPlan =
      Uri.parse("$serverAddress/memberplan/getallplan");

  static Uri updateMembershipPlan({required String pId}) =>
      Uri.parse("$serverAddress/memberplan/updateplan/$pId");

  static Uri deleteMembershipPlan({required String pId}) =>
      Uri.parse("$serverAddress/memberplan/deleteplan/$pId");

  static Uri toggleStatus({required String id}) =>
      Uri.parse("$serverAddress/memberplan/toggleStatus/$id");

  /// subscriptions
  static Uri getAllSubscriptions =
      Uri.parse("$serverAddress/subscription/getAll");

  /// Manage banner
  static Uri getAllBanner = Uri.parse("$serverAddress/banner/getAll");
  static Uri getPendingBanner = Uri.parse("$serverAddress/banner/pending");

  static Uri deleteBanner({required String bId}) =>
      Uri.parse("$serverAddress/banner/delete/$bId");

  static Uri updateBanner({required String bId}) =>
      Uri.parse("$serverAddress/banner/update/$bId");

  static Uri acceptBanner({required String bId}) =>
      Uri.parse("$serverAddress/banner/accept/$bId");

  static Uri addBanner = Uri.parse("$serverAddress/banner/add");

  /// Manage notification
  static Uri createNotification =
      Uri.parse("$serverAddress/notification/create");
  static Uri getAllNotification = Uri.parse("$serverAddress/notification");

  static Uri deleteNotification({required String nId}) =>
      Uri.parse("$serverAddress/notification/delete/$nId");

  /// Manage business
  static Uri getAllBusiness = Uri.parse("$serverAddress/business/getAll");
  static Uri createBusiness = Uri.parse("$serverAddress/business/create");

  static Uri mainStoreImageUpload({required String bId}) =>
      Uri.parse("$serverAddress/business/mainImage/$bId");

  static Uri storeImageUpload({required String bId}) =>
      Uri.parse("$serverAddress/business/storeImage/$bId");

  static Uri voterIdImageUpload({required String bId}) =>
      Uri.parse("$serverAddress/business/waterIdImage/$bId");

  static Uri gvtIdImageUpload({required String bId}) =>
      Uri.parse("$serverAddress/business/govermentIdImage/$bId");

  static Uri deleteImages({required String bId}) =>
      Uri.parse("$serverAddress/business/DeleteImage/$bId");

  static Uri updateBusiness({required String bId}) =>
      Uri.parse("$serverAddress/business/update/$bId");

  static Uri updateImages({required String bId}) =>
      Uri.parse("$serverAddress/business/updateImages/$bId");

  static Uri deleteBusiness({required String bId}) =>
      Uri.parse("$serverAddress/business/delete/$bId");

  static Uri adminAssignBusiness({required String uId}) =>
      Uri.parse("$serverAddress/business/assign/$uId");

  /// manage staff screen
  static Uri getAllStaff = Uri.parse("$serverAddress/staff/get");
  static Uri addStaff = Uri.parse("$serverAddress/staff/add");
  static Uri staffLogin = Uri.parse("$serverAddress/staff/login");
  static Uri secureStaff = Uri.parse("$serverAddress/staff/token");

  static Uri deleteStaff({required String sId}) =>
      Uri.parse("$serverAddress/staff/delete/$sId");

  static Uri updateStaff({required String uId}) =>
      Uri.parse("$serverAddress/staff/update/$uId");

  /// manage city screen
  static Uri getAllCity = Uri.parse("$serverAddress/city/get");
  static Uri addCity = Uri.parse("$serverAddress/city/create");

  static Uri updateCity({required String cId}) =>
      Uri.parse("$serverAddress/city/update/$cId");

  static Uri deleteCity({required String cId}) =>
      Uri.parse("$serverAddress/city/delete/$cId");

  /// manage food type screen
  static Uri getAllFoodType = Uri.parse("$serverAddress/foodtype/get");
  static Uri addFoodType = Uri.parse("$serverAddress/foodtype/create");

  static Uri updateFoodType({required String cId}) =>
      Uri.parse("$serverAddress/foodtype/update/$cId");

  static Uri deleteFoodType({required String cId}) =>
      Uri.parse("$serverAddress/foodtype/delete/$cId");

  /// manage category screen
  static Uri getAllCategory = Uri.parse("$serverAddress/category/getAll");
  static Uri addCategory = Uri.parse("$serverAddress/category/add");

  static Uri updateCategory({required String cId}) =>
      Uri.parse("$serverAddress/category/update/$cId");

  static Uri deleteCategory({required String cId}) =>
      Uri.parse("$serverAddress/category/delete/$cId");

  /// offers
  static Uri getAllOffer = Uri.parse("$serverAddress/offer/get");
  static Uri addOffer = Uri.parse("$serverAddress/offer/Create");

  static Uri updateOffer({required String oId}) =>
      Uri.parse("$serverAddress/offer/Update/$oId");

  static Uri manageOffer({required String oId}) =>
      Uri.parse("$serverAddress/offer/active/$oId");

  static Uri deleteOffer({required String oId}) =>
      Uri.parse("$serverAddress/offer/Delete/$oId");

  /// promo code & redeemed promo code
  static Uri createCode = Uri.parse("$serverAddress/promocode/Insert");
  static Uri getAllPromoCode = Uri.parse("$serverAddress/promocode/Getpromo");

  static Uri updatePromoCode({required String pId}) =>
      Uri.parse("$serverAddress/promocode/update/$pId");

  static Uri deletePromoCode({required String pId}) =>
      Uri.parse("$serverAddress/promocode/delete/$pId");

  static Uri getAllRedeemedPromoCode =
      Uri.parse("$serverAddress/promocode/Getreedmed");

  /// faq questions
  static Uri getAllQuestion = Uri.parse("$serverAddress/support/quotations");
  static Uri answerQuestion = Uri.parse("$serverAddress/support/answer");
  static Uri askQuestion = Uri.parse("$serverAddress/support/quotation");

  static Uri deleteQuestion({required String aId}) =>
      Uri.parse("$serverAddress/support/quotation/$aId");

  /// dashboard
  static Uri getDashBoardData = Uri.parse("$serverAddress/business/dashboard");

  static Uri getSalesData({required String title}) =>
      Uri.parse("$serverAddress/hestory/salesData?key=$title");

  /// order
  static Uri getAllOrder = Uri.parse("$serverAddress/order/all");

  static Uri getOrderById({required String orderId}) =>
      Uri.parse("$serverAddress/order/$orderId");

  static Uri deleteOrder({required String oId}) =>
      Uri.parse("$serverAddress/order/delete/$oId");
}
