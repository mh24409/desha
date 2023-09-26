import 'package:cosmo_care/features/app_control_feature/views/screens/main_control_screen.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/Constants/api_constants.dart';
import '../../../core/helper/api_helper.dart';
import '../model/customer_products_model.dart';

class OrderController {
  static final GeolocatorPlatform _geolocator = GeolocatorPlatform.instance;

  static bool inSaveZoneToCreateOrder(
      {required customerLat,
      required double customerLong,
      required double currentLat,
      required double currentLong}) {
    double distance = _geolocator.distanceBetween(
        customerLat, customerLong, currentLat, currentLong);
    if (distance > 500) {
      return false;
    } else {
      return true;
    }
  }

  static Future<int> createSaleOrder({required int customerId}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String userToken = preferences.getString("token")!;
    Map<String, String> header = {
      'Authorization': 'token $userToken',
      "Content-Type": "text/html",
    };
    Map<String, int> body = {'customer_id': customerId};
    try {
      final response = await ApiHelper().post(
        url: ApiConstants.baseUrl + ApiConstants.createSaleOrderEndPoint,
        headers: header,
        body: body,
      );
      if (response['status'] == 200) {
        return response["invoiceid"];
      } else {
        Get.snackbar(
          "Something went wrong. please try agin".tr,
          "",
          backgroundColor: Colors.red,
        );
        return 0;
      }
    } catch (e) {
      debugPrint("Error: ${e.toString()}");
      Get.snackbar(
        "Something went wrong. please try agin".tr,
        "",
        backgroundColor: Colors.red,
      );
      return 0;
    }
  }

  static Future<List<CustomerProductsModel>> getCustomerOffers(
      {required int customerId}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String language = Get.locale?.languageCode ?? 'en';
    String userToken = preferences.getString("token")!;
    Map<String, String> header = {
      'Authorization': 'Bearer $userToken',
      "Content-Type": "text/html",
    };
    List<CustomerProductsModel> products = [];
    try {
      final response = await ApiHelper().get(
        url:
            "${ApiConstants.baseUrl}/invoices/product?customer_id=$customerId&lang=$language",
        headers: header,
      );
      for (var element in response) {
        products.add(CustomerProductsModel.fromJson(element));
      }
      return products;
    } catch (e) {
      Get.snackbar(
        "Something went wrong. please try agin".tr,
        "",
        backgroundColor: Colors.red,
      );
      return products;
    }
  }

  static Future<void> createSaleOrderLines(
      {required int invoiceId,
      required List<CustomerProductsModel> products}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String userToken = preferences.getString("token")!;
    Map<String, String> header = {
      'Authorization': 'token $userToken',
      "Content-Type": "text/html",
    };
    List<Map<String, dynamic>> invoiceItems = products.map((selectedProduct) {
      return {
        "product_id": selectedProduct.productId,
        "count": int.parse(selectedProduct.quantity)
      };
    }).toList();
    Map<String, dynamic> body = {"invoice_items": invoiceItems};
    try {
      final response = await ApiHelper().post(
        url: "${ApiConstants.baseUrl}/invoices/invoice/$invoiceId",
        headers: header,
        body: body,
      );
      if (response["status"] == 5000) {
        Get.snackbar(
          "Something went wrong. please try agin".tr,
          "",
          backgroundColor: Colors.red,
        );
      } else {
        Get.offAll(const MainControlScreen());
        Get.snackbar(
          "New Sale Order".tr,
          "Creating Success".tr,
          backgroundColor: Colors.green,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Internet connection".tr,
        "Please check your internet connection".tr,
        backgroundColor: Colors.red,
      );
    }
  }

  static Future<void> createSaleOrderandLines(
      {required int customerId,
      required List<CustomerProductsModel> products}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String userToken = preferences.getString("token")!;
    Map<String, String> header = {
      'Authorization': 'token $userToken',
      "Content-Type": "text/html",
    };
    List<Map<String, dynamic>> invoiceItems = products.map((selectedProduct) {
      return {
        "product_id": selectedProduct.productId,
        "count": int.parse(selectedProduct.quantity)
      };
    }).toList();
    Map<String, dynamic> body = {
      'customer_id': customerId,
      "invoice_items": invoiceItems
    };
    try {
      final response = await ApiHelper().post(
        url: ApiConstants.baseUrl + ApiConstants.createSaleOrderAndLineEndPoint,
        headers: header,
        body: body,
      );
      if (response['status'] != 200) {
        Get.snackbar(
          "Something went wrong. please try agin".tr,
          "",
          backgroundColor: Colors.red,
        );
      } else {
        Get.offAll(const MainControlScreen());
        Get.snackbar(
          "New Sale Order".tr,
          "Creating Success".tr,
          backgroundColor: Colors.green,
        );
      }
    } catch (e) {
      debugPrint("Error: ${e.toString()}");
      Get.snackbar(
        "Something went wrong. please try agin".tr,
        "",
        backgroundColor: Colors.red,
      );
    }
  }
}
