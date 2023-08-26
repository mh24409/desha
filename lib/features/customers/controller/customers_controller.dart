import 'package:cosmo_care/features/app_control_feature/views/screens/main_control_screen.dart';
import 'package:cosmo_care/features/customers/model/create_customer_modeling.dart';
import 'package:cosmo_care/features/customers/model/customer_type_model.dart';
import 'package:cosmo_care/features/customers/model/payment_terms_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/Constants/api_constants.dart';
import '../../../core/helper/api_helper.dart';
import '../model/city_model.dart';
import '../model/customer_model.dart';
import '../model/government_model.dart';
import 'package:cosmo_care/core/shared/global_variables.dart' as global;

class CustomersController {
  static List<String> daysData = [
    "Saturday",
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday"
  ];
  static List<String> timeList = [
    '1 ص',
    '2 ص',
    '3 ص',
    '4 ص',
    '5 ص',
    '6 ص',
    '7 ص',
    '8 ص',
    '9 ص',
    '10 ص',
    '11 ص',
    '12 ص',
    '1 م',
    '2 م',
    '3 م',
    '4 م',
    '5 م',
    '6 م',
    '7 م',
    '8 م',
    '9 م',
    '10 م',
    '11 م',
    '12 م',
  ];
  static Future<List<CustomerModel>> getAllCustomers() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String userToken = preferences.getString("token")!;
    List<CustomerModel> customers = [];
    Map<String, String> headers = {"Authorization": "Bearer $userToken"};
    try {
      final response = await ApiHelper().get(
          url: ApiConstants.baseUrl + ApiConstants.getCustomersEndPoint,
          headers: headers);
      for (var customer in response) {
        customers.add(CustomerModel.fromJson(customer));
      }
      return customers;
    } catch (e) {
      Get.snackbar("Connection Error", "Please check your internet connection",
          backgroundColor: Colors.red);
      return customers;
    }
  }

  static Future<List<GovernmentModel>> getAllGovernments() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String userToken = preferences.getString("token")!;
    List<GovernmentModel> governments = [];
    Map<String, String> headers = {"Authorization": "Bearer $userToken"};
    try {
      final response = await ApiHelper().get(
          url: ApiConstants.baseUrl +
              ApiConstants.getCustomerGovernmentsEndPoint,
          headers: headers);

      for (var gov in response) {
        governments.add(GovernmentModel.fromJson(gov));
      }
      return governments;
    } catch (e) {
      Get.snackbar("error", "Something went wrong please try agin",
          backgroundColor: Colors.red);
      return governments;
    }
  }

  static Future<List<CustomerTypeModel>> getAllCustomerTypes() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String userToken = preferences.getString("token")!;
    List<CustomerTypeModel> customerTypes = [];
    Map<String, String> headers = {"Authorization": "Bearer $userToken"};
    try {
      final response = await ApiHelper().get(
          url: ApiConstants.baseUrl + ApiConstants.getCustomerTypesEndPoint,
          headers: headers);
      for (var type in response) {
        customerTypes.add(CustomerTypeModel.fromJson(type));
      }
      return customerTypes;
    } catch (e) {
      Get.snackbar("error", "Something went wrong please try agin",
          backgroundColor: Colors.red);
      return customerTypes;
    }
  }

  static Future<List<PaymentTermsModel>> getAllCustomersPaymentTerms() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String userToken = preferences.getString("token")!;
    List<PaymentTermsModel> customerPaymentTerms = [];
    Map<String, String> headers = {"Authorization": "Bearer $userToken"};
    try {
      final response = await ApiHelper().get(
          url: ApiConstants.baseUrl + ApiConstants.getCustomerPaymentsEndPoint,
          headers: headers);
      for (var payment in response) {
        customerPaymentTerms.add(PaymentTermsModel.fromJson(payment));
      }
      return customerPaymentTerms;
    } catch (e) {
      Get.snackbar("Connection Error", "Please check your internet connection",
          backgroundColor: Colors.red);
      return customerPaymentTerms;
    }
  }

  static Future<List<CityModel>> getAllCustomerCities(
      {required int govId}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String userToken = preferences.getString("token")!;
    List<CityModel> cities = [];
    Map<String, String> headers = {"Authorization": "Bearer $userToken"};
    try {
      final response = await ApiHelper().get(
          url: "${ApiConstants.baseUrl}/governorates/$govId/cities",
          headers: headers);
      for (var city in response) {
        cities.add(CityModel.fromJson(city));
      }
      return cities;
    } catch (e) {
      Get.snackbar("error", "Something went wrong please try agin",
          backgroundColor: Colors.red);
      return cities;
    }
  }

  static Future<void> createCustomer(
      {required CustomerData customerData,
      required ResponsibleData responsibleData,
      required OwnerData ownerData}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String userToken = preferences.getString("token")!;
    Map<String, String> headers = {
      "Authorization": "token $userToken",
      "Content-Type": "text/html",
    };
    Map<String, dynamic> body = {
      "title": customerData.name,
      "customer_type": customerData.customerTypeId,
      "address": customerData.address,
      "distinctive_address": customerData.distinctiveAddress,
      "government": customerData.governmentId,
      "city": customerData.cityId,
      "phone": customerData.phoneNumber,
      "lat": global.currentUserLat,
      "lng": global.currentUserLong,
      "website": customerData.website,
      "email": customerData.email,
      "term_duration": customerData.paymentTermId,
      "owners": [
        {
          "name": ownerData.name,
          "phone": ownerData.phoneNumber,
          "email": ownerData.email,
          "work_start_at": ownerData.workStartTime,
          "work_end_at": ownerData.workEndTime,
          "work_start_day": ownerData.workStartDay,
          "work_end_day": ownerData.workEndDay,
          "government": customerData.governmentId,
          "city": customerData.cityId
        }
      ],
      "responsiblies": [
        {
          "name": responsibleData.name,
          "phone": responsibleData.phoneNumber,
          "email": responsibleData.email,
          "work_start_at": responsibleData.workStartTime,
          "work_end_at": responsibleData.workEndTime,
          "work_start_day": responsibleData.workStartDay,
          "work_end_day": responsibleData.workEndDay,
          "government": customerData.governmentId,
          "city": customerData.cityId
        },
      ],
    };
    try {
      await ApiHelper().post(
          url: ApiConstants.baseUrl + ApiConstants.createCustomerEndPoint,
          headers: headers,
          body: body);
      Get.snackbar("Create Customer", "Create New Customer Success");
      Get.offAll(()=> const MainControlScreen());
    } catch (e) {
      Get.snackbar("error", "Something went wrong please try agin",
          backgroundColor: Colors.red);
    }
  }
}
