import 'package:cosmo_care/core/Constants/ui_constants.dart';
import 'package:cosmo_care/core/shared/methods/auth_validation.dart';
import 'package:cosmo_care/core/widgets/widgets/custom_text_field.dart';
import 'package:cosmo_care/features/customers/model/city_model.dart';
import 'package:cosmo_care/features/customers/model/customer_type_model.dart';
import 'package:cosmo_care/features/customers/model/government_model.dart';
import 'package:cosmo_care/features/customers/model/payment_terms_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_selector/widget/flutter_single_select.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/widgets/widgets/custom_button_widget.dart';
import '../../controller/customers_controller.dart';
import '../../model/create_customer_modeling.dart';
import '../../model/sale_zone_model.dart';
import 'add_responsible_screen.dart';

// ignore: must_be_immutable
class AddCustomerScreen extends StatefulWidget {
  List<CustomerTypeModel> types;
  List<PaymentTermsModel> payments;
  List<GovernmentModel> governments;
  List<SaleZoneModel> saleZone;

  AddCustomerScreen({Key? key, required this.governments, required this.payments, required this.types, required this.saleZone}) : super(key: key);
  @override
  State<AddCustomerScreen> createState() => _AddCustomerScreenState();
}

class _AddCustomerScreenState extends State<AddCustomerScreen> {
  CustomerData customerData = CustomerData();
  List<CityModel> cities = [];
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add New Customer",
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height + 50,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text("New Customer Data"),
                  CustomTextField(
                    prefixIconData: Iconsax.user,
                    hintText: "Customer Name",
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validate: (value) {
                      return userNameControllerValidator(value);
                    },
                    onChange: (value) {
                      customerData.name = value;
                    },
                  ),
                  CustomSingleSelectField<String>(
                    items:
                        widget.types.map((e) => e.title!).toList(),
                    title: "Customers Types",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Customers Types is Required";
                      }
                      return null;
                    },
                    onSelectionDone: (value) {
                      for (var item in widget.types) {
                        if (item.title == value) {
                          customerData.customerTypeId = item.id;
                        }
                      }
                    },
                    itemAsString: (item) => item,
                    decoration: selectionFiledDecoration(
                        hintText: "Customer Type"),
                  ),
                  CustomSingleSelectField<String>(
                    items:
                        widget.saleZone.map((e) => e.title!).toList(),
                    title: "Sale Zone",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Sale Zone is Required";
                      }
                      return null;
                    },
                    onSelectionDone: (value) {
                      for (var item in widget.saleZone) {
                        if (item.title == value) {
                          customerData.saleZoneId = item.id;
                        }
                      }
                    },
                    itemAsString: (item) => item,
                    decoration: selectionFiledDecoration(
                        hintText: "Sale Zone"),
                  ),
                  CustomSingleSelectField<String>(
                    items: widget.payments.map((e) => e.title!).toList(),
                    title: "Payment Terms",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Customers Types is Req";
                      }
                      return null;
                    },
                    onSelectionDone: (value) {
                      for (var item in widget.payments) {
                        if (item.title == value) {
                          customerData.paymentTermId = item.id;
                        }
                      }
                    },
                    itemAsString: (item) => item,
                    decoration: selectionFiledDecoration(
                        hintText: "Payment Terms"),
                  ),
                  CustomTextField(
                    prefixIconData: Iconsax.location,
                    hintText: "Address",
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validate: (value) {
                      return addressControllerValidator(value);
                    },
                    onChange: (value) {
                      customerData.address = value;
                    },
                  ),
                  CustomTextField(
                    prefixIconData: Iconsax.user,
                    hintText: "Distinctive Address",
                    validate: (value) {
                      return distinctiveAddressControllerValidator(value);
                    },
                    onChange: (value) {
                      customerData.distinctiveAddress = value;
                    },
                  ),
                  CustomSingleSelectField<String>(
                    items:widget.governments.map((e) => e.title!).toList(),
                    title: "Government",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Customers Types is Req";
                      }
                      return null;
                    },
                    onSelectionDone: (value) async {
                      for (var item in widget.governments) {
                        if (item.title == value) {
                          customerData.governmentId = item.id;
                          List<CityModel> currentCities =
                              await CustomersController
                                  .getAllCustomerCities(govId: item.id!);
                          setState(() {
                            cities = currentCities;
                          });
                        }
                      }
                    },
                    itemAsString: (item) => item,
                    decoration:
                        selectionFiledDecoration(hintText: "Government"),
                  ),
                  CustomSingleSelectField<String>(
                      items: cities.map((e) => e.title!).toList(),
                      title: "City",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Customers Types is Req";
                        }
                        return null;
                      },
                      onSelectionDone: (value) {
                        for (var item in cities) {
                          if (item.title == value) {
                            customerData.cityId = item.id;
                          }
                        }
                      },
                      itemAsString: (item) => item,
                      decoration: selectionFiledDecoration(hintText: "City")),
                  CustomTextField(
                    prefixIconData: Iconsax.mobile,
                    hintText: "Phone Number",
                    validate: (value) {
                      return phoneNumberControllerValidator(value);
                    },
                    onChange: (value) {
                      customerData.phoneNumber = value;
                    },
                  ),
                  CustomTextField(
                    prefixIconData: Icons.web,
                    hintText: "Website",
                    onChange: (value) {
                      customerData.website = value;
                    },
                  ),
                  CustomTextField(
                    prefixIconData: Icons.email,
                    hintText: "Email",
                    validate: (value) {
                      return emailControllerValidator(value);
                    },
                    onChange: (value) {
                      customerData.email = value;
                    },
                  ),
                  CustomButton(
                    buttonColor: UiConstant.kCosmoCareCustomColors1,
                    buttonHeight: 40.h,
                    buttonText: "Next",
                    buttonWidth: MediaQuery.of(context).size.width / 1.5,
                    buttonAction: () {
                      if (formKey.currentState!.validate()) {
                        Get.to(() => AddResponsibleScreen(
                              customerData: customerData,
                            ));
                      }
                    },
                    buttonMargin: 10,
                    buttonTextFontSize: 14.sp,
                    buttonBorderRadius: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  selectionFiledDecoration({required hintText}) {
    return InputDecoration(
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: UiConstant.kCosmoCareCustomColors1,
          style: BorderStyle.solid,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: Colors.red,
          style: BorderStyle.solid,
        ),
      ),
      contentPadding: const EdgeInsets.all(15),
      hintText: hintText,
    );
  }
}
