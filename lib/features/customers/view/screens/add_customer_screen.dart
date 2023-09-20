import 'package:cosmo_care/core/Constants/ui_constants.dart';
import 'package:cosmo_care/core/shared/methods/auth_validation.dart';
import 'package:cosmo_care/core/utils/enums/picked_image_source.dart';
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
import '../../../../core/shared/methods/picked_image_from_gallery_or_camera.dart';
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

  AddCustomerScreen(
      {Key? key,
      required this.governments,
      required this.payments,
      required this.types,
      required this.saleZone})
      : super(key: key);
  @override
  State<AddCustomerScreen> createState() => _AddCustomerScreenState();
}

class _AddCustomerScreenState extends State<AddCustomerScreen> {
  CustomerData customerData = CustomerData();
  List<CityModel> cities = [];
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController imageController = TextEditingController();
  String? customerImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add New Customer".tr,
        ),
      ),
      body: SizedBox(
        height: 1.sh,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("New Customer Data".tr),
                  CustomTextField(
                    prefixIconData: Iconsax.user,
                    hintText: "Customer Name".tr,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validate: (value) {
                      return userNameControllerValidator(value);
                    },
                    onChange: (value) {
                      customerData.name = value;
                    },
                  ),
                  SizedBox(height: 10.h),
                  CustomSingleSelectField<String>(
                    items: widget.types.map((e) => e.title!).toList(),
                    title: "Customers Types".tr,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Customers Types is Required".tr;
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
                        hintText: "Customers Types".tr),
                  ),
                  SizedBox(height: 10.h),
                  CustomSingleSelectField<String>(
                    items: widget.saleZone.map((e) => e.title!).toList(),
                    title: "Sale Zone".tr,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Sale Zone is Required".tr;
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
                    decoration:
                        selectionFiledDecoration(hintText: "Sale Zone".tr),
                  ),
                  SizedBox(height: 10.h),
                  CustomSingleSelectField<String>(
                    items: widget.payments.map((e) => e.title!).toList(),
                    title: "Payment Terms".tr,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Customers Payment is Required".tr;
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
                    decoration:
                        selectionFiledDecoration(hintText: "Payment Terms".tr),
                  ),
                  SizedBox(height: 10.h),
                  CustomTextField(
                    prefixIconData: Iconsax.location,
                    hintText: "Address".tr,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validate: (value) {
                      return addressControllerValidator(value);
                    },
                    onChange: (value) {
                      customerData.address = value;
                    },
                  ),
                  SizedBox(height: 10.h),
                  CustomTextField(
                    prefixIconData: Iconsax.user,
                    hintText: "Distinctive Address".tr,
                    validate: (value) {
                      return distinctiveAddressControllerValidator(value);
                    },
                    onChange: (value) {
                      customerData.distinctiveAddress = value;
                    },
                  ),
                  SizedBox(height: 10.h),
                  CustomSingleSelectField<String>(
                    items: widget.governments.map((e) => e.title!).toList(),
                    title: "Government".tr,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Government is Required".tr;
                      }
                      return null;
                    },
                    onSelectionDone: (value) async {
                      for (var item in widget.governments) {
                        if (item.title == value) {
                          customerData.governmentId = item.id;
                          List<CityModel> currentCities =
                              await CustomersController.getAllCustomerCities(
                                  govId: item.id!);
                          setState(() {
                            cities = currentCities;
                          });
                        }
                      }
                    },
                    itemAsString: (item) => item,
                    decoration:
                        selectionFiledDecoration(hintText: "Government".tr),
                  ),
                  SizedBox(height: 10.h),
                  CustomSingleSelectField<String>(
                      items: cities.map((e) => e.title!).toList(),
                      title: "City".tr,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "City is Required".tr;
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
                      decoration:
                          selectionFiledDecoration(hintText: "City".tr)),
                  SizedBox(height: 10.h),
                  CustomTextField(
                    prefixIconData: Iconsax.mobile,
                    hintText: "Phone Number".tr,
                    validate: (value) {
                      return phoneNumberControllerValidator(value);
                    },
                    onChange: (value) {
                      customerData.phoneNumber = value;
                    },
                  ),
                  SizedBox(height: 10.h),
                  CustomTextField(
                    prefixIconData: Icons.web,
                    hintText: "Website".tr,
                    onChange: (value) {
                      customerData.website = value;
                    },
                  ),
                  SizedBox(height: 10.h),
                  CustomTextField(
                    prefixIconData: Icons.email,
                    hintText: "Email".tr,
                    validate: (value) {
                      return emailControllerValidator(value);
                    },
                    onChange: (value) {
                      customerData.email = value;
                    },
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 6,
                        child: CustomTextField(
                          readOnly: true,
                          controller: imageController,
                          prefixIconData: Iconsax.image,
                          hintText: "Choose Image".tr,
                          validate: (p0) {
                            if (customerImage == null) {
                              return "Customer Image is Required".tr;
                            }
                            return null;
                          },
                          onTap: () async {
                            Get.bottomSheet(
                              SizedBox(
                                height: 100.h,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ListTile(
                                      leading: const Icon(Iconsax.camera),
                                      title: Text("Camera".tr),
                                      onTap: () async {
                                        String base64Image =
                                            await pickedImageFromGalleryOrCamera(
                                                imageSources:
                                                    PickedImageSources.camera);
                                        setState(() {
                                          customerImage = base64Image;
                                        });
                                        customerData.image = base64Image;
                                        imageController.text =
                                            customerImage == null
                                                ? "Choose Image".tr
                                                : "Image Selected ✅".tr;
                                        Get.back();
                                      },
                                    ),
                                    ListTile(
                                      leading: const Icon(Iconsax.gallery),
                                      title: Text("Photo Library".tr),
                                      onTap: () async {
                                        String base64Image =
                                            await pickedImageFromGalleryOrCamera(
                                                imageSources:
                                                    PickedImageSources.gallery);
                                        setState(() {
                                          customerImage = base64Image;
                                        });
                                        customerData.image = base64Image;
                                        imageController.text =
                                            customerImage == null
                                                ? "Choose Image".tr
                                                : "Image Selected ✅".tr;
                                        Get.back();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              elevation: 0,
                              backgroundColor: Colors.white,
                            );
                          },
                        ),
                      ),
                      (customerImage == null)
                          ? const SizedBox.shrink()
                          : Flexible(
                              child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      customerImage = null;
                                      imageController.text = "Choose Image".tr;
                                    });
                                    customerData.image = null;
                                  },
                                  child: Icon(
                                    Icons.highlight_remove_sharp,
                                    size: 40.sp,
                                    color: Colors.red,
                                  )),
                            )
                    ],
                  ),
                  SizedBox(height: 10.h),
                  CustomButton(
                    buttonColor: UiConstant.kCosmoCareCustomColors1,
                    buttonHeight: 40.h,
                    buttonText: "Next".tr,
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
