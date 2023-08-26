import 'package:cosmo_care/features/customers/model/payment_terms_model.dart';
import 'package:cosmo_care/features/customers/model/responsibility_model.dart';
import 'city_model.dart';
import 'customer_type_model.dart';
import 'government_model.dart';
import 'owner_model.dart';

class CustomerModel {
  final int id;
  final String title;
  final String status;
  final String address;
  final double lat;
  final double lng;
  final String? phone;
  final String? website;
  final String? email;
  final String? facebook;
  final String? image;
  final GovernmentModel? government;
  final CityModel? city;
  final int? invoiceType;
  final List<OwnerModel>? owners;
  final List<ResponsibilityModel>? responsiblies;
  final CustomerTypeModel? customerType;
  final PaymentTermsModel? paymentTerms;

  CustomerModel({
    required this.id,
    required this.title,
    required this.status,
    required this.address,
    required this.lat,
    required this.lng,
    this.phone,
    this.website,
    this.email,
    this.facebook,
    this.image,
    this.government,
    this.city,
    this.invoiceType,
    this.owners,
    this.responsiblies,
    this.customerType,
    this.paymentTerms,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      id: json['id'],
      title: json['title'],
      status: json['status'],
      address: json['address'],
      lat: json['lat'],
      lng: json['lng'],
      phone: json['phone'] is String ? json['phone'] : null,
      website: json['website'] is String ? json['website'] : null,
      email: json['email'] is String ? json['email'] : null,
      facebook: json['facebook'] is String ? json['facebook'] : null,
      image: json['image'] is String ? json['image'] : null,
      government: json['government'] != null ? GovernmentModel.fromJson(json['government']) : null,
      city: json['city'] != null ? CityModel.fromJson(json['city']) : null,
      invoiceType: json['invoice_type'],
      owners: (json['owners'] as List<dynamic>?)?.map((item) => OwnerModel.fromJson(item)).toList(),
      responsiblies: (json['responsiblies'] as List<dynamic>?)?.map((item) => ResponsibilityModel.fromJson(item)).toList(),
      customerType: json['customer_type'] != null ? CustomerTypeModel.fromJson(json['customer_type']) : null,
      paymentTerms: json['payment_terms'] != null ? PaymentTermsModel.fromJson(json['payment_terms']) : null,
    );
  }
}