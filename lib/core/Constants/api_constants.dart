class ApiConstants {
  // static const String baseUrl = 'https://cosmocareprod-training.technotown.technology';
  static const String baseUrl = 'https://cosmocare.technotown.technology';
  // static const String baseUrl = 'http://192.168.202.251:8069';
  static const String resetPasswordURL = '$baseUrl/web/reset_password';
  static const String loginEndPoint = '/login';
  static const String getCustomerTypesEndPoint = '/types';
  static const String getCustomersEndPoint = '/customers';
  static const String getCustomerPaymentsEndPoint = '/invoices/payment-options';
  static const String getCustomerGovernmentsEndPoint = '/governorates';
  static const String createCustomerEndPoint = '/customers/create';
  static const String categoriesEndPoint = '/products_categorized';
  static const String saleZonesEndPoint = '/sales-unit';
  static const String createSaleOrderEndPoint = '/invoices/invoice';
  static const String createSaleOrderAndLineEndPoint =
      '/invoices/create_invoice';
  static const String trackChecking = '/tracking/check';
  static const String visitCheckInEndPoint = '/visit/check_in';
  static const String visitCheckOutEndPoint = '/visit/check_out';
  static const String visitStatesEndPoint = '/visit/states';
  static const String userOrdersEndPoint = '/user/orders';
  static const String changePasswordEndPoint = '/change_password';
  static const String editProfileEndPoint = '/mob/edit_profile';
  static const String getProfileImageEndPoint = '/mob/get_user_prof_image';
}
