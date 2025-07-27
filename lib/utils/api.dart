class Api {
  static const String baseUrl =
      "https://easyworldonline.ableinnovation.com.np/api/vendor";
  static const String registerUrl = "$baseUrl/register";
  static const String loginUrl = "$baseUrl/login";
  static const String getProductsUrl = "$baseUrl/products";
  static const String ordersUrl = "$baseUrl/orders";
  static const String editProfileUrl = "$baseUrl/profile";
  static const String reviewsUrl = "$baseUrl/reviews/all";
  static const String forgotPasswordRequestUrl =
      "$baseUrl/forgot-password/request";
  static const String forgotPassOtpVerifyUrl =
      "$baseUrl/forgot-password/verify-otp";
  static const String resetPasswordUrl = "$baseUrl/forgot-password/reset";
  static const String googleSignInUrl = "$baseUrl/auth/google/login";
  static const String replyReviewUrl = "$baseUrl/reviews";
  static const String deleteReviewUrl = "$baseUrl/review";
  static const String deleteReplyUrl = "$baseUrl/reply";
  static const String bankDetailsUrl = "$baseUrl/bank-details";
  static const String vendorEarningsUrl = "$baseUrl/vendor-earnings";
  static const String payoutsUrl = "$baseUrl/payouts";
  static const String payoutsRequestUrl = "$baseUrl/payouts/request";
}
